import 'package:dr_time/screens/edit.dart';
import 'package:flutter/material.dart';
import '../data/database_repository.dart';

class ViewMedPage extends StatelessWidget {
  final DatabaseRepository db;
  final int id;
  final String medName;
  final String dosis;
  final String imagePath;
  final String info;

  const ViewMedPage({
    super.key,
    required this.db,
    required this.id,
    required this.medName,
    required this.dosis,
    required this.imagePath,
    required this.info,
  });

  void deleteMed(BuildContext context) {
    db.deleteMedicament(id); // حذف من قاعدة البيانات
    Navigator.pop(context); // العودة للصفحة السابقة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(medName),
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
                        builder: (context) => EditMedPage(
                          db: db,
                          id: id,
                          medName: medName,
                          dosis: dosis,
                          imagePath: imagePath,
                          info: info,
                        ),
                      ),
                    );
                    // تحديث الصفحة بعد التعديل
                    (context as Element).reassemble();
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
                          TextButton(
                            onPressed: () {
                              db.deleteMedicament(id);
                              Navigator.of(ctx).pop();
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "Delete",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),

            Image.asset(
              imagePath,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              medName,
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              dosis,
              style: const TextStyle(fontSize: 18, color: Colors.blue),
            ),
            const SizedBox(height: 10),
            Text(
              info,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
