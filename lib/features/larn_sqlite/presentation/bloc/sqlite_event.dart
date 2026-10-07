part of 'sqlite_bloc.dart';

sealed class SqliteEvent extends Equatable {
  const SqliteEvent();

  @override
  List<Object?> get props => [];
}

class GetSqliteItemsEvent extends SqliteEvent {}

class AddSqliteItemEvent extends SqliteEvent {
  final SqliteItem item;
  const AddSqliteItemEvent(this.item);

  @override
  List<Object?> get props => [item];
}

class UpdateSqliteItemEvent extends SqliteEvent {
  final SqliteItem item;
  const UpdateSqliteItemEvent(this.item);

  @override
  List<Object?> get props => [item];
}

class DeleteSqliteItemEvent extends SqliteEvent {
  final int id;
  const DeleteSqliteItemEvent(this.id);

  @override
  List<Object?> get props => [id];
}
