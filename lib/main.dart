import 'package:cv/pages/main_page.dart';
import 'package:cv/strings.dart';
import 'package:cv/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeManager>(
      create: (_) => ThemeManager(),
      child: Consumer<ThemeManager>(builder: (context, themeManager, _) {
        return  MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppStrings.title,
          theme: themeManager.createTheme(),
          home: MainPage(),
        );
      }),
    );
  }
}