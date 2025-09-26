import 'package:dr_time/data/database_repository.dart';
import 'package:dr_time/screens/ProfilePage.dart';
import 'package:dr_time/screens/home_screen.dart';
import 'package:dr_time/screens/searchPage.dart';
import 'package:dr_time/screens/settingsPage.dart';
import 'package:flutter/material.dart';

import '../data/firestore_dbRepo.dart'; // Import FirestoreDatabaseRepository

class NavigationPage extends StatefulWidget {
  final bool isDark;
  final Function(bool) onThemeChanged;
  const NavigationPage({super.key, required this.isDark, required this.onThemeChanged});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;

  final DatabaseRepository db = FirestoreDatabaseRepository(); // Use Firestore

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(db: db),
      SearchPage(),
      ProfilePage(isDark: widget.isDark, onThemeChanged: widget.onThemeChanged),
      SettingsPage(isDark: widget.isDark, onThemeChanged: widget.onThemeChanged),
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
