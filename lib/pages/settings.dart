import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:test/services/database/db_manip.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isDarkMode = true;
  String selectedCurrency = 'USD';
  String selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    Map<String, dynamic> settings = await FireStoreService().getSettingsFromDB();
    setState(() {
      isDarkMode = settings['isDark'];
      selectedCurrency = settings['currency'];
      selectedLanguage = settings['language'];
    });
  }

  Future<void> _saveSettings() async {
    await FireStoreService().saveOrUpdateSettings(isDarkMode, selectedLanguage, selectedCurrency);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? const Color.fromARGB(255, 18, 18, 18) : Colors.white,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
        backgroundColor: isDarkMode ? const Color.fromARGB(255, 18, 18, 18) : Colors.white,
        iconTheme: IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            _buildLanguageRow(),
            _infoDivider(),
            _buildThemeRow(),
            _infoDivider(),
            _buildCurrencyRow(),
            const SizedBox(height: 50),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  FireStoreService().deleteAccount();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: const Text('Delete Account'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Language',
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          DropdownButton<String>(
            value: selectedLanguage,
            dropdownColor: isDarkMode ? const Color.fromARGB(255, 18, 18, 18) : Colors.white,
            items: <String>['English', 'Français'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedLanguage = newValue!;
                _saveSettings();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildThemeRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Theme',
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              Text(
                isDarkMode ? 'Dark Mode' : 'Flashbang Mode',
                style: TextStyle(
                  color: isDarkMode ? Colors.white70 : Colors.black87,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 10),
              CupertinoSwitch(
                value: isDarkMode,
                onChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                    _saveSettings();
                  });
                },
                activeColor: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Currency',
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          DropdownButton<String>(
            value: selectedCurrency,
            dropdownColor: isDarkMode ? const Color.fromARGB(255, 18, 18, 18) : Colors.white,
            items: <String>['USD', 'EUR'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedCurrency = newValue!;
                _saveSettings();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _infoDivider() {
    return Divider(
      height: 40,
      thickness: 1.0,
      color: isDarkMode ? Colors.white24 : Colors.black26,
    );
  }
}
