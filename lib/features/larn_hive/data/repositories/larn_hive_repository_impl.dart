import 'package:bloc_test_demo/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/larn_hive.dart';
import '../../domain/repositories/larn_hive_repository.dart';
import '../datasources/larn_hive_local_datasource.dart';
import '../models/larn_hive_model.dart';

class LarnHiveRepositoryImpl implements LarnHiveRepository {
  final LarnHiveLocalDataSource localDataSource;

  LarnHiveRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<LarnHiveItem>>> getItems() async {
    try {
      final items = await localDataSource.getItems();
      return Right(items);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addItem(LarnHiveItem item) async {
    try {
      final model = LarnHiveModel.fromEntity(item);
      await localDataSource.addItem(model);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateItem(LarnHiveItem item) async {
    try {
      final model = LarnHiveModel.fromEntity(item);
      await localDataSource.updateItem(model);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteItem(String id) async {
    try {
      await localDataSource.deleteItem(id);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
