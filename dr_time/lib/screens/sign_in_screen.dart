
import 'package:dr_time/screens/navigationPage.dart';
import 'package:dr_time/screens/sign_up.dart';
import 'package:flutter/material.dart';

class LogInPage extends StatelessWidget {   //loginscreen
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
              body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("images/med1.jpg"), // sura lfo2 
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text("Sign in", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 50),
            Padding(padding: EdgeInsets.only(left: 16),
            child: Text("Email", style: TextStyle(fontSize: 15), // Email
            ),
            ),
                  SizedBox(height: 3),
                  Padding(padding: EdgeInsets.all(16),  
              child: TextField( keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(hintText: "enter your Email"), // from Theme "Border"
              ) 
            ),
                 Padding(padding: EdgeInsets.only(left: 16),
                 child: Text("Password", style: TextStyle(fontSize: 15), // Password
            ),
            ),
                 SizedBox(height: 3),
                 Padding(padding: EdgeInsets.all(16),                   
                 child: TextField(keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(hintText: "enter your Password"),),// hyda border from Theme kamen                                   // hyda child 5asso bel border tafasil

            ),
            SizedBox(height: 50),
            Center(   // sign in button 
              child: SizedBox(
              width: 200, // العرض المطلوب
              child: ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 2,backgroundColor: const Color.fromARGB(255, 68, 202, 232)),
              onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context)=> NavigationPage()));},     // Navi zu HomePage
              child:
                 Text("Sign In",style:TextStyle(fontSize: 23,fontWeight: FontWeight.bold, color: Colors.white),),
          ),
         ),
        ),
            SizedBox(height: 15),
            Center(
              child: TextButton( // you dont have..?
                style: TextButton.styleFrom(foregroundColor: Colors.blue), // لون النص
                onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context)=> SignUpPage()), // Navi zu signUp
                );},
                 child: Text("you don't have an account? sign up")),
            ),
              Center(
              child: TextButton( // forget pass
                style: TextButton.styleFrom(foregroundColor: Colors.blue), // لون النص
                onPressed: (){}, child: Text("Forget password"),
                ),
              ),
          ],
        ),
    );
  }
}
