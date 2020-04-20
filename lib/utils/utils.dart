import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/prefer_universal/html.dart' as html;

bool isPortraitOrientation(BuildContext context) {
  return MediaQuery.of(context).orientation == Orientation.portrait;
}

void openUrl(String url) {
  if (kIsWeb) {
    html.window.open(url, '');
  }
}