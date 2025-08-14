import 'package:dr_time/domain/medicament.dart';

import '../data/database_repository.dart';
import 'package:flutter/material.dart';

class EditMedPage extends StatefulWidget {
  final DatabaseRepository db;
  final int id;
  final String medName;
  final String dosis;
  final String imagePath;
  final String info;

  const EditMedPage({
    super.key,
    required this.db,
    required this.id,
    required this.medName,
    required this.dosis,
    required this.imagePath,
    required this.info,
  });

  @override
  State<EditMedPage> createState() => _EditMedPageState();
}

class _EditMedPageState extends State<EditMedPage> {
  late TextEditingController nameController;
  late TextEditingController dosisController;
  late TextEditingController infoController;
  late TextEditingController imageController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.medName);
    dosisController = TextEditingController(text: widget.dosis);
    infoController = TextEditingController(text: widget.info);
    imageController = TextEditingController(text: widget.imagePath);
  }

  @override
  void dispose() {
    nameController.dispose();
    dosisController.dispose();
    infoController.dispose();
    imageController.dispose();
    super.dispose();
  }

void saveChanges() {
  final updatedMed = Medicament(
    id: widget.id,
    medName: nameController.text,
    dosis: dosisController.text,
    imagePath: imageController.text,
    info: infoController.text,
  );

  widget.db.updateMedicament(widget.id, updatedMed);
  Navigator.pop(context);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Medicament"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: dosisController,
              decoration: const InputDecoration(labelText: "Dosis"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: imageController,
              decoration: const InputDecoration(labelText: "Image Path"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: infoController,
              decoration: const InputDecoration(labelText: "Info"),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveChanges,
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
