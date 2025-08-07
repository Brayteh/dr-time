import 'package:dr_time/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 99,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text("Profile",style:TextStyle(fontSize: 32,fontWeight: FontWeight.bold),  ),   //profile
                ),
                Padding(padding: EdgeInsets.only(right: 16),
                child: IconButton(
                  icon: Icon(Icons.power_settings_new,color: Colors.red,size: 33,),
                  onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context)=> LogInPage()));},
                  ),
                  ),
            ],
          ),
          SizedBox(height: 25,),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text("First name",style: TextStyle(fontSize: 22),), // first name
          ),
          Padding(padding: EdgeInsets.all(16),   //Border
          child: TextField( keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hintText: "your name",
            ),
          ),
          ),
          SizedBox(height: 15,),
          Padding(padding: EdgeInsets.only(left: 16),
          child: Text("Last name",style: TextStyle(fontSize: 22),),  //last name
          ),
             Padding(padding: EdgeInsets.all(16),   //Border
          child: TextField( keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hintText: "your last name",
            ),
          ),
          ),
          SizedBox(height: 15,),
          Padding(padding: EdgeInsets.only(left: 16),
          child: Text("Date of birth",style: TextStyle(fontSize: 22),),   //date of birth
          ),
          Padding(padding: EdgeInsets.all(16),
          child: TextField(
            keyboardType: TextInputType.datetime,
            decoration: InputDecoration(
              hintText: "your date of birth",
            ),
          ),
          ),
          SizedBox(height: 15,),
          Padding(padding: EdgeInsetsGeometry.only(left: 16),
          child: Text("Disease name",style: TextStyle(fontSize: 22),),
          ),
          Padding(padding: EdgeInsets.all(16),
          child: TextField( keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: "your disease name",
            ),
          ),
          ),
                  Center(                                                      // Save button 
              child: SizedBox(
              width: 200, // العرض المطلوب
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