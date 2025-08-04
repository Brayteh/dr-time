
import 'package:dr_time/Theme/theme.dart';
import 'package:dr_time/screens/sign_in_screen.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
  
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(                  // hon menbalish MaterialApp  
    debugShowCheckedModeBanner: false,
    theme: MyTheme.light,
      home: LogInPage(),
    );
  }
}