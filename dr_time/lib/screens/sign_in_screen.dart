import 'package:dr_time/screens/auth_repository.dart';
import 'package:dr_time/screens/navigationPage.dart';
import 'package:dr_time/screens/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogInPage extends StatefulWidget {   //loginscreen
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _emailErrorText;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final String email = _emailController.text.trim();
    final String password = _passwordController.text;

    setState(() {
      _emailErrorText = null;
    });

    try {
      await context.read<AuthRepository>().logInWithEmailAndPassword(
        email: email,
        password: password
      );
      // النجاح: انتقل للصفحة الرئيسية
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const NavigationPage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      print("Login failed: ${e.code} - ${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Login failed")),
      );
      setState(() {
        _emailErrorText = e.message ?? "Login failed";
      });
    } catch (e) {
      print("Unknown login error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unknown login error")),
      );
      setState(() {
        _emailErrorText = "Unknown login error";
      });
    }
  }
  

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
              body: Form(
                key: _formKey,
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
                child: TextFormField(
                  controller: _emailController,      //hay l7ta t5tfe error lma nktb
                  onChanged: (text){
                    if(_emailErrorText != null){setState(() {
                      _emailErrorText = null;
                    });}
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    // Regex for email validation
                    final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
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
                   child: TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$').hasMatch(value)) {
                        return 'Password must contain uppercase, lowercase, number, and special character';
                      }
                      return null;
                    },
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
                  );}, // SignUpPage doesn't need theme props anymore if we adjust it
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
