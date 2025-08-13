import 'package:dr_time/data/mock_database.dart';
import 'package:dr_time/screens/ProfilePage.dart';
import 'package:dr_time/screens/home_screen.dart';
import 'package:dr_time/screens/searchPage.dart';
import 'package:dr_time/screens/settingsPage.dart';
import 'package:flutter/material.dart';

import '../data/database_repository.dart';


class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;

  //       one db for all pages
  late final DatabaseRepository db;

  @override
  void initState() {
    super.initState();
    db = MockDatabaseRepository() as DatabaseRepository; // أو استبدله بقاعدة بيانات حقيقية لاحقًا
  }

  @override
  Widget build(BuildContext context) {
    // نحدد الصفحات هنا علشان نمرر db لـ HomePage
    final List<Widget> pages = [
      HomePage(db: db),
      const SearchPage(),
      const ProfilePage(),
      const SettingsPage(),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: const Color.fromARGB(255, 105, 105, 105),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}
