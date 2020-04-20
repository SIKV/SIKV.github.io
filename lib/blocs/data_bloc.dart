import 'package:cv/data/data_repository.dart';
import 'package:cv/models/user_model.dart';

class DataBloc {
  final DataRepository _dataRepository = DataRepository();

  Stream<UserModel> fetchUser() =>
      _dataRepository.fetchUser().asStream().asBroadcastStream();
}