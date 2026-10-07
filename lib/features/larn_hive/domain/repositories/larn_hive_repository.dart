import 'package:bloc_test_demo/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/larn_hive.dart';

abstract class LarnHiveRepository {
  Future<Either<Failure, List<LarnHiveItem>>> getItems();
  Future<Either<Failure, void>> addItem(LarnHiveItem item);
  Future<Either<Failure, void>> updateItem(LarnHiveItem item);
  Future<Either<Failure, void>> deleteItem(String id);
}
