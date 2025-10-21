import 'package:dr_time/data/database_repository.dart';
import 'package:dr_time/screens/edit.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dr_time/domain/medicament.dart'; // Importiere Medicament-Klasse

class ViewMedPage extends StatelessWidget {
  final Medicament medicament; // Verwende Medicament-Klasse

  const ViewMedPage({
    super.key,
    required this.medicament,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(medicament.medName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // زر التعديل
                IconButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditMedPage( // Cast db to FirestoreDatabaseRepository
                          medicament: medicament,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit),
                ),

                // زر الحذف
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("Delete"),
                        content: const Text(
                            "Do you want to delete this medicament?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: const Text("Cancel"),
                          ),
                          // زر الحذف
                          TextButton(
                            onPressed: () async {
                              final db = context.read<DatabaseRepository>();
                              await db.deleteMedicament(medicament.id);
                              Navigator.of(ctx).pop();
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "Delete",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                        // زر الحذف
                      ),
                    );
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
            // Use Image.file for local paths and Image.asset for bundled assets
            medicament.imagePath.startsWith('images/')
                ? Image.asset(
                    medicament.imagePath,
                    width: 200, height: 200, fit: BoxFit.cover,
                  )
                : Image.file(
                    File(medicament.imagePath),
                    width: 200, height: 200, fit: BoxFit.cover,
                  ),
            const SizedBox(height: 20),
            Text(
              medicament.medName,
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              medicament.dosis,
              style: const TextStyle(fontSize: 18, color: Colors.blue),
            ),
            const SizedBox(height: 10),
            Text(
              medicament.info,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              // ignore: unnecessary_null_comparison
              medicament.time != null ? 'Time: ${medicament.time}' : 'No time set',
              style: const TextStyle(fontSize: 16, color: Colors.green),
              // ignore: unnecessary_null_comparison
            ),
          ],
        ),
      ),
    );
  }
}
