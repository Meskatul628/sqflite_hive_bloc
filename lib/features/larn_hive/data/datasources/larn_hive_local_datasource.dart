import 'package:hive/hive.dart';
import '../models/larn_hive_model.dart';

abstract class LarnHiveLocalDataSource {
  Future<List<LarnHiveModel>> getItems();
  Future<void> addItem(LarnHiveModel item);
  Future<void> updateItem(LarnHiveModel item);
  Future<void> deleteItem(String id);
}

class LarnHiveLocalDataSourceImpl implements LarnHiveLocalDataSource {
  static const String boxName = 'larn_hive_box';

  Box get _box => Hive.box(boxName);

  @override
  Future<List<LarnHiveModel>> getItems() async {
    final List<LarnHiveModel> items = [];
    for (var value in _box.values) {
      if (value is Map) {
        items.add(LarnHiveModel.fromMap(value));
      }
    }
    return items;
  }

  @override
  Future<void> addItem(LarnHiveModel item) async {
    // Hive CRUD - Create: box.put(key, value)
    await _box.put(item.id, item.toMap());
  }

  @override
  Future<void> updateItem(LarnHiveModel item) async {
    // Hive CRUD - Update: box.put(existingKey, newValue)
    await _box.put(item.id, item.toMap());
  }

  @override
  Future<void> deleteItem(String id) async {
    // Hive CRUD - Delete: box.delete(key)
    await _box.delete(id);
  }
}
