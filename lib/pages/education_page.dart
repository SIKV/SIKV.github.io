import 'package:cv/blocs/data_bloc.dart';
import 'package:cv/models/education_model.dart';
import 'package:cv/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class EducationPage extends StatefulWidget {
  @override
  _EducationPageState createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  DataBloc _dataBloc;

  @override
  void initState() {
    _dataBloc = DataBloc();

    super.initState();
  }

  void _onSchoolTap(EducationModel model) {
    openUrl(model.schoolUrl);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EducationModel>(
      stream: _dataBloc.fetchEducation(),
      builder: (context, snapshot) {
        return Center(
          child: snapshot.hasData
              ? _contentWidget(snapshot.data)
              : Container(),
        );
      },
    );
  }

  Widget _contentWidget(EducationModel model) {
    return Center(
      child: rootLayout(context, <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(model.degreeShort,
              style: Theme.of(context).textTheme.headline1,
            ),

            Text(model.degree,
              style: Theme.of(context).textTheme.headline2,
            ),

            SizedBox(height: 12),

            InkWell(
              onTap: () => _onSchoolTap(model),
              child: Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 4),
                child: Text(model.school,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ),

            SizedBox(height: 16),

            Chip(
              label: Text('${model.startYear} - ${model.endYear}'),
            ),
          ],
        ),
      ]),
    );
  }
}