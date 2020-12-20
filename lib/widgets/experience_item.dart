import 'package:cv/blocs/data_bloc.dart';
import 'package:cv/models/experience_model.dart';
import 'package:cv/models/project_model.dart';
import 'package:cv/routes/slide_top_route.dart';
import 'package:cv/screens/project_details_screen.dart';
import 'package:cv/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExperienceItem extends StatefulWidget {
  final ExperienceModel experienceModel;
  final Function(ExperienceModel) onCompanyPressed;

  ExperienceItem({
    @required this.experienceModel,
    this.onCompanyPressed,
  }) : assert(experienceModel != null);

  @override
  _ExperienceItemState createState() => _ExperienceItemState();
}

class _ExperienceItemState extends State<ExperienceItem> {
  DataBloc dataBloc;

  @override
  void initState() {
    dataBloc = DataBloc();

    super.initState();
  }

  void onProjectPressed(ProjectModel project) {
    Navigator.push(context, SlideTopRoute(
      opaque: false,
      page: ProjectDetailsScreen(
        project: project,
      ),
    ));
  }

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
        Text(widget.experienceModel.title,
          style: Theme.of(context).textTheme.headline2,
        ),

        SizedBox(height: 2),

        IgnorePointer(
          ignoring: widget.experienceModel.companyUrl.isEmpty,
          child: InkWell(
            onTap: () => widget.onCompanyPressed(widget.experienceModel),
            child: Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 4),
              child: Text('${widget.experienceModel.company} ${AppStrings.pointSymbol} ${widget.experienceModel.employmentType}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
        ),

        SizedBox(height: 16),
        projectsWidget(),

        SizedBox(height: 12),
        projectsListBuilder(),

        SizedBox(height: 24),

        Chip(
          label: Text('${widget.experienceModel.startDate} - ${widget.experienceModel.endDate}'),
          backgroundColor: Theme.of(context).canvasColor,
        ),
      ],
    );
  }

  Widget projectsWidget() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: AppStrings.projects.toUpperCase(),
            style: Theme.of(context).textTheme.subtitle1.copyWith(
              fontSize: 11,
            ),
          ),
          WidgetSpan(
            child: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Icon(Icons.work_rounded,
                size: 16,
                color: Theme.of(context).textTheme.subtitle1.color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget projectsListBuilder() {
    return StreamBuilder<List<ProjectModel>>(
      stream: dataBloc.fetchProjects(ids: widget.experienceModel.projects.toSet()),
      builder: (context, snapshot) {
        return snapshot.hasData ? projectsListWidget(snapshot.data) : Container();
      },
    );
  }

  Widget projectsListWidget(List<ProjectModel> projects) {
    return Wrap(
      spacing: 8,
      children: projects.map((project) => OutlinedButton(
        onPressed: () => onProjectPressed(project),
        child: Text(project.name),
      )).toList(),
    );
  }
}