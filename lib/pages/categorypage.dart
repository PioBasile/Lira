import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return _categRow('Category $index');
            },
          ),
        ),
      ),
    );
  }

  Widget _categRow(String title) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 30), 
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 76, 75, 75), 
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 20)),
          IconButton(onPressed: () => {}, icon: const Icon(Icons.remove, color: Colors.red, size: 30),)
        ],
      ),
    );
  }
}