
import '../data/database_repository.dart';

import 'package:flutter/material.dart';

class EditMedPage extends StatefulWidget {

  final DatabaseRepository db;
  final int id;
  final String medName;
  final String dosis;
  final String imagePath;
  final String info;

  const EditMedPage({super.key, required this.db, required this.id,required this.medName,required this.dosis,required this.imagePath,required this.info,});

  @override
  State<EditMedPage> createState() => _EditMedPageState();
}

class _EditMedPageState extends State<EditMedPage> {
  
  late TextEditingController nameController;
  late TextEditingController dosisController;
  late TextEditingController infoController;
  late TextEditingController imageController;
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}