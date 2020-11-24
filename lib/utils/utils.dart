import 'dart:io';

import 'package:cv/dimens.dart';
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

Widget rootLayout(BuildContext context, List<Widget> children) {
  if (isPortraitOrientation(context)) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.contentPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children.reversed.toList(),
        ),
      ),
    );
  } else {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.contentPadding),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}

void openUrl(String url) {
  if (kIsWeb) {
    html.window.open(url, '');
  }
}