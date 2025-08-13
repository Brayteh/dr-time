import 'package:dr_time/Theme/medCard.dart';
import 'package:dr_time/screens/add.dart';
import 'package:dr_time/screens/viewMedPage.dart';
import 'package:flutter/material.dart';

import '../data/database_repository.dart';


class HomePage extends StatefulWidget {
  final DatabaseRepository db;
  const HomePage({super.key, required this.db});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final meds = widget.db.readAllMedicamente();

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
                        builder: (context) => AddPage(db: widget.db),
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
            child: ListView.builder(
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
                       db: widget.db,
                       id: med.id,
                       medName: med.medName,
                       imagePath: med.imagePath,
                       info: med.info,
                       dosis: med.dosis,
                           ),
                          ),
                           ).then((_) {
                           setState(() {}); // هذا مهم لتحديث القائمة بعد الحذف
                          });
                           },
                      child: MedCard(
                        id: med.id,
                        medName: med.medName,
                        dosis: med.dosis,
                        imagePath: med.imagePath,
                        info: med.info,
                      ),
                    ),
                    const Divider(thickness: 1, indent: 20, endIndent: 20),
                    const SizedBox(height: 10),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
