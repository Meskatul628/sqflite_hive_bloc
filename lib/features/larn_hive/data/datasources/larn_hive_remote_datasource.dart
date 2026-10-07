import '../models/larn_hive_model.dart';

abstract class LarnHiveRemoteDataSource {
  Future<LarnHiveModel> getLarnHive();
}

class LarnHiveRemoteDataSourceImpl implements LarnHiveRemoteDataSource {
  @override
  Future<LarnHiveModel> getLarnHive() async {
    // TODO: Implement API call
    throw UnimplementedError();
  }
}
