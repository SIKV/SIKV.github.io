import 'package:cv/models/project_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProjectItem extends StatelessWidget {
  final ProjectModel projectModel;
  final VoidCallback onPressed;

  ProjectItem({
    @required this.projectModel,
    this.onPressed,
  }) : assert(projectModel != null);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      onHover: (b) => { },
      borderRadius: BorderRadius.all(Radius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(child: projectModel.resolveIcon()),

            const SizedBox(height: 12),

            Expanded(child: _textWidget(context)),
          ],
        ),
      ),
    );
  }

  Widget _textWidget(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(projectModel.name,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline2,
          ),

          const SizedBox(height: 8),

          Flexible(
            child: Text(projectModel.appShortDescription,
              textAlign: TextAlign.center,
              maxLines: 3,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ],
      ),
    );
  }
}