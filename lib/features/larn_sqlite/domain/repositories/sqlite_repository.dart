import 'package:bloc_test_demo/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/sqlite_item.dart';

abstract class SqliteRepository {
  Future<Either<Failure, List<SqliteItem>>> getItems();
  Future<Either<Failure, int>> addItem(SqliteItem item);
  Future<Either<Failure, int>> updateItem(SqliteItem item);
  Future<Either<Failure, int>> deleteItem(int id);
}
