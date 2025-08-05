import 'package:dr_time/screens/viewMedPage.dart';
import 'package:flutter/material.dart';

class MedCard extends StatelessWidget {
 final String medName;
 final String imagePath;
 final String info;
   MedCard({super.key, required this.medName, required this.imagePath, required this.info});

  @override
  Widget build(BuildContext context) {
    return Material (

                color: Colors.transparent,
                child: InkWell(
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewMedPage(medName: medName, imagePath:imagePath, info:info) ));},
                child: 
                SizedBox(height: 70,
                child: Row( crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  SizedBox(width: 100,height: 100, child: Image.asset(imagePath, fit: BoxFit.cover),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(medName, style:TextStyle(fontSize:16),),
                  ),

                  ],
                  ),
                  ),
                ),
    );

  }
}