import 'package:cv/colors.dart';
import 'package:cv/pages/main_page.dart';
import 'package:cv/strings.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.title,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        accentColor: AppColors.accent,
        scaffoldBackgroundColor: AppColors.background,
        canvasColor: AppColors.background,
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: AppColors.text,
          displayColor: AppColors.text,
        ).copyWith(
          headline1: TextStyle(
            color: AppColors.text,
            fontWeight: FontWeight.w600,
            fontSize: 48,
          ),
          headline2: TextStyle(
            color: AppColors.text,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
          subtitle1: Theme.of(context).textTheme.overline.copyWith(
            fontSize: 15,
            color: AppColors.primaryLight,
          ),
        ),
        tooltipTheme: TooltipThemeData(
          verticalOffset: 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.primary,
          ),
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: MainPage(),
    );
  }
}