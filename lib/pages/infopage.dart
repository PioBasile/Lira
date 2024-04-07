import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  Info({super.key});

  final TextEditingController editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      body: SingleChildScrollView( 
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, left: 25, right: 25),
              child: Column(
                children: [
                  _infoRow('Username: ', 'Placeholder'),
                  _infoRow('Password: ', 'Placeholder'),
                  _infoRow('Amount in Bank: ', 'Placeholder'),
                  _infoRow('Max spending/day: ', 'Placeholder'),
                  //Add more
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20), 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    icon: const Icon(Icons.edit, color: Colors.white, size: 18), 
                    label: const Text('Edit', style: TextStyle(color: Colors.white, fontSize: 16)), 
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12), 
                      backgroundColor: Colors.grey[850],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), 
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value) {
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
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 20)),
        ],
      ),
    );
  }
}
