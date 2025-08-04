import 'package:dr_time/screens/add.dart';
import 'package:dr_time/screens/viewMedPage.dart';
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

                Material( color: Colors.transparent,
                child: InkWell(
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewMedPage(medName: "Lamotrigine 200 mg",imagePath:"images/lamo.jpg" ,) ));},
                child: 
                SizedBox(height: 70,
                child: Row( crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  SizedBox(width: 100,height: 100, child: Image.asset("images/lamo.jpg",fit: BoxFit.cover),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Lamotrigine 200 mg", style:TextStyle(fontSize:16),),
                  ),

                  ],
                  ),
                  ),
                ),
                ),
                Divider(thickness: 1,indent: 20,endIndent: 20,),
                SizedBox(height: 15,),
                                Material( color: Colors.transparent,
                child: InkWell(
                 onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewMedPage(medName: "Levacetam 500 mg",imagePath:"images/leva.jpg" ,) ));},
                 child:
                SizedBox(height: 50,
                child: Row( crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                  SizedBox(width: 100,height: 100, child: Image.asset("images/leva.jpg",fit: BoxFit.cover),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Levacetam 500 mg", style:TextStyle(fontSize:16),),
                  ),
 
                  ],
                  ),
                ),
                ),
                  ),

               const Divider(thickness: 1,indent: 20,endIndent: 20,),
                               SizedBox(height: 15,),
                               Material(color: Colors.transparent,
                               child: InkWell(
                                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewMedPage(medName: "Paracetamol 1000 mg",imagePath:"images/para.jpg" ,) ));},
                                child: 
                                SizedBox(height: 50,
                child: Row( crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  SizedBox(width: 100,height: 100, child: Image.asset("images/para.jpg",fit: BoxFit.cover),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Paracetamol 1000 mg", style:TextStyle(fontSize:16),),
                  ),
                  ],
                  ),
                  ),
                  ),
                  ),
               const Divider(thickness: 1,indent: 20,endIndent: 20,),
                                              SizedBox(height: 15,),
                                              Material(color: Colors.transparent,
                                              child: InkWell(
                                                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewMedPage(medName: "Rampil 5 mg",imagePath:"images/ram.jpg" ,) ));},
                                                child: 
                                SizedBox(height: 50,
                child: Row( crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  SizedBox(width: 100,height: 100, child: Image.asset("images/ram.jpg",fit: BoxFit.cover),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Ramipril 5 mg", style:TextStyle(fontSize:16),),
                  ),
 
                  ],),
                   ),
                   ),
                  ),
               const Divider(thickness: 1,indent: 20,endIndent: 20,),
                              SizedBox(height: 15,),
                              Material(color: Colors.transparent,
                                   child: InkWell(
                                   onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewMedPage(medName: "Atorvastatin 20 mg", imagePath: "images/ato.jpg")));},
                                   child: 
                                SizedBox(height: 50,
                child: Row( crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  SizedBox(width: 100,height: 100, child: Image.asset("images/ato.jpg",fit: BoxFit.cover),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Atorvastatin 20 mg", style:TextStyle(fontSize:16),),
                  ),
 
                  ],),
                     ),
                     ),
                  ),
               const Divider(thickness: 1,indent: 20,endIndent: 20,),
               
               
              ],

            ),
          )
        ],
      ),
    );
  }
} 