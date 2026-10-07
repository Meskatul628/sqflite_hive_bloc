import '../../domain/entities/sqlite_item.dart';

class SqliteItemModel extends SqliteItem {
  const SqliteItemModel({
    super.id,
    required super.title,
    required super.content,
    required super.createdAt,
  });

  factory SqliteItemModel.fromEntity(SqliteItem item) {
    return SqliteItemModel(
      id: item.id,
      title: item.title,
      content: item.content,
      createdAt: item.createdAt,
    );
  }

  // SQLite DB row -> Model
  factory SqliteItemModel.fromMap(Map<String, dynamic> map) {
    return SqliteItemModel(
      id: map['id'] as int?,
      title: map['title'] as String? ?? '',
      content: map['content'] as String? ?? '',
      createdAt: map['created_at'] as String? ?? '',
    );
  }

  // Model -> SQLite DB row
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'title': title,
      'content': content,
      'created_at': createdAt,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
