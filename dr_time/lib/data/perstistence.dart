import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;

Future<void> initPrefs() async {

  prefs = await SharedPreferences.getInstance();
}

// تعريف الدالة
Future<void> saveMed({
  required int id,
  required String medName,
  required String dosis,
  required String imagePath,
  required String info,
}) async {
  // استخدام النسخة الموجودة بالفعل
  // prefs! تعني أنك متأكد أن prefs ليس null
  await prefs!.setInt('med_id', id);
  await prefs!.setString('med_name', medName);
  await prefs!.setString('med_dosis', dosis);
  await prefs!.setString('med_imagePath', imagePath);
  await prefs!.setString('med_info', info);
}


// دالة لتحميل اسم الدواء
Future<String?> loadMedName() async {
  return prefs!.getString('med_name');
}

// دالة لتحميل الجرعة
Future<String?> loadMedDosis() async {
  return prefs!.getString('med_dosis');
}

// دالة لتحميل مسار الصورة
Future<String?> loadMedImagePath() async {
  return prefs!.getString('med_imagePath');
}

// دالة لتحميل المعلومات
Future<String?> loadMedInfo() async {
  return prefs!.getString('med_info');
}