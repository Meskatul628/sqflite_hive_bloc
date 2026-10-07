import 'package:bloc_test_demo/core/error/failure.dart';
import 'package:bloc_test_demo/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import '../entities/larn_hive.dart';
import '../repositories/larn_hive_repository.dart';

class GetLarnHiveItemsUseCase implements Usecase<Either<Failure, List<LarnHiveItem>>, NoPrams> {
  final LarnHiveRepository repository;

  GetLarnHiveItemsUseCase(this.repository);

  @override
  Future<Either<Failure, List<LarnHiveItem>>> call(NoPrams params) {
    return repository.getItems();
  }
}

class AddLarnHiveItemUseCase implements Usecase<Either<Failure, void>, LarnHiveItem> {
  final LarnHiveRepository repository;

  AddLarnHiveItemUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(LarnHiveItem item) {
    return repository.addItem(item);
  }
}

class UpdateLarnHiveItemUseCase implements Usecase<Either<Failure, void>, LarnHiveItem> {
  final LarnHiveRepository repository;

  UpdateLarnHiveItemUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(LarnHiveItem item) {
    return repository.updateItem(item);
  }
}

class DeleteLarnHiveItemUseCase implements Usecase<Either<Failure, void>, String> {
  final LarnHiveRepository repository;

  DeleteLarnHiveItemUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(String id) {
    return repository.deleteItem(id);
  }
}
