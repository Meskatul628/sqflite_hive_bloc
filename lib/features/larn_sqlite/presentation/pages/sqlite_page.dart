import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/sqlite_item.dart';
import '../bloc/sqlite_bloc.dart';

class SqlitePage extends StatefulWidget {
  const SqlitePage({super.key});

  @override
  State<SqlitePage> createState() => _SqlitePageState();
}

class _SqlitePageState extends State<SqlitePage> {
  @override
  void initState() {
    super.initState();
    // পেজ ওপেন হলে SQLite ডাটাবেস থেকে ডাটা ফেচ করা
    context.read<SqliteBloc>().add(GetSqliteItemsEvent());
  }

  void _showAddOrEditDialog({SqliteItem? item}) {
    final titleController = TextEditingController(text: item?.title ?? '');
    final contentController = TextEditingController(text: item?.content ?? '');
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(item == null ? 'Add SQLite Note' : 'Edit SQLite Note'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      (value == null || value.trim().isEmpty) ? 'Please enter a title' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: contentController,
                  decoration: const InputDecoration(
                    labelText: 'Content',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) =>
                      (value == null || value.trim().isEmpty) ? 'Please enter content' : null,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final now = DateTime.now();
                  final formattedDate =
                      '${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute}';

                  if (item == null) {
                    // CREATE
                    final newItem = SqliteItem(
                      title: titleController.text.trim(),
                      content: contentController.text.trim(),
                      createdAt: formattedDate,
                    );
                    context.read<SqliteBloc>().add(AddSqliteItemEvent(newItem));
                  } else {
                    // UPDATE
                    final updatedItem = SqliteItem(
                      id: item.id,
                      title: titleController.text.trim(),
                      content: contentController.text.trim(),
                      createdAt: formattedDate,
                    );
                    context.read<SqliteBloc>().add(UpdateSqliteItemEvent(updatedItem));
                  }
                  Navigator.pop(dialogContext);
                }
              },
              child: Text(item == null ? 'Add' : 'Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQLite CRUD with BLoC'),
        centerTitle: true,
      ),
      body: BlocConsumer<SqliteBloc, SqliteState>(
        listener: (context, state) {
          if (state is SqliteError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          if (state is SqliteLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SqliteLoaded) {
            if (state.items.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.storage_rounded, size: 70, color: Colors.blueGrey.shade300),
                    const SizedBox(height: 12),
                    const Text(
                      'No SQLite Data Found!\nTap + button to insert a row.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              );
            }

            // READ: SQLite টেবিলের রো গুলো লিস্টভিউতে দেখানো
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.items.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final item = state.items[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      backgroundColor: Colors.teal.shade100,
                      child: Text(
                        '#${item.id ?? 0}',
                        style: const TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    title: Text(
                      item.title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(item.content),
                        const SizedBox(height: 4),
                        Text(
                          item.createdAt,
                          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // UPDATE বাটন
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.teal),
                          onPressed: () => _showAddOrEditDialog(item: item),
                        ),
                        // DELETE বাটন
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            if (item.id != null) {
                              context.read<SqliteBloc>().add(DeleteSqliteItemEvent(item.id!));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
      // CREATE বাটন
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        onPressed: () => _showAddOrEditDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
