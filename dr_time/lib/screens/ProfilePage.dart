import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_time/screens/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfilePage extends StatefulWidget {
  final bool isDark;
  final Function(bool) onThemeChanged;
  const ProfilePage({super.key, required this.isDark, required this.onThemeChanged});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final _formKey = GlobalKey<FormState>();
  final _fNameCtrl = TextEditingController();
  final _lNameCtrl = TextEditingController();
  final _dbirthCtrl = TextEditingController();
  final _diseaseCtrl = TextEditingController();

  // Helper to get the user document reference
  DocumentReference _getUserDocRef() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User not logged in!");
    }
    return FirebaseFirestore.instance.collection('users').doc(user.uid);
  }
  
  void _saveData() async {
    try {
      await _getUserDocRef().set({
        'firstName': _fNameCtrl.text,
        'lastName': _lNameCtrl.text,
        'dateOfBirth': _dbirthCtrl.text,
        'diseaseName': _diseaseCtrl.text,
      }, SetOptions(merge: true)); // merge:true creates or updates
    } catch (e) {
      // Handle error, maybe show a SnackBar
      print("Error saving profile data: $e");
    }
  }

  void _loadData() async {
    try {
      final doc = await _getUserDocRef().get();
      if (doc.exists && doc.data() != null) {
        final data = doc.data() as Map<String, dynamic>;
        _fNameCtrl.text = data['firstName'] ?? '';
        _lNameCtrl.text = data['lastName'] ?? '';
        _dbirthCtrl.text = data['dateOfBirth'] ?? '';
        _diseaseCtrl.text = data['diseaseName'] ?? '';
        if (mounted) setState(() {});
      }
    } catch (e) {
      // Handle error
      print("Error loading profile data: $e");
    }
  }

  @override
void initState() {
  super.initState();
  _loadData();   // استدعاء دالة التحميل هنا
}

void _submit() {
  if (_formKey.currentState!.validate()) {
    _saveData(); // استدعاء دالة الحفظ هنا
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Done!"),
      ),
    );
  }
}

  @override
  void dispose(){
    _fNameCtrl.dispose();
    _lNameCtrl.dispose();
    _dbirthCtrl.dispose();
    _diseaseCtrl.dispose();
    super.dispose();
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
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: IconButton(
                      icon: Icon(Icons.power_settings_new, color: Colors.red, size: 33),
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LogInPage(
                              isDark: widget.isDark,
                              onThemeChanged: widget.onThemeChanged,
                            ),
                          ),
                        );
                      },
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
              controller: _fNameCtrl,
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
              controller: _lNameCtrl,
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
              controller: _dbirthCtrl,
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
            child: TextField(
              controller: _diseaseCtrl,
              keyboardType: TextInputType.text,
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