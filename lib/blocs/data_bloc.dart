import 'package:cv/data/data_repository.dart';
import 'package:cv/models/basic_info_model.dart';

class DataBloc {
  final DataRepository _dataRepository = DataRepository();

  Stream<BasicInfoModel> fetchBasicInfo() =>
      _dataRepository.fetchBasicInfo().asStream().asBroadcastStream();
}