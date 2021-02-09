import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../constants.dart';

class ImagePreviewScreen extends StatefulWidget {
  final String imageUrl;

  const ImagePreviewScreen({
    this.imageUrl
  });

  @override
  _ImagePreviewScreenState createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        color: Theme.of(context).primaryColor.withOpacity(AppConstants.imagePreviewBackgroundOpacity),
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: widget.imageUrl,
        ),
      ),
    );
  }
}