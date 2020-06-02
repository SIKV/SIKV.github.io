import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProjectModel {
  static const mobileColor = Color(0xFF6ECFF8);
  static const androidColor = Color(0xFF10C260);

  final String name;
  final String platform;
  final String appShortDescription;
  final String url;

  ProjectModel({
    this.name,
    this.platform,
    this.appShortDescription,
    this.url
  });

  ProjectModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        platform = json['platform'],
        appShortDescription = json['app_short_description'],
        url = json['url'];

  Color resolveColor() {
    Color color;

    switch (platform) {
      case 'mobile':
        color = mobileColor;
        break;

      case 'android':
        color = androidColor;
        break;
    }

    return color;
  }

  Icon resolveIcon() {
    IconData iconData;

    switch (platform) {
      case 'mobile':
        iconData = FontAwesomeIcons.mobile;
        break;

      case 'android':
        iconData = FontAwesomeIcons.android;
        break;
    }

    return Icon(iconData,
      color: resolveColor(),
      size: 64,
    );
  }
}