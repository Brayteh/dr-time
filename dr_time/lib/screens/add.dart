import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true,),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           SizedBox(
            height: 20,),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Add",style:TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),   // Add
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Name of Medicament",style:TextStyle(fontSize: 22,),),    // name of med
          ),
          Padding(padding: EdgeInsets.all(16),
          child: TextField( keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: "your new medicament",
            ),
          ),
          ),
          SizedBox(height: 5,),
          Padding(padding: EdgeInsets.all(16),
          child: Text("Dose",style:TextStyle(fontSize: 22,),),    // Dose
          ),
            Padding(padding: EdgeInsets.all(16),
          child: TextField( keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: "the dose of your medicament",
            ),
          ),
          ),
          SizedBox(height: 5,),
          Padding(padding: EdgeInsets.all(16),
          child: Text("How much per day",style:TextStyle(fontSize: 22,),),     // how much
          ),
            Padding(padding: EdgeInsets.all(16),
          child: TextField(
            keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),   // keyboard numbers just positive numbers
            decoration: InputDecoration(
              hintText: "the number of times per day",
            ),
          ),
          ),
          SizedBox(height: 20,),
                  Center(                                                      // Add button 
              child: SizedBox(
              width: 200,            // العرض المطلوب
              child: ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 2,backgroundColor: const Color.fromARGB(255, 68, 202, 232)),
              onPressed: () {},
              child:
                 Text("Save",style:TextStyle(fontSize: 23,fontWeight: FontWeight.bold, color: Colors.white),),
          ),
         ),
        ),



        ],
      ),
    );
  }
}