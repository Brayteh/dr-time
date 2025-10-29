import 'package:dr_time/Theme/medCard.dart';
import 'dart:async';
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
  Timer? _timer;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // Listen to auth state changes
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (mounted) {
        setState(() => _user = user);
        if (user != null) {
          _startTimer();
          _checkMedicamentTimes(); // Initial check
        } else {
          _timer?.cancel();
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    // Cancel any existing timer
    _timer?.cancel();
    // Check times every minute
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (mounted) _checkMedicamentTimes();
    });
  }

  void _checkMedicamentTimes() async {
    // Use the context from the GlobalKey to ensure it's valid.
    final currentContext = _scaffoldKey.currentContext;
    if (currentContext == null || !currentContext.mounted) {
      return;
    }

    final db = Provider.of<DatabaseRepository>(currentContext, listen: false);    
    final now = DateTime.now();

    final medicaments = await db.readAllMedicamente();

    for (final med in medicaments) {
      final medTime = _parseTimeOfDay(med.time);
      if (medTime != null) {
        final medDateTime = DateTime(
          now.year,
          now.month,
          now.day,
          medTime.hour,
          medTime.minute,
        );

        // Check if the difference is within a minute.
        final difference = now.difference(medDateTime).inMinutes;
        if (difference == 0) {
          ScaffoldMessenger.of(currentContext).showSnackBar(
            SnackBar(
              content: Text("It's time to take your medicament: ${med.medName}"),
              duration: const Duration(seconds: 10),
              action: SnackBarAction(label: "OK", onPressed: () {}),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    }
  }

  // Helper function to parse time strings regardless of 12/24 hour format.
  TimeOfDay? _parseTimeOfDay(String timeString) {
    try {
      final timeParts = timeString.replaceAll(RegExp(r'[a-zA-Z]'), '').trim().split(':');
      if (timeParts.length >= 2) {
        final hour = int.parse(timeParts[0]);
        final minute = int.parse(timeParts[1]);

        if (timeString.toLowerCase().contains('pm') && hour < 12) {
          return TimeOfDay(hour: hour + 12, minute: minute);
        } else if (timeString.toLowerCase().contains('am') && hour == 12) {
          return TimeOfDay(hour: 0, minute: minute); // Midnight case
        }
        return TimeOfDay(hour: hour, minute: minute);
      }
    } catch (e) {
      // Could not parse, return null
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final db = context.watch<DatabaseRepository>();

    return Scaffold(
      key: _scaffoldKey,
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
