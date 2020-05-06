import 'package:cv/dimens.dart';
import 'package:cv/models/project_model.dart';
import 'package:cv/utils/utils.dart';
import 'package:flutter/material.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final Color backgroundColor;
  final ProjectModel project;

  const ProjectDetailsScreen({
    this.backgroundColor,
    this.project
  });

  @override
  Widget build(BuildContext context) {
    if (isPortraitOrientation(context) || isMobile()) {
      return _mobileRootLayout(context);
    } else {
      return _rootLayout(context);
    }
  }

  Widget _rootLayout(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor.withOpacity(AppDimens.projectDetailsBackgroundOpacity),
      child: Center(
        child: SizedBox(
          width: AppDimens.projectDetailsWidth,
          height: AppDimens.projectDetailsHeight,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimens.projectDetailsBorderRadius)
            ),
            child: _contentWidget(context),
          ),
        ),
      ),
    );
  }

  Widget _mobileRootLayout(BuildContext context) {
    return _contentWidget(context);
  }

  Widget _contentWidget(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.close),
        ),
        title: Text(project.name),
      ),
      backgroundColor: backgroundColor,
    );
  }
}