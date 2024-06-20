import 'package:flutter/material.dart';
import 'package:test/services/database/firestore.dart';

class Settings extends StatelessWidget {
  Settings({super.key});

  final TextEditingController languageController = TextEditingController();
  final TextEditingController themeController = TextEditingController();
  final TextEditingController currencyController = TextEditingController();


  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight + 20.0),  
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0), 
              child: AppBar(
                title: const Text('Settings', style: TextStyle(color: Colors.white)),
                backgroundColor: const Color.fromARGB(255, 18, 18, 18),
                iconTheme: const IconThemeData(color: Colors.white),
              ),
            ),
          ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 350,
            child: SizedBox(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch, 
                  children: [
                    const SizedBox(height: 50),
                    _infoRow("language", languageController.text),
                    _infoDivider(),
                    _infoRow("theme", themeController.text),
                    _infoDivider(),
                    _infoRow("currency", currencyController.text),
                    Center(
                      child: ButtonBar(
                        alignment: MainAxisAlignment.center, 
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              FireStoreService().deleteAccount();
                            },
                            child: const Text('Delete Account'),
                          ),
                        ],
                      ),
                    ),
                  ],
              ),
            ),
          ),
        ),
      )
    );
  }


  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Colors.white70,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _infoDivider() {
    return const Divider(
      height: 20,
      thickness: 0.5,
      color: Colors.white24,
    );
  }

}