import 'package:bloc_test_demo/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/sqlite_item.dart';
import '../../domain/repositories/sqlite_repository.dart';
import '../datasources/sqlite_local_datasource.dart';
import '../models/sqlite_item_model.dart';

class SqliteRepositoryImpl implements SqliteRepository {
  final SqliteLocalDataSource localDataSource;

  SqliteRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<SqliteItem>>> getItems() async {
    try {
      final items = await localDataSource.getItems();
      return Right(items);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> addItem(SqliteItem item) async {
    try {
      final model = SqliteItemModel.fromEntity(item);
      final id = await localDataSource.addItem(model);
      return Right(id);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> updateItem(SqliteItem item) async {
    try {
      final model = SqliteItemModel.fromEntity(item);
      final count = await localDataSource.updateItem(model);
      return Right(count);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> deleteItem(int id) async {
    try {
      final count = await localDataSource.deleteItem(id);
      return Right(count);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
