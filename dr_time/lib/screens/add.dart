import 'dart:io';
import 'package:dr_time/data/database_repository.dart';
import 'package:dr_time/domain/medicament.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPage extends StatefulWidget {
  final DatabaseRepository db;

  const AddPage({super.key, required this.db});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController doseController = TextEditingController();
  final TextEditingController infoController = TextEditingController();

  File? _selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Add",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),

            // Name
            _buildLabel("Name of Medicament"),
            _buildTextField(nameController, "your new medicament"),

            // Dose
            _buildLabel("Dose"),
            _buildTextField(doseController, "the dose of your medicament"),

            // Info
            _buildLabel("Info"),
            _buildTextField(infoController, "exp: the number of times per day"),

            // زر اختيار صورة
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _selectedImage != null
                      ? Image.file(_selectedImage!, height: 150)
                      : const Icon(Icons.image, size: 100, color: Colors.grey),
                  IconButton(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.add_a_photo, size: 32, color: Colors.blue),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Save button
            Center(
              child: SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    backgroundColor: const Color.fromARGB(255, 68, 202, 232),
                  ),
                  onPressed: () {
                    final newId = widget.db.readAllMedicamente().length + 1;

                    final newMed = Medicament(
                      id: newId,
                      imagePath: _selectedImage?.path ?? "images/default.avif",
                      medName: nameController.text,
                      dosis: doseController.text,
                      info: infoController.text,
                    );

                    widget.db.createMedicament(newMed);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(text, style: const TextStyle(fontSize: 22)),
    );
  }

  Padding _buildTextField(TextEditingController controller, String hint) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: hint),
      ),
    );
  }
}
