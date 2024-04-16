import 'package:flutter/material.dart';
import 'package:test/services/database/firestore.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<String> _categories = [];

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  void loadCategories() async {
    List<String> categoriesFromDb = await getCategoryFromDb();
    setState(() {
      _categories = categoriesFromDb;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            const Text("Manage Categories", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255))),
            const SizedBox(height: 20),
            Expanded(
              child: _categories.isEmpty
                  ? const Center(
                      child: Text('No categories yet.',
                          style: TextStyle(color: Colors.white60, fontSize: 16)),
                    )
                  : ListView.builder(
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        return _categRow(_categories[index], index);
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddCategoryDialog,
        // ignore: sort_child_properties_last
        child: const Icon(Icons.add),
        backgroundColor: Colors.greenAccent,
      ),
    );
  }

  Widget _categRow(String title, int index) {
    return Card(
      color: Colors.grey[850],
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title, style: const TextStyle(color: Colors.white)),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.redAccent),
          onPressed: () => _removeCategory(index),
        ),
      ),
    );
  }

  void _showAddCategoryDialog() {
    TextEditingController categoryController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Category'),
          content: TextField(
            controller: categoryController,
            decoration: const InputDecoration(hintText: "Enter category name"),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (categoryController.text.isNotEmpty) {
                  setState(() {
                    _categories.add(categoryController.text);
                  });
                  updateOrCreateCategory(_categories);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _removeCategory(int index) {
    setState(() {
      _categories.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Category removed successfully."),
        backgroundColor: Colors.green,
      )
    );
  }

  Future<List<String>> getCategoryFromDb() async {
    return await FireStoreService().getCategoriesFromDB();
  }
  
  void updateOrCreateCategory(List<String> categories) {
    FireStoreService().updateOrCreateCategory(categories);
  }
}
