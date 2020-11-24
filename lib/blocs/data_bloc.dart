import 'package:cv/data/data_repository.dart';
import 'package:cv/models/education_model.dart';
import 'package:cv/models/project_model.dart';
import 'package:cv/models/user_model.dart';

class DataBloc {
  final DataRepository _dataRepository = DataRepository();

  Stream<UserModel> fetchUser() =>
      _dataRepository.fetchUser().asStream().asBroadcastStream();

  Stream<List<ProjectModel>> fetchProjects() =>
      _dataRepository.fetchProjects().asStream().asBroadcastStream();

  Stream<EducationModel> fetchEducation() =>
      _dataRepository.fetchEducation().asStream().asBroadcastStream();
}