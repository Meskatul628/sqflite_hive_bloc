import 'package:bloc_test_demo/core/error/failure.dart';
import 'package:bloc_test_demo/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import '../entities/sqlite_item.dart';
import '../repositories/sqlite_repository.dart';

class GetSqliteItemsUseCase implements Usecase<Either<Failure, List<SqliteItem>>, NoPrams> {
  final SqliteRepository repository;

  GetSqliteItemsUseCase(this.repository);

  @override
  Future<Either<Failure, List<SqliteItem>>> call(NoPrams params) {
    return repository.getItems();
  }
}

class AddSqliteItemUseCase implements Usecase<Either<Failure, int>, SqliteItem> {
  final SqliteRepository repository;

  AddSqliteItemUseCase(this.repository);

  @override
  Future<Either<Failure, int>> call(SqliteItem item) {
    return repository.addItem(item);
  }
}

class UpdateSqliteItemUseCase implements Usecase<Either<Failure, int>, SqliteItem> {
  final SqliteRepository repository;

  UpdateSqliteItemUseCase(this.repository);

  @override
  Future<Either<Failure, int>> call(SqliteItem item) {
    return repository.updateItem(item);
  }
}

class DeleteSqliteItemUseCase implements Usecase<Either<Failure, int>, int> {
  final SqliteRepository repository;

  DeleteSqliteItemUseCase(this.repository);

  @override
  Future<Either<Failure, int>> call(int id) {
    return repository.deleteItem(id);
  }
}
