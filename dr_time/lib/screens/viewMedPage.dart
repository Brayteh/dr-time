import 'package:flutter/material.dart';

class ViewMedPage extends StatelessWidget {
  final String medName;
  final String imagePath;
  final String info;

  const ViewMedPage({super.key, required this.medName, required this.imagePath, required this.info,});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(medName),
      ),
      body: Center(
        child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
          Image.asset(imagePath, width: 200,height: 200,fit: BoxFit.cover,),

          const SizedBox(height: 20,),
          Text(medName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
          
          SizedBox(height: 10,),
          Text(info, style:TextStyle(fontSize: 16),textAlign: TextAlign.center,),
         ],

        ),
      ),
    );
  }
}