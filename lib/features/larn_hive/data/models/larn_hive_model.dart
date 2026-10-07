import '../../domain/entities/larn_hive.dart';

class LarnHiveModel extends LarnHiveItem {
  const LarnHiveModel({
    required super.id,
    required super.title,
    required super.description,
  });

  factory LarnHiveModel.fromEntity(LarnHiveItem item) {
    return LarnHiveModel(
      id: item.id,
      title: item.title,
      description: item.description,
    );
  }

  factory LarnHiveModel.fromMap(Map<dynamic, dynamic> map) {
    return LarnHiveModel(
      id: map['id']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}
