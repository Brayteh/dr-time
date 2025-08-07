import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true,),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 25,),

          Padding(
                    padding: EdgeInsets.only(left: 16),  // Sign Up
                    child: Text("Sign up", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 40,),
            Padding(padding: EdgeInsets.only(left: 18), // First name
            child: 
            Text("First name", style: TextStyle(fontSize: 20),),
            ),

            Padding(                                   // Border
              padding:EdgeInsetsGeometry.all(18),
              child: TextField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  label: Text("enter your name"),),
              ),
              ),
            Padding(padding: EdgeInsets.only(left: 18),
            child: 
            Text("Last name", style: TextStyle(fontSize: 20),), // Last name
            ),

              Padding(
              padding:EdgeInsetsGeometry.all(18),    //Border
              child: TextField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  label: Text("enter your last name"),),
              ),
              ),
            Padding(padding: EdgeInsets.only(left: 18),    //Date of birth
            child: 
               Text("Date of birth", style: TextStyle(fontSize: 20),),    
            ),

              Padding(                                      // Border
              padding:EdgeInsetsGeometry.all(18),
              child: TextField(
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  label: Text("enter your date of birth"),),
              ),
              ),
            Padding(padding: EdgeInsets.only(left: 18),         // Email
            child: 
                Text("Email address", style: TextStyle(fontSize: 20),),
            ),

              Padding(                                           // Border
              padding:EdgeInsetsGeometry.all(18),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  label: Text("enter your Email address"),),
              ),
              ),

            Center(                                                      // Sign Up button 
              child: SizedBox(
              width: 200, // العرض المطلوب
              child: ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 2,backgroundColor: const Color.fromARGB(255, 68, 202, 232)),
              onPressed: () {},
              child:
                 Text("Sign Up",style:TextStyle(fontSize: 23,fontWeight: FontWeight.bold, color: Colors.white),),
          ),
         ),
        ),
        SizedBox(height: 3,),
        Center(child:
             Text("or login with", style: TextStyle(color: Colors.lightBlue),), //or login with
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: SizedBox(
                  height: 60,
                  child: Icon(Icons.apple),
                ),
              ),
              Icon(Icons.mail),
            ],
          ),   
              
          
          
        ],
      ),
    );
  }
}



