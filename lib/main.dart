import 'package:cv/pages/main_page.dart';
import 'package:cv/strings.dart';
import 'package:cv/theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(
  ThemeWidget(
    appTheme: AppTheme.dark,
    child: App(),
  )
);

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.title,
      theme: ThemeWidget.instanceOf(context).appTheme.createTheme(context),
      home: MainPage(),
    );
  }
}