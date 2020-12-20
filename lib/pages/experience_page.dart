import 'package:cv/blocs/data_bloc.dart';
import 'package:cv/models/experience_model.dart';
import 'package:cv/utils/utils.dart';
import 'package:cv/widgets/experience_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExperiencePage extends StatefulWidget {
  @override
  _ExperiencePageState createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage> {
  DataBloc dataBloc;

  @override
  void initState() {
    dataBloc = DataBloc();

    super.initState();
  }

  void onCompanyPressed(ExperienceModel model) {
    openUrl(model.companyUrl);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ExperienceModel>>(
      stream: dataBloc.fetchExperience(),
      builder: (context, snapshot) {
        return Center(
          child: snapshot.hasData
              ? contentWidget(snapshot.data)
              : Container(),
        );
      },
    );
  }

  Widget contentWidget(List<ExperienceModel> experiences) {
    return rootLayout(context, [
      Wrap(
        spacing: 24,
        runSpacing: 24,
        children: experiences.map((experience) => ExperienceItem(
          onCompanyPressed: onCompanyPressed,
          experienceModel: experience,
        )).toList(),
      ),
    ]);
  }
}