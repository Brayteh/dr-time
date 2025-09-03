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
  final String time;

  const EditMedPage({
    super.key,
    required this.db,
    required this.id,
    required this.medName,
    required this.dosis,
    required this.imagePath,
    required this.info,
    required this.time,
  });

  @override
  State<EditMedPage> createState() => _EditMedPageState();
}

class _EditMedPageState extends State<EditMedPage> {
  late TextEditingController nameController;
  late TextEditingController dosisController;
  late TextEditingController infoController;
  late TextEditingController imageController;
  late TextEditingController timeController;
  TimeOfDay? selectedTime; // for time picker




              // mo7adis Medicament
  void saveChanges() {
    final updatedMed = Medicament(
      id: widget.id,
      imagePath: imageController.text,
      medName: nameController.text,
      dosis: dosisController.text,
      info: infoController.text,
      time: timeController.text.isEmpty? 'undefined ': timeController.text,
    );

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
    timeController = TextEditingController(text: widget.time);

  }

  @override // man3 tasarob zekra
  void dispose() {
    nameController.dispose();
    dosisController.dispose();
    infoController.dispose();
    imageController.dispose();
    timeController.dispose();
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

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        timeController.text = picked.format(context);
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
            const SizedBox(height: 10),
            InkWell(
              onTap: _pickTime,
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: "Time",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.access_time),
                ),
                child: Text(
                  timeController.text.isNotEmpty ? timeController.text : "Time not selected" ,
                ),
              ),
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
