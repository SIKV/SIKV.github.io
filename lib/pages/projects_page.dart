import 'package:cv/blocs/data_bloc.dart';
import 'package:cv/dimens.dart';
import 'package:cv/models/project_model.dart';
import 'package:cv/pages/project_details_screen.dart';
import 'package:cv/routes/slide_top_route.dart';
import 'package:cv/widgets/project_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../theme.dart';

class ProjectsPage extends StatefulWidget {
  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  DataBloc _dataBloc;
  ThemeManager _themeManager;

  @override
  void initState() {
    super.initState();

    _dataBloc = DataBloc();
  }

  void _onProjectItemPressed(ProjectModel project) {
    Navigator.push(context, SlideTopRoute(
      opaque: false,
      page: ProjectDetailsScreen(
        backgroundColor: _themeManager.appColors.backgroundLight,
        project: project,
      ),
    ));
  }

  int _gridCrossAxisCount() {
    var width = MediaQuery.of(context).size.width;
    return width ~/ AppDimens.minProjectItemSize;
  }

  @override
  Widget build(BuildContext context) {
    _themeManager = Provider.of<ThemeManager>(context);

    return StreamBuilder<List<ProjectModel>>(
      stream: _dataBloc.fetchProjects(),
      builder: (context, snapshot) {
        return snapshot.hasData ? _contentWidget(snapshot.data) : Container();
      }
    );
  }

  Widget _contentWidget(List<ProjectModel> projects) {
    return _projectsGrid(projects);
  }

  Widget _projectsGrid(List<ProjectModel> projects) {
    return GridView.count(
      padding: const EdgeInsets.all(AppDimens.contentPadding),
      crossAxisCount: _gridCrossAxisCount(),
      mainAxisSpacing: AppDimens.projectsGridSpacing,
      crossAxisSpacing: AppDimens.projectsGridSpacing,
      children: projects.map((project) =>
          ProjectItem(projectModel: project,
            onPressed: () => _onProjectItemPressed(project),
          )
      ).toList()
    );
  }
}