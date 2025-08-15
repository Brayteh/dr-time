import 'package:dr_time/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final _formKey = GlobalKey<FormState>();
  final _fNameCtrl = TextEditingController();
  final _lNameCtrl = TextEditingController();
  final _dbirthCtrl = TextEditingController();

    @override
    void dispose(){
      _fNameCtrl.dispose();
      _lNameCtrl.dispose();
      _dbirthCtrl.dispose();
      super.dispose();
    }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Done!",
          ),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(12),
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
            Padding(padding: EdgeInsets.all(16), 
              //Border
            child: TextFormField(
              validator: (value){
                final v = value?.trim() ?? "";
                if (v.isEmpty) return "please write your name";
                if (v.length < 3) return "please write a valid name";
                return null;
              },
               keyboardType: TextInputType.name,
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
            child: TextFormField(
              validator: (value){
                final v = value?.trim() ?? "";
                if (v.isEmpty) return "please write your last name";
                if (v.length < 3) return "please write a valid last name";
                return null; 
              },
               keyboardType: TextInputType.name,
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
            child: TextFormField(
              validator: (value) {
                final v = value?.trim() ?? "";
                if (v.isEmpty) return "please enter your date of birth";
                if (!RegExp(r'^\d{2}\.\d{2}\.\d{4}$').hasMatch(v)) return "the form must be dd.mm.yyyy";
                return null;
              },
              keyboardType: TextInputType.text,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),],
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
                onPressed: _submit,
                child:
                   Text("Save",style:TextStyle(fontSize: 23,fontWeight: FontWeight.bold, color: Colors.white),),
            ),
           ),
          ),
          ],
        ),
      ),
    );
  }
}