import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test/services/auth/auth_service.dart';
import 'package:test/services/calculations/calculations.dart';
import 'package:test/services/database/firestore.dart'; // For changing status bar color

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  final TextEditingController editController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController amountEndOfMounthController =
      TextEditingController();
  final TextEditingController amountBankController = TextEditingController();
  final TextEditingController maxSpendingController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  User? user = AuthService().getCurrentUser();

  Map<String, double> info = {};

  @override
  void initState() {
    super.initState();
    _loadInfo();
    _loadEmailAndPassword();
    getAEOM();
    _saveInfo();
    syncAmountInBankWithEOM();
  }

  @override
  Widget build(BuildContext context) {
    // Optional: Change the status bar color to match the dark theme
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
    ));

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 50, bottom: 30),
              child: Center(
                child: Text(
                  "Account Information",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  _infoRow('Email: ', emailController.text),
                  _infoDivider(),
                  _infoRow('Password: ', '***********'),
                  _infoDivider(),
                  _infoRow('Salary ', salaryController.text),
                  _infoDivider(),
                  _infoRow('Amount in Bank: ', amountBankController.text),
                  _infoDivider(),
                  _infoRow('Max spending/day: ', maxSpendingController.text),
                  _infoDivider(),
                  _infoRow('Amount in Bank End of Month: ',
                      amountEndOfMounthController.text),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.edit, size: 20),
                label: const Text('Edit Profile'),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueGrey[700], // Text color
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
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

  void syncAmountInBankWithEOM() {
    //get today
    String today = DateTime.now().day.toString();

    //get last day in a month
    int lastDay =
        DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day;

    if (today == lastDay.toString()) {
      if (amountBankController == amountEndOfMounthController) {
        return;
      }
      amountBankController.text = amountEndOfMounthController.text;
    }
  }

  void _loadEmailAndPassword() async {
    setState(() {
      emailController.text = user?.email ?? '';
    });
  }

  void _loadInfo() async {
    Map<String, double> infoFromDb = await FireStoreService().getInfoFromDB();
    setState(() {
      info = infoFromDb;
      salaryController.text = info['salary']?.toString() ?? '0';
      amountBankController.text = info['amountBank']?.toString() ?? '0';
      maxSpendingController.text = info['maxSpendPerDay']?.toString() ?? '0';

      String today = DateTime.now().day.toString();
      String month = DateTime.now().month.toString();
      String year = DateTime.now().year.toString();

      double sync = syncBankAmountToDay(today, month, year);

      // ignore: avoid_print
      print(" syncBankToday = $sync");

      amountBankController.text = sync.toString();
    });
  }

  void getAEOM() async {
    bool dataLoaded = await loadAllData();
    if (dataLoaded) {
      setState(() {
        amountEndOfMounthController.text = getEOM().toString();
      });
    } else {
      // ignore: avoid_print
      print("Failed to load data");
    }
  }

  void _saveInfo() async {
    double? amountBank = double.tryParse(amountBankController.text);
    double? maxSpendPerDay = double.tryParse(maxSpendingController.text);
    double? salary = double.tryParse(salaryController.text);

    if (salary == null || amountBank == null || maxSpendPerDay == null) {
      return;
    }

    await FireStoreService().updateOrCreateInfo(
      salary,
      maxSpendPerDay,
      amountBank,
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
