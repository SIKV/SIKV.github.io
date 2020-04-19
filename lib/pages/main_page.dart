import 'package:cv/colors.dart';
import 'package:cv/pages/about_page.dart';
import 'package:cv/pages/experience_page.dart';
import 'package:cv/strings.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    AboutPage(),
    ExperiencePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text(AppStrings.about),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            title: Text(AppStrings.experience),
          ),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.unselectedItemColor,
        backgroundColor: AppColors.primary,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}