import 'package:dr_time/Theme/medCard.dart';
import 'package:dr_time/screens/add.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {    //HomePage
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {


    return  Scaffold(

      body: Column(
        children: [
          Image.asset("images/med3.jpg"),
          SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Material(color: Colors.transparent,    // add als button
              child: InkWell(
                onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=> AddPage() ));},
                child:
               Row(
                children: [
                  Text("Add", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue),),  //Add
                  Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Icon(Icons.add_circle_outline, color: Colors.blue,),
              ), 
                ],
             
              ),
              ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              padding:const EdgeInsets.only(left: 8),
              children:<Widget> [
                
                MedCard(medName: "Lamotrigine 200 mg", imagePath: "images/lamo.jpg", info: "3 mal pro Tag nach dem Essen",),

                Divider(thickness: 1,indent: 20,endIndent: 20,),
                SizedBox(height: 10,),

                MedCard(medName: "Levacetam 500 mg", imagePath: "images/leva.jpg", info: "2 ,mal pro Tag nach dem Essen",),

               const Divider(thickness: 1,indent: 20,endIndent: 20,),
               SizedBox(height: 10,),

               MedCard(medName: "Paracetamol 1000 mg", imagePath: "images/para.jpg", info: "1 mal nach dem Essen",),   
               const Divider(thickness: 1,indent: 20,endIndent: 20,),
               SizedBox(height: 10,),

               MedCard(medName: "Ramipril 5 mg", imagePath: "images/ram.jpg", info: "1 mal vor dem Essen morghens",),
               const Divider(thickness: 1,indent: 20,endIndent: 20,),
               SizedBox(height: 10,),

               MedCard(medName: "Atrovastatin 20 mg", imagePath: "images/ato.jpg",info: "1 mal bevor schlafen",),
               const Divider(thickness: 1,indent: 20,endIndent: 20,),
               
               
              ],

            ),
          )
        ],
      ),
    );
  }
} 