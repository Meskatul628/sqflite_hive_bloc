import 'package:bloc/bloc.dart';
import 'package:bloc_test_demo/core/usecase/usecase.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/sqlite_item.dart';
import '../../domain/usecases/sqlite_usecase.dart';

part 'sqlite_event.dart';
part 'sqlite_state.dart';

class SqliteBloc extends Bloc<SqliteEvent, SqliteState> {
  final GetSqliteItemsUseCase getItemsUseCase;
  final AddSqliteItemUseCase addItemUseCase;
  final UpdateSqliteItemUseCase updateItemUseCase;
  final DeleteSqliteItemUseCase deleteItemUseCase;

  SqliteBloc({
    required this.getItemsUseCase,
    required this.addItemUseCase,
    required this.updateItemUseCase,
    required this.deleteItemUseCase,
  }) : super(SqliteInitial()) {
    
    // READ
    on<GetSqliteItemsEvent>((event, emit) async {
      emit(SqliteLoading());
      final result = await getItemsUseCase(const NoPrams());
      result.fold(
        (failure) => emit(SqliteError(message: failure.message)),
        (items) => emit(SqliteLoaded(items: items)),
      );
    });

    // CREATE
    on<AddSqliteItemEvent>((event, emit) async {
      final result = await addItemUseCase(event.item);
      result.fold(
        (failure) => emit(SqliteError(message: failure.message)),
        (_) => add(GetSqliteItemsEvent()),
      );
    });

    // UPDATE
    on<UpdateSqliteItemEvent>((event, emit) async {
      final result = await updateItemUseCase(event.item);
      result.fold(
        (failure) => emit(SqliteError(message: failure.message)),
        (_) => add(GetSqliteItemsEvent()),
      );
    });

    // DELETE
    on<DeleteSqliteItemEvent>((event, emit) async {
      final result = await deleteItemUseCase(event.id);
      result.fold(
        (failure) => emit(SqliteError(message: failure.message)),
        (_) => add(GetSqliteItemsEvent()),
      );
    });
  }
}
