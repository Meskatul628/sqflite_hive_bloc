part of 'sqlite_bloc.dart';

sealed class SqliteState extends Equatable {
  const SqliteState();

  @override
  List<Object?> get props => [];
}

final class SqliteInitial extends SqliteState {}

final class SqliteLoading extends SqliteState {}

final class SqliteLoaded extends SqliteState {
  final List<SqliteItem> items;

  const SqliteLoaded({required this.items});

  @override
  List<Object?> get props => [items];
}

final class SqliteError extends SqliteState {
  final String message;

  const SqliteError({required this.message});

  @override
  List<Object?> get props => [message];
}
