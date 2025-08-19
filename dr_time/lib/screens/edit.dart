import 'package:dr_time/domain/medicament.dart';

import '../data/database_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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




              // mo7adis Medicament
  void saveChanges(){
    final updatedMed = Medicament(id: widget.id,
       imagePath: imageController.text,
       medName: nameController.text,
       dosis: dosisController.text,
       info: infoController.text);
    widget.db.updateMedicament(widget.id, updatedMed);

    Navigator.pop(context); // ein mal zurück
    Navigator.pop(context); // zwei mal zurück home page

  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.medName);
    dosisController = TextEditingController(text: widget.dosis);
    infoController = TextEditingController(text: widget.info);
    imageController = TextEditingController(text: widget.imagePath);
  }

  @override // man3 tasarob zekra
  void dispose() {
    nameController.dispose();
    dosisController.dispose();
    infoController.dispose();
    imageController.dispose();
    super.dispose();
  }
  void _pickImage() async{
    final picker = ImagePicker();
    final PickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (PickedFile != null){
      setState(() {
        imageController.text = PickedFile.path;
      });
    }
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
            GestureDetector(
              onTap: _pickImage,
              child: AbsorbPointer(
                child: TextField(
                  controller: imageController,
                  decoration: const InputDecoration(
                    labelText: "Image Path",
                    suffixIcon: Icon(Icons.photo_library),
                    ),
                ),
              ),
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
