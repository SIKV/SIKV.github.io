import 'package:cv/colors.dart';
import 'package:cv/constants.dart';
import 'package:cv/pages/about_page.dart';
import 'package:cv/pages/projects_page.dart';
import 'package:cv/strings.dart';
import 'package:cv/theme.dart';
import 'package:cv/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  final _animationFrom = 0.5;

  AnimationController _animationController;
  Animation<double> _scaleAnimation;

  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    AboutPage(),
    ProjectsPage(),
  ];

  AppColors _appColors;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: AppConstants.mainPageTransitionAnimationDuration),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(parent: _animationController,
      curve: Curves.elasticInOut,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward(from: _animationFrom);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _appColors = ThemeWidget.instanceOf(context).appColors;

    super.didChangeDependencies();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      _animationController.reset();
      _animationController.forward(from: _animationFrom);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
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
        selectedItemColor: _appColors.selectedItemColor,
        unselectedItemColor: _appColors.unselectedItemColor,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}