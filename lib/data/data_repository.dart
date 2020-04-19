import 'dart:convert';
import 'dart:core';

import 'package:cv/models/basic_info_model.dart';
import 'package:flutter/services.dart';

class DataRepository {
  final String _path = 'data.json';

  Future<BasicInfoModel> fetchBasicInfo() async {
    final jsonDecoded = await rootBundle.loadString(_path)
        .then((jsonData) => json.decode(jsonData));

    return BasicInfoModel(
      helloText: jsonDecoded['hello_text'],
      headline: jsonDecoded['headline'],
      subhead: jsonDecoded['subhead'],
      avatarUrl: jsonDecoded['avatar_url'],
      cvUrl: jsonDecoded['cv_url'],
      linkedInUrl: jsonDecoded['linked_in_url'],
      githubUrl: jsonDecoded['github_url'],
    );
  }
}