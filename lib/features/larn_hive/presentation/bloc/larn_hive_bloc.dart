import 'package:bloc/bloc.dart';
import 'package:bloc_test_demo/core/usecase/usecase.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/larn_hive.dart';
import '../../domain/usecases/larn_hive_usecase.dart';

part 'larn_hive_event.dart';
part 'larn_hive_state.dart';

class LarnHiveBloc extends Bloc<LarnHiveEvent, LarnHiveState> {
  final GetLarnHiveItemsUseCase getItemsUseCase;
  final AddLarnHiveItemUseCase addItemUseCase;
  final UpdateLarnHiveItemUseCase updateItemUseCase;
  final DeleteLarnHiveItemUseCase deleteItemUseCase;

  LarnHiveBloc({
    required this.getItemsUseCase,
    required this.addItemUseCase,
    required this.updateItemUseCase,
    required this.deleteItemUseCase,
  }) : super(LarnHiveInitial()) {
    
    // READ / LOAD
    on<GetItemsEvent>((event, emit) async {
      emit(LarnHiveLoading());
      final result = await getItemsUseCase(const NoPrams());
      result.fold(
        (failure) => emit(LarnHiveError(message: failure.message)),
        (items) => emit(LarnHiveLoaded(items: items)),
      );
    });

    // CREATE
    on<AddItemEvent>((event, emit) async {
      final result = await addItemUseCase(event.item);
      result.fold(
        (failure) => emit(LarnHiveError(message: failure.message)),
        (_) => add(GetItemsEvent()), // ডাটা যোগ করার পর অটোমেটিক লিস্ট রিফ্রেশ
      );
    });

    // UPDATE
    on<UpdateItemEvent>((event, emit) async {
      final result = await updateItemUseCase(event.item);
      result.fold(
        (failure) => emit(LarnHiveError(message: failure.message)),
        (_) => add(GetItemsEvent()), // ডাটা আপডেট করার পর লিস্ট রিফ্রেশ
      );
    });

    // DELETE
    on<DeleteItemEvent>((event, emit) async {
      final result = await deleteItemUseCase(event.id);
      result.fold(
        (failure) => emit(LarnHiveError(message: failure.message)),
        (_) => add(GetItemsEvent()), // ডাটা ডিলিট করার পর লিস্ট রিফ্রেশ
      );
    });
  }
}
