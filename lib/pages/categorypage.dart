import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final List<String> _categories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      body: _categories.isEmpty
        ? const Center(
            child: Text('No categories yet.', style: TextStyle(color: Colors.white)),
          )
        : ListView.builder(
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              return _categRow(_categories[index], index);
            },
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddCategoryDialog,
        // ignore: sort_child_properties_last
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showAddCategoryDialog() {
    // ignore: no_leading_underscores_for_local_identifiers
    TextEditingController _categoryController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Category'),
          content: TextField(
            controller: _categoryController,
            decoration: const InputDecoration(hintText: "Enter category name"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (_categoryController.text.isNotEmpty) {
                  setState(() {
                    _categories.add(_categoryController.text);
                    Navigator.of(context).pop();
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget _categRow(String title, int index) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 76, 75, 75), 
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 20)),
          IconButton(
            onPressed: () => _removeCategory(index),
            icon: const Icon(Icons.remove, color: Colors.red, size: 30),
          ),
        ],
      ),
    );
  }

  void _removeCategory(int index) {
    setState(() {
      _categories.removeAt(index);
    });
  }
}
