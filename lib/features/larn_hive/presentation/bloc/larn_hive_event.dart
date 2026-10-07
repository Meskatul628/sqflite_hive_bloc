part of 'larn_hive_bloc.dart';

sealed class LarnHiveEvent extends Equatable {
  const LarnHiveEvent();

  @override
  List<Object?> get props => [];
}

class GetItemsEvent extends LarnHiveEvent {}

class AddItemEvent extends LarnHiveEvent {
  final LarnHiveItem item;
  const AddItemEvent(this.item);

  @override
  List<Object?> get props => [item];
}

class UpdateItemEvent extends LarnHiveEvent {
  final LarnHiveItem item;
  const UpdateItemEvent(this.item);

  @override
  List<Object?> get props => [item];
}

class DeleteItemEvent extends LarnHiveEvent {
  final String id;
  const DeleteItemEvent(this.id);

  @override
  List<Object?> get props => [id];
}
