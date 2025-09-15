import 'package:dr_time/Theme/theme.dart';
import 'package:dr_time/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/sign_in_screen.dart';

void main() async {
  // تأكد من تهيئة محرك فلاتر قبل أي عملية أخرى.
  WidgetsFlutterBinding.ensureInitialized();
  
  // تهيئة Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // تهيئة SharedPreferences واسترجاع حالة الوضع المظلم
  final prefs = await SharedPreferences.getInstance();
  bool isDark = prefs.getBool("darkMode") ?? false;
  
  // تشغيل التطبيق مرة واحدة فقط
  runApp(MyApp(isDark: isDark));
}


class MyApp extends StatefulWidget {
  final bool isDark;
  const MyApp({super.key, required this.isDark});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _isDark;

  @override
  void initState() {
    super.initState();
    _isDark = widget.isDark;
  }
  
  void _toggleTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("darkMode", value);
    setState(() {
      _isDark = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDark ? MyTheme.dark : MyTheme.light,
      home: LogInPage(
        onThemeChanged: _toggleTheme,
        isDark: _isDark,
      ),
    );
  }
}