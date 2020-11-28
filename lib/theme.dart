import 'package:cv/colors.dart';
import 'package:flutter/material.dart';

enum AppTheme {
  light, dark
}

extension CreateMethods on AppTheme {
  ThemeData createTheme(BuildContext context) {
    Brightness brightness;

    if (this == AppTheme.light) {
      brightness = Brightness.light;
    } else {
      brightness = Brightness.dark;
    }

    return _createTheme(context, brightness, this.createColors());
  }

  AppColors createColors() {
    if (this == AppTheme.light) {
      return AppColorsLight();
    } else {
      return AppColorsDark();
    }
  }
}

class ThemeWidget extends StatefulWidget {
  final AppTheme appTheme;
  final Widget child;

  const ThemeWidget({
    Key key,
    this.appTheme,
    @required this.child
  }) : super(key: key);

  @override
  ThemeWidgetState createState() => ThemeWidgetState();

  static ThemeWidgetState instanceOf(BuildContext context) {
    InheritedThemeWidget inherited = (context.dependOnInheritedWidgetOfExactType<InheritedThemeWidget>());
    return inherited.data;
  }
}

class ThemeWidgetState extends State<ThemeWidget> {
  AppTheme _appTheme;
  AppColors _appColors;

  AppTheme get appTheme => _appTheme;
  AppColors get appColors => _appColors;

  void invertTheme() {
    setState(() {
      if (_appTheme == AppTheme.light) {
        _appTheme = AppTheme.dark;
      } else {
        _appTheme = AppTheme.light;
      }

      _appColors = _appTheme.createColors();
    });
  }

  @override
  void initState() {
    _appTheme = widget.appTheme;
    _appColors = _appTheme.createColors();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedThemeWidget(
      data: this,
      child: widget.child,
    );
  }
}

class InheritedThemeWidget extends InheritedWidget {
  final ThemeWidgetState data;

  InheritedThemeWidget({
    this.data,
    Key key,
    @required Widget child
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}

ThemeData _createTheme(BuildContext context, Brightness brightness, AppColors colors) {
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

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: 2,
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
        letterSpacing: 1.5,
        fontSize: 16,
      ),
      bodyText1: TextStyle(
        color: colors.bodyText1,
        fontWeight: FontWeight.w300,
        fontSize: 16,
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

    chipTheme: Theme.of(context).chipTheme.copyWith(
      brightness: brightness,
      labelStyle: TextStyle(
        color: colors.bodyText1,
        letterSpacing: 1.5,
        fontSize: 13,
      ),
      backgroundColor: colors.primary,
    ),
  );
}