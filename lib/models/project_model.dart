import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProjectModel {
  static const mobileColor = Color(0xFF6ECFF8);
  static const androidColor = Color(0xFF10C260);

  final String name;
  final String shortDescription;
  final String platform;

  ProjectModel({
    this.name,
    this.shortDescription,
    this.platform,
  });

  Icon resolveIcon() {
    IconData iconData;
    Color color;

    switch (platform) {
      case 'mobile':
        iconData = FontAwesomeIcons.mobile;
        color = mobileColor;
        break;

      case 'android':
        iconData = FontAwesomeIcons.android;
        color = androidColor;
        break;
    }

    return Icon(iconData,
      color: color,
      size: 64,
    );
  }
}