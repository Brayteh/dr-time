import 'package:dr_time/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with WidgetsBindingObserver {

  final _formKey = GlobalKey<FormState>();
  final _fNameCtrl = TextEditingController();
  final _lNameCtrl = TextEditingController();
  final _dbirthCtrl = TextEditingController();
  final _diseaseCtrl = TextEditingController();

    @override
    void dispose(){
      _fNameCtrl.dispose();
      _lNameCtrl.dispose();
      _dbirthCtrl.dispose();
      _diseaseCtrl.dispose();
      WidgetsBinding.instance.removeObserver(this); // لإزالة المراقب عند الخروج
      super.dispose();
    }
      // هذه الدالة الجديدة التي ستقوم بتحديث البيانات
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _loadData();
    }
  }
  
    void _saveData() async {   //save data input in the Phone
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', _fNameCtrl.text);
    await prefs.setString('lastName', _lNameCtrl.text);
    await prefs.setString('dateOfBirth', _dbirthCtrl.text);
    await prefs.setString('diseaseName', _diseaseCtrl.text);
  }
    void _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    _fNameCtrl.text = prefs.getString('firstName') ?? '';
    _lNameCtrl.text = prefs.getString('lastName') ?? '';
    _dbirthCtrl.text = prefs.getString('dateOfBirth') ?? '';
    _diseaseCtrl.text = prefs.getString('diseaseName') ?? '';
    setState(() {});
    }
    @override
void initState() {
  super.initState();
  _loadData();   // استدعاء دالة التحميل هنا
  WidgetsBinding.instance.addObserver(this); // لإضافة مراقب لدورة حياة التطبيق
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