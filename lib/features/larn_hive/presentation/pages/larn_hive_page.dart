import 'package:bloc_test_demo/core/router/AppRoutes.dart';
import 'package:bloc_test_demo/core/theme/bloc/theme_cubit.dart';
import 'package:bloc_test_demo/core/theme/theme_context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/larn_hive.dart';
import '../bloc/larn_hive_bloc.dart';

class LarnHivePage extends StatefulWidget {
  const LarnHivePage({super.key});

  @override
  State<LarnHivePage> createState() => _LarnHivePageState();
}

class _LarnHivePageState extends State<LarnHivePage> {
  @override
  void initState() {
    super.initState();
    // পেজ ওপেন হওয়ার সাথে সাথে Hive থেকে ডাটা লোড করা
    context.read<LarnHiveBloc>().add(GetItemsEvent());
  }

  void _showAddOrEditDialog({LarnHiveItem? item}) {
    final titleController = TextEditingController(text: item?.title ?? '');
    final descriptionController =
        TextEditingController(text: item?.description ?? '');
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(item == null ? 'Add New Item' : 'Edit Item'),
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
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) =>
                      (value == null || value.trim().isEmpty) ? 'Please enter description' : null,
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
                  if (item == null) {
                    // CREATE: নতুন ডাটা তৈরি
                    final newItem = LarnHiveItem(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: titleController.text.trim(),
                      description: descriptionController.text.trim(),
                    );
                    context.read<LarnHiveBloc>().add(AddItemEvent(newItem));
                  } else {
                    // UPDATE: বিদ্যমান ডাটা আপডেট
                    final updatedItem = LarnHiveItem(
                      id: item.id,
                      title: titleController.text.trim(),
                      description: descriptionController.text.trim(),
                    );
                    context.read<LarnHiveBloc>().add(UpdateItemEvent(updatedItem));
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
        title: const Text('Hive CRUD with BLoC'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              context.isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            ),
            tooltip: 'Toggle Theme',
            onPressed: () {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
          IconButton(
            icon: const Icon(Icons.storage_rounded),
            tooltip: 'Go to SQLite Demo',
            onPressed: () {
              context.push(Approutes.sqlite);
            },
          ),
        ],
      ),
      body: BlocConsumer<LarnHiveBloc, LarnHiveState>(
        listener: (context, state) {
          if (state is LarnHiveError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          if (state is LarnHiveLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is LarnHiveLoaded) {
            if (state.items.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.inventory_2_outlined, size: 70, color: Colors.grey.shade400),
                    const SizedBox(height: 12),
                    const Text(
                      'No Hive Data Found!\nTap + button to add one.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              );
            }

            // READ: লিস্টভিউতে Hive থেকে আসা ডাটা দেখানো
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
                    title: Text(
                      item.title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(item.description),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // UPDATE বাটন
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _showAddOrEditDialog(item: item),
                        ),
                        // DELETE বাটন
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            context.read<LarnHiveBloc>().add(DeleteItemEvent(item.id));
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
        onPressed: () => _showAddOrEditDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
