import 'package:dr_time/Theme/switch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool term = false;
  final  emailController = TextEditingController();
  final  passwordController = TextEditingController();
  final  confirmController = TextEditingController();

  Future<void> _register() async {
    if (!term) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("please accept the terms and conditions")),
      );
      return;
    }
    if (passwordController.text != confirmController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }
    try {
  await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: emailController.text.trim(),
    password: passwordController.text,
  );

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("✅ Registration successful")),
  );

  Navigator.pop(context); // Back to Login Page
} on FirebaseAuthException catch (e) {
  String message = "";
  if (e.code == 'email-already-in-use') {
    message = "📧 This email is already in use";
  } else if (e.code == 'invalid-email') {
    message = "❌ The email format is invalid";
  } else if (e.code == 'weak-password') {
    message = "🔑 The password is too weak (minimum 6 characters)";
  } else {
    message = "⚠️ Unexpected error: ${e.message}";
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
} catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("⚠️ Unknown error")),
  );
}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true,),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,),
        
            Padding(
                      padding: EdgeInsets.only(left: 16),  // Sign Up
                      child: Text("Sign up", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20,),
              Padding(padding: EdgeInsets.only(left: 10), // First name
              child: 
              Text("First name", style: TextStyle(fontSize: 20),),
              ),
        
              Padding(                                   // Border
                padding: EdgeInsets.all(10),

                child: TextField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    label: Text("enter your name"),),
                ),
                ),
              Padding(padding: EdgeInsets.only(left: 10),
              child: 
              Text("Last name", style: TextStyle(fontSize: 20),), // Last name
              ),
        
                Padding(
                padding: EdgeInsets.all(10), //Border
                child: TextField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    label: Text("enter your last name"),),
                ),
                ),
              Padding(padding: EdgeInsets.only(left: 10),    //Date of birth
              child: 
                 Text("Date of birth", style: TextStyle(fontSize: 20),),    
              ),
        
                Padding(                                      // Border
                padding: EdgeInsets.all(10),
                child: TextField(
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    label: Text("enter your date of birth"),),
                ),
                ),
              Padding(padding: EdgeInsets.only(left: 10),         // Email
              child: 
                  Text("Email address", style: TextStyle(fontSize: 20),),
              ),
        
                Padding(                                           // Border
                padding: EdgeInsets.all(10),
                 child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    label: Text("enter your Email address"),),
                ),
                ),
               Padding(padding: EdgeInsets.only(left: 10),         // Email
                child: 
                  Text("Password", style: TextStyle(fontSize: 20),),
              ),
                Padding(                                           // Border
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    label: Text("enter your password"),),
                ),
                ),
               Padding(padding: EdgeInsets.only(left: 10),         // Email
                 child: 
                  Text("Confirm Password", style: TextStyle(fontSize: 20),),
              ),
                Padding(                                           // Border
                   padding: EdgeInsets.all(10),
                  child: TextField( obscureText: true,
                  controller: confirmController,
                  decoration: InputDecoration(
                    label: Text("confirm your password"),),
                ),
                ),
        
              Center(                                                      // Sign Up button 
                child: SizedBox(
                width: 200, // العرض المطلوب
                child: ElevatedButton(
                style: ElevatedButton.styleFrom(elevation: 2,backgroundColor: const Color.fromARGB(255, 68, 202, 232)),
                onPressed: _register,
                child:
                   Text("Sign Up",style:TextStyle(fontSize: 23,fontWeight: FontWeight.bold, color: Colors.white),),
            ),
           ),
          ),
          SizedBox(height: 8),
          Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text("I have read the terms and conditions",style: Theme.of(context).textTheme.labelLarge,),
               ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SwitchExample(value: term,
                         onChanged: (bool value) {setState(() {
                           term = value;
                         });}
                         ),
                      ),
          ],),
          Center(child:
               Text("or login with", style: TextStyle(color: Colors.lightBlue),), //or login with
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: SizedBox(
                    height: 60,
                    child: IconButton(onPressed: (){}, icon: Icon(Icons.apple)),
                  ),
                ),
                IconButton(onPressed: (){}, icon: Icon(Icons.mail)),
              ],
            ),   
                
            
            
          ],
        ),
      ),
    );
  }
}



