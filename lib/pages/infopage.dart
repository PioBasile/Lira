import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lira/services/auth/auth_service.dart';
import 'package:lira/services/calculations/calculations.dart';
import 'package:lira/services/database/db_manip.dart'; // For changing status bar color
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController amountEndOfMonthController = TextEditingController();
  final TextEditingController amountBankController = TextEditingController();
  final TextEditingController maxSpendingController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  User? user = AuthService().getCurrentUser();

  Map<String, double> info = {};
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _loadInfo();
    _loadEmailAndPassword();
    getAEOM();
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
              padding: EdgeInsets.only(top: 50, bottom: 20),
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
                  _infoRow('Email: ', emailController, false),
                  _infoDivider(),
                  _infoRow('Password: ', TextEditingController(text: '***********'), false, readOnly: true),
                  _infoDivider(),
                  _infoRow('Salary: ', salaryController, isEditing),
                  _infoDivider(),
                  _infoRow('Amount in Bank: ', amountBankController, isEditing),
                  _infoDivider(),
                  _infoRow('Max spending/day: ', maxSpendingController, isEditing),
                  _infoDivider(),
                  _infoRow('Amount in Bank End of Month: ', amountEndOfMonthController, isEditing),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton.icon(
                icon: Icon(isEditing ? Icons.save : Icons.edit, size: 20),
                label: Text(isEditing ? 'Save Profile' : 'Edit Profile'),
                onPressed: () {
                  setState(() {
                    if (isEditing) {
                      _saveInfo();
                    }
                    isEditing = !isEditing;
                  });
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueGrey[700], // Text color
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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

  Widget _infoRow(String title, TextEditingController controller, bool isEditing, {bool readOnly = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
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
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: TextField(
                controller: controller,
                readOnly: !isEditing || readOnly,
                textAlign: TextAlign.right,
                style: const TextStyle(
                    color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: isEditing && !readOnly ? Colors.white : Colors.transparent),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: isEditing && !readOnly ? Colors.white : Colors.transparent),
                  ),
                ),
                inputFormatters: isEditing && !readOnly
                    ? [
                        FilteringTextInputFormatter.digitsOnly,
                        ThousandsFormatter(),
                      ]
                    : [],
              ),
            ),
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
      if (amountBankController == amountEndOfMonthController) {
        return;
      }
      amountBankController.text = amountEndOfMonthController.text;
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
      salaryController.text = formatNumber(info['salary'] ?? 0);
      amountBankController.text = formatNumber(info['amountBank'] ?? 0);
      maxSpendingController.text = formatNumber(info['maxSpendPerDay'] ?? 0);

      String today = DateTime.now().day.toString();
      String month = DateTime.now().month.toString();
      String year = DateTime.now().year.toString();

      double sync = syncBankAmountToDay(today, month, year);

      // ignore: avoid_print
      print(" syncBankToday = $sync");

      amountBankController.text = formatNumber(sync);
    });
  }

  void getAEOM() async {
    bool dataLoaded = await loadAllData();
    if (dataLoaded) {
      setState(() {
        amountEndOfMonthController.text = formatNumber(getEOM());
      });
    } else {
      // ignore: avoid_print
      print("Failed to load data");
    }
  }

  void _saveInfo() async {
    double? amountBank = double.tryParse(amountBankController.text.replaceAll(' ', ''));
    double? maxSpendPerDay = double.tryParse(maxSpendingController.text.replaceAll(' ', ''));
    double? salary = double.tryParse(salaryController.text.replaceAll(' ', ''));

    if (salary == null || amountBank == null || maxSpendPerDay == null) {
      return;
    }

    await FireStoreService().updateInfo(
      salary,
      maxSpendPerDay,
      amountBank,
    );
  }

  Widget _infoDivider() {
    return const Divider(
      height: 12,
      thickness: 0.5,
      color: Colors.white24,
    );
  }

  String formatNumber(double value) {
    return NumberFormat('#,###', 'en_US').format(value);
  }
}

class ThousandsFormatter extends TextInputFormatter {
  // ignore: unused_field
  static final RegExp _digitOnlyRegex = RegExp(r'\d+');

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    final digitsOnly = text.replaceAll(' ', '');
    final formattedText = NumberFormat('#,###', 'en_US').format(int.parse(digitsOnly)).replaceAll(',', ' ');

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
