part of 'larn_hive_bloc.dart';

sealed class LarnHiveState extends Equatable {
  const LarnHiveState();

  @override
  List<Object?> get props => [];
}

final class LarnHiveInitial extends LarnHiveState {}

final class LarnHiveLoading extends LarnHiveState {}

final class LarnHiveLoaded extends LarnHiveState {
  final List<LarnHiveItem> items;

  const LarnHiveLoaded({required this.items});

  @override
  List<Object?> get props => [items];
}

final class LarnHiveError extends LarnHiveState {
  final String message;

  const LarnHiveError({required this.message});

  @override
  List<Object?> get props => [message];
}
