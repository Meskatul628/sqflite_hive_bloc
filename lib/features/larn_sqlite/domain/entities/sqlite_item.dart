import 'package:equatable/equatable.dart';

class SqliteItem extends Equatable {
  final int? id; // SQLite-এ সাধারণত Auto Increment integer ID থাকে
  final String title;
  final String content;
  final String createdAt;

  const SqliteItem({
    this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, title, content, createdAt];
}
