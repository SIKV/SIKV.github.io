import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/prefer_universal/html.dart' as html;

bool isPortraitOrientation(BuildContext context) {
  return MediaQuery.of(context).orientation == Orientation.portrait;
}

bool isMobile() {
  if (kIsWeb) {
    return false;
  } else {
    return Platform.isAndroid || Platform.isIOS;
  }
}

void openUrl(String url) {
  if (kIsWeb) {
    html.window.open(url, '');
  }
}