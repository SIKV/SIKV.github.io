import 'package:cv/models/experience_model.dart';
import 'package:cv/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExperienceItem extends StatelessWidget {
  final ExperienceModel experienceModel;
  final Function(ExperienceModel) onCompanyPressed;

  ExperienceItem({
    @required this.experienceModel,
    this.onCompanyPressed,
  }) : assert(experienceModel != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, top: 16, right: 24, bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: contentWidget(context),
    );
  }

  Widget contentWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(experienceModel.title,
          style: Theme.of(context).textTheme.headline2,
        ),

        SizedBox(height: 2),

        IgnorePointer(
          ignoring: experienceModel.companyUrl.isEmpty,
          child: InkWell(
            onTap: () => onCompanyPressed(experienceModel),
            child: Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 4),
              child: Text('${experienceModel.company} ${AppStrings.pointSymbol} ${experienceModel.employmentType}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
        ),

        SizedBox(height: 16),

        Chip(
          label: Text('${experienceModel.startDate} - ${experienceModel.endDate}'),
          backgroundColor: Theme.of(context).canvasColor,
        ),
      ],
    );
  }
}