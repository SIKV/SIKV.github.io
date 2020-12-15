import 'package:cv/blocs/data_bloc.dart';
import 'package:cv/models/experience_model.dart';
import 'package:cv/utils/utils.dart';
import 'package:cv/widgets/experience_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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

  Widget contentWidget(List<ExperienceModel> experience) {
    return ListView.separated(
      padding: const EdgeInsets.all(24),
      shrinkWrap: true,
      itemCount: experience.length,
      itemBuilder: (context, index) => Align(
        alignment: Alignment.center,
        child: ExperienceItem(
          onCompanyPressed: onCompanyPressed,
          experienceModel: experience[index],
        ),
      ),
      separatorBuilder: (context, index) => SizedBox(height: 24),
    );
  }
}