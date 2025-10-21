import 'package:dr_time/Theme/theme.dart';
import 'package:dr_time/Theme/theme_provider.dart';
import 'package:dr_time/data/database_repository.dart';
import 'package:dr_time/data/firestore_dbRepo.dart';
import 'package:dr_time/data/drug_api_service.dart';
import 'package:dr_time/firebase_options.dart';
import 'package:dr_time/screens/auth_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/sign_in_screen.dart';

void main() async {
  // تأكد من تهيئة محرك فلاتر قبل أي عملية أخرى.
  WidgetsFlutterBinding.ensureInitialized();
  
  // تهيئة Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  final prefs = await SharedPreferences.getInstance();
  bool isDark = prefs.getBool("darkMode") ?? false;
  
  runApp(MyApp(isDark: isDark)); // تشغيل التطبيق مرة واحدة فقط
}


class MyApp extends StatelessWidget {
  final bool isDark;
  const MyApp({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepository>(
          create: (_) => AuthRepository(),
        ),
        Provider<DatabaseRepository>(
          create: (_) => FirestoreDatabaseRepository(),
        ),
        Provider<DrugApiService>(
          create: (_) => DrugApiService(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(isDark: isDark),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeProvider.isDark ? MyTheme.dark : MyTheme.light,
            home: const LogInPage(),
          );
        },
      ),
    );
  }
}