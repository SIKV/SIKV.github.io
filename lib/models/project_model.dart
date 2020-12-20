import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProjectModel {
  static const mobileColor = Color(0xFF6ECFF8);
  static const androidColor = Color(0xFF10C260);

  final String id;
  final String name;
  final String platform;
  final String shortDescription;
  final bool openSource;
  final String url;
  final List<String> points;
  final List<String> technologies;
  final List<String> screenshots;

  ProjectModel({
    this.id,
    this.name,
    this.platform,
    this.shortDescription,
    this.openSource,
    this.url,
    this.points,
    this.technologies,
    this.screenshots
  });

  ProjectModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        platform = json['platform'] ?? '',
        shortDescription = json['short_description'] ?? '',
        openSource = json['is_open_source'] ?? false,
        url = json['url'] ?? '',
        points = json['points']?.cast<String>() ?? [],
        technologies = json['technologies']?.cast<String>() ?? [],
        screenshots = json['screenshots']?.cast<String>() ?? [];

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
        iconData = Icons.android;
        break;
    }

    return Icon(iconData,
      color: resolveColor(),
      size: 64,
    );
  }
}