import 'package:dr_time/Theme/medCard.dart';
import 'package:dr_time/data/database_repository.dart';
import 'package:dr_time/domain/medicament.dart';
import 'package:dr_time/screens/add.dart';
import 'package:dr_time/screens/viewMedPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? _user;

  @override
  void initState() {
    super.initState();
    // Listen to auth state changes
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (mounted) setState(() => _user = user);
    });
  }

  @override
  Widget build(BuildContext context) {
    final db = context.watch<DatabaseRepository>();

    return Scaffold(
      body: Column(
        children: [
          Image.asset("images/med3.jpg"),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddPage(),
                      ),
                    ).then((_) {
                      setState(() {}); // update nach adden
                    });
                  },
                  child: Row(
                    children: const [
                      Text(
                        "Add",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Icon(
                          Icons.add_circle_outline,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),          
          Expanded(
            child: _user == null
                ? const Center(child: CircularProgressIndicator())
                : StreamBuilder<List<Medicament>>(
              stream: db.readAllMedicamenteStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text(
                    'No medicaments found. Click "Add" to start.',
                    textAlign: TextAlign.center,
                  ));
                }

                final meds = snapshot.data!;
                return ListView.builder(
                  padding: const EdgeInsets.only(left: 8),
                  itemCount: meds.length,
                  itemBuilder: (context, index) {
                    final med = meds[index];
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewMedPage(
                                  medicament: med,
                                ),
                              ),
                            ).then((_) {
                              setState(() {}); // هذا مهم لتحديث القائمة بعد الحذف
                            });
                          },
                          child: MedCard(
                            id: int.tryParse(med.id) ?? 0,
                            medName: med.medName,
                            dosis: med.dosis,
                            imagePath: med.imagePath,
                            info: med.info,
                            time: med.time,
                          ),
                        ),
                        const Divider(thickness: 1, indent: 20, endIndent: 20),
                        const SizedBox(height: 10),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
