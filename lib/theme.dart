import 'package:cv/colors.dart';
import 'package:flutter/material.dart';

enum AppTheme {
  light, dark
}

class ThemeManager with ChangeNotifier {
  AppTheme _appTheme = AppTheme.dark;

  AppColors get appColors {
    switch (_appTheme) {
      case AppTheme.light:
        return AppColorsLight();
      case AppTheme.dark:
        return AppColorsDark();
      default:
        return null;
    }
  }

  ThemeData createTheme() {
    Brightness brightness;

    switch (_appTheme) {
      case AppTheme.light:
        brightness = Brightness.light;
        break;
      case AppTheme.dark:
        brightness = Brightness.dark;
        break;
    }

    return _createTheme(brightness, appColors);
  }

  void setTheme(AppTheme theme) async {
    _appTheme = theme;

    notifyListeners();
  }

  void invertTheme() async {
    if (_appTheme == AppTheme.light) {
      _appTheme = AppTheme.dark;
    } else {
      _appTheme = AppTheme.light;
    }

    notifyListeners();
  }

  ThemeData _createTheme(Brightness brightness, AppColors colors) {
    return ThemeData(
      brightness: brightness,
      primaryColor: colors.primary,
      accentColor: colors.accent,
      scaffoldBackgroundColor: colors.background,
      canvasColor: colors.background,

      appBarTheme: AppBarTheme(
        elevation: 1,
      ),

      cardTheme: CardTheme(
        elevation: 1,
      ),

      textTheme: TextTheme(
        headline1: TextStyle(
          color: colors.text,
          fontWeight: FontWeight.w900,
          fontSize: 48,
        ),
        headline2: TextStyle(
          color: colors.text,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        subtitle1: TextStyle(
          color: colors.subtitle1,
          letterSpacing: 2,
          fontSize: 13,
        ),
      ),

      tooltipTheme: TooltipThemeData(
        verticalOffset: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: colors.primary,
        ),
        textStyle: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}