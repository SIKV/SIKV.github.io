import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/prefer_universal/html.dart' as html;

bool isMobile() {
  return !kIsWeb;
}

bool isPortraitOrientation(BuildContext context) {
  return MediaQuery.of(context).orientation == Orientation.portrait;
}

double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width / 1;
}

void openUrl(String url) {
  if (kIsWeb) {
    html.window.open(url, '');
  }
}