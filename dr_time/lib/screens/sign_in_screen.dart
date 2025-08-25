

import 'package:dr_time/screens/navigationPage.dart';
import 'package:dr_time/screens/sign_up.dart';
import 'package:flutter/material.dart';


class LogInPage extends StatefulWidget {   //loginscreen
  final bool isDark;
  final Function(bool) onThemeChanged;
  const LogInPage({super.key, required this.isDark, required this.onThemeChanged});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //true user pass
  final String _correctUsername = "jakop@gmail.com";
  final String _correctPassword = "12345";
  //error email

  String? _emailErrorText;
  
  
    @override
    void dispose(){
      _emailController.dispose();
      _passwordController.dispose();
      super.dispose();
    }
    // methode lal ta7a2o2 mn tsjel du5ul
    void _login(){
      final String email = _emailController.text;
      final String password = _passwordController.text;
      //fina hon ndif print lal console 
      setState(() {
        _emailErrorText = null;
      });
      if (email ==_correctUsername && password == _correctPassword){

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context)=> NavigationPage(  isDark: widget.isDark,
              onThemeChanged: widget.onThemeChanged,)),
          );
        
      } else{
        setState(() {
          _emailErrorText = "invalid username or password";
        });
      }
    }
  

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
              body: Form(
                child: ListView(
                padding: const EdgeInsets.all(0),
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
                child: TextField(
                  controller: _emailController,      //hay l7ta t5tfe error lma nktb
                  onChanged: (text){
                    if(_emailErrorText != null){setState(() {
                      _emailErrorText = null;
                    });}
                  },
                   keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "enter your Email"), // from Theme "Border"
                ) 
                            ),
                   Padding(padding: EdgeInsets.only(left: 16),
                   child: Text("Password", style: TextStyle(fontSize: 15), // Password
                            ),
                            ),
                   SizedBox(height: 3),
                   Padding(padding: EdgeInsets.all(16),                   
                   child: TextField(
                    controller: _passwordController,
                    obscureText: true, keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      errorText: _emailErrorText,  // la 3rd error massage
                      hintText: "enter your Password"),),// hyda border from Theme kamen                                   // hyda child 5asso bel border tafasil
                
                            ),
                            SizedBox(height: 50),
                            Center(   // sign in button 
                child: SizedBox(
                width: 200, // العرض المطلوب
                child: ElevatedButton(
                style: ElevatedButton.styleFrom(elevation: 2,backgroundColor: const Color.fromARGB(255, 68, 202, 232)),
                onPressed: _login, // Navi zu HomePage ist oben, call methode lta7a2o2   
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
              ),
    );
  }
}
