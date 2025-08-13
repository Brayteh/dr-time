import 'package:flutter/material.dart';

import '../data/database_repository.dart';

class ViewMedPage extends StatelessWidget {
  final DatabaseRepository db;
  final int id;
  final String medName;
  final String dosis;
  final String imagePath;
  final String info;

  const ViewMedPage({super.key,required this.db,required this.id, required this.medName,required this.dosis, required this.imagePath, required this.info,});
  void deleteMed(BuildContext context) {
  db.deleteMedicament(id); // حذف من قاعدة البيانات
  Navigator.pop(context);  // العودة للصفحة السابقة
}


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(medName),
      ),
      body: Center(
        child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: (){},
               icon: Icon(Icons.edit)),
IconButton(
  onPressed: () {
    // عرض تأكيد الحذف
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(" Delete"),
        content: const Text("do you want to delete this medicament?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // إلغاء الحذف
            },
            child: const Text("cancel"),
          ),
          TextButton(
            onPressed: () {
              db.deleteMedicament(id); // حذف الدواء من قاعدة البيانات
              Navigator.of(ctx).pop(); // إغلاق التنبيه
              Navigator.of(context).pop(); // العودة للصفحة السابقة
            },
            child: const Text("delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  },
  icon: const Icon(Icons.delete, color: Colors.red),
)

            ],
          ),
          Image.asset(imagePath, width: 200,height: 200,fit: BoxFit.cover,),

          const SizedBox(height: 20,),


          Text(medName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
          const SizedBox(height: 20,),
          Text(dosis, style: const TextStyle(fontSize: 18, color: Colors.blue),),
          SizedBox(height: 10,),
          Text(info, style:TextStyle(fontSize: 16),textAlign: TextAlign.center,),
         ],

        ),
      ),
    );
  }
}