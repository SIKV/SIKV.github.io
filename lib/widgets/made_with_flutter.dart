import 'package:cv/theme/colors.dart';
import 'package:cv/theme/theme.dart';
import 'package:flutter/material.dart';

import '../strings.dart';

class MadeWithFlutter extends StatefulWidget {
  @override
  _MadeWithFlutterState createState() => _MadeWithFlutterState();
}

class _MadeWithFlutterState extends State<MadeWithFlutter> {
  AppColors appColors;

  @override
  void didChangeDependencies() {
    appColors = ThemeWidget.instanceOf(context).appColors;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(AppStrings.madeWith,
          style: TextStyle(
            color: appColors.subtitle1,
            fontSize: 11,
          ),
        ),

        SizedBox(width: 4),

        FlutterLogo(
          size: 58,
          style: FlutterLogoStyle.horizontal,
          textColor: appColors.subtitle1,
        ),
      ],
    );
  }
}