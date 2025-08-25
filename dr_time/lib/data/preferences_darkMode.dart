import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? _prefs2;


Future<void> initializePerstistence () async {
_prefs2 = await SharedPreferences.getInstance();
}


Future<bool> saveDark (bool DarkMode) async {

try {
  return _prefs2!.setBool("dark mode", DarkMode);
} catch (e) {
  print("Error with saving darkmode $e");
  return false;
}
}

bool? loadDarkMode () {
  return _prefs2?.getBool("dark mode");

}