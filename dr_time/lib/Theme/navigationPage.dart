



import 'package:dr_time/screens/ProfilePage.dart';
import 'package:dr_time/screens/home_screen.dart';
import 'package:dr_time/screens/searchPage.dart';
import 'package:dr_time/screens/settingsPage.dart';
import 'package:flutter/material.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [        // pages list
    HomePage(),
    SearchPage(),
    ProfilePage(),
    SettingsPage(),



  ];                       
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],       // هنا يتم عرض الصفحة حسب المؤشر
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: const Color.fromARGB(255, 105, 105, 105),
        onTap: (index){
          setState(() {
            _selectedIndex = index;   // عند النقر نغيّر الصفحة
          });
        },
        items: const[
          BottomNavigationBarItem(icon: Icon(Icons.home),label:"Home",),
          BottomNavigationBarItem(icon: Icon(Icons.search),label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Settings"),
        ],
      ),
    );
  }
}
