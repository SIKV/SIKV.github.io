import 'dart:convert';
import 'dart:core';

import 'package:cv/models/education_model.dart';
import 'package:cv/models/experience_model.dart';
import 'package:cv/models/project_model.dart';
import 'package:cv/models/user_model.dart';
import 'package:flutter/services.dart';

class DataRepository {
  final String _path = 'data.json';

  Future<UserModel> fetchUser() async {
    final jsonDecoded = await rootBundle.loadString(_path)
        .then((jsonData) => json.decode(jsonData));

    return UserModel.fromJson(jsonDecoded);
  }

  Future<List<ProjectModel>> fetchProjects() async {
    final jsonDecoded = await rootBundle.loadString(_path)
        .then((jsonData) => json.decode(jsonData));

    List projects = List<ProjectModel>();

    jsonDecoded['projects'].forEach((projectJson) {
      projects.add(ProjectModel.fromJson(projectJson));
    });

    return projects;
  }

  Future<List<ExperienceModel>> fetchExperience() async {
    final jsonDecoded = await rootBundle.loadString(_path)
        .then((jsonData) => json.decode(jsonData));

    List experience = List<ExperienceModel>();

    jsonDecoded['experience'].forEach((experienceJson) {
      experience.add(ExperienceModel.fromJson(experienceJson));
    });

    return experience;
  }

  Future<EducationModel> fetchEducation() async {
    final jsonDecoded = await rootBundle.loadString(_path)
        .then((jsonData) => json.decode(jsonData));

    var educationJson = jsonDecoded['education'];

    return EducationModel(
      school: educationJson['school'],
      schoolUrl: educationJson['school_url'],
      degree: educationJson['degree'],
      degreeShort: educationJson['degree_short'],
      startYear: educationJson['start_year'],
      endYear: educationJson['end_year'],
    );
  }
}