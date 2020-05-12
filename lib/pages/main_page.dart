import 'package:cv/colors.dart';
import 'package:cv/pages/about_page.dart';
import 'package:cv/pages/projects_page.dart';
import 'package:cv/strings.dart';
import 'package:cv/theme.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  AppColors _appColors;

  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    AboutPage(),
    ProjectsPage(),
  ];

  @override
  void didChangeDependencies() {
    _appColors = ThemeWidget.instanceOf(context).appColors;

    super.didChangeDependencies();
  }

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
            title: Text(AppStrings.projects),
          ),
        ],
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: _appColors.selectedItemColor,
        unselectedItemColor: _appColors.unselectedItemColor,
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}