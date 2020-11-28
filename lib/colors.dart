import 'package:flutter/material.dart';

abstract class AppColors {
  Color get primary;
  Color get accent => Color(0xFF10C260);

  Color get background;

  Color get text;
  Color get icon;

  Color get subtitle1;
  Color get bodyText1;

  Color get selectedItemColor;
  Color get unselectedItemColor => selectedItemColor.withAlpha(100);

  Color get linkedInIconColor;
  Color get githubIconColor;

  Color get transparent => Colors.transparent;
}

class AppColorsLight extends AppColors {
  @override
  Color get primary => Color(0xFFF6F6F6);

  @override
  Color get background => Color(0xFFFDFDFD);

  @override
  Color get text => Color(0xFF404040);

  @override
  Color get icon => Color(0xFF404040);

  @override
  Color get subtitle1 => Color(0xFF808080);

  @override
  Color get bodyText1 => Color(0xFF757575);

  @override
  Color get selectedItemColor => Color(0xFF404040);

  @override
  Color get linkedInIconColor => Color(0xFF0E76A8);

  @override
  Color get githubIconColor => Color(0xFF171515);
}

class AppColorsDark extends AppColors {
  @override
  Color get primary => Color(0xFF202020);

  @override
  Color get background => Color(0xFF101010);

  @override
  Color get text => Colors.white;

  @override
  Color get icon => Colors.white;

  @override
  Color get subtitle1 => Color(0xFF656565);

  @override
  Color get bodyText1 => Color(0xFFDDDDDD);

  @override
  Color get selectedItemColor => Colors.white;

  @override
  Color get linkedInIconColor => Colors.white;

  @override
  Color get githubIconColor => Colors.white;
}