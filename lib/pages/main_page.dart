import 'package:cv/theme/colors.dart';
import 'package:cv/constants.dart';
import 'package:cv/pages/about_page.dart';
import 'package:cv/pages/education_page.dart';
import 'package:cv/pages/experience_page.dart';
import 'package:cv/pages/projects_page.dart';
import 'package:cv/strings.dart';
import 'package:cv/theme/theme.dart';
import 'package:cv/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  final animationFrom = 0.5;

  AnimationController animationController;
  Animation<double> scaleAnimation;

  int selectedIndex = 0;

  List<Widget> widgetOptions = <Widget>[
    AboutPage(),
    ProjectsPage(),
    ExperiencePage(),
    EducationPage(),
  ];

  AppColors appColors;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: const Duration(milliseconds: AppConstants.mainPageTransitionAnimationDuration),
      vsync: this,
    );

    scaleAnimation = CurvedAnimation(parent: animationController,
      curve: Curves.elasticInOut,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      animationController.forward(from: animationFrom);
    });
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    appColors = ThemeWidget.instanceOf(context).appColors;

    super.didChangeDependencies();
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;

      animationController.reset();
      animationController.forward(from: animationFrom);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: scaleAnimation,
          child: widgetOptions.elementAt(selectedIndex),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        onTap: onItemTapped,
        currentIndex: selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: AppStrings.about,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_rounded),
            label: AppStrings.projects,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.amp_stories_rounded),
            label: AppStrings.experience,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_rounded),
            label: AppStrings.education,
          ),
        ],
        selectedItemColor: appColors.selectedItemColor,
        unselectedItemColor: appColors.unselectedItemColor,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}