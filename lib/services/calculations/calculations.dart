// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test/services/database/firestore.dart';

List<Map<String, dynamic>> payments = [];
List<Map<String, dynamic>> receivedPayments = [];
List<Map<String, dynamic>> recurringPayments = [];
Map<String, double> info = {};
List<String> months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];
DateTime now = DateTime.now();
String thisMonth = months[now.month - 1];

//get all the variables from the database
Future<bool> loadAllData() async {
  try {
    payments = await FireStoreService().getTransactionsFromDB();
    print("Transactions loaded: ${payments.length}");

    receivedPayments = await FireStoreService().getReceivedPaymentsFromDB();
    print("Received payments loaded: ${receivedPayments.length}");

    recurringPayments =
        await FireStoreService().getRecurringTransactionsFromDB();
    print("Recurring payments loaded: ${recurringPayments.length}");

    info = await FireStoreService().getInfoFromDB();
    print("Info loaded: ${info.keys.length}");
  } catch (e) {
    print("Error loading data: $e");
    return false;
  }
  return true;
}

List<Map<String, dynamic>> getPayments() {
  return payments;
}

List<Map<String, dynamic>> getReceivedPayments() {
  return receivedPayments;
}

List<Map<String, dynamic>> getRecurringPayments() {
  return recurringPayments;
}

Map<String, double> getInfo() {
  return info;
}
// Map<String, double> infoAll = getInfo();

// String salary = infoAll['salary']?.toString() ?? '0';
// String amountBank = infoAll['amountBank']?.toString() ?? '0';
// String maxSpending = infoAll['maxSpendPerDay']?.toString() ?? '0';

// Get the payments for a specific month
List<Map<String, dynamic>> getPaymentsForMonth(String month) {
  List<Map<String, dynamic>> paymentsAll = getPayments();

  List<Map<String, dynamic>> paymentsForMonth = [];
  for (int i = 0; i < paymentsAll.length; i++) {
    DateTime date = paymentsAll[i]['timestamp'].toDate();
    if (months[date.month - 1] == month) {
      paymentsForMonth.add(paymentsAll[i]);
    }
  }
  print("payment per mounth : $paymentsForMonth");
  return paymentsForMonth;
}

List<Map<String, dynamic>> getReceivedPaymentsForMonth(String month) {
  List<Map<String, dynamic>> receivedPaymentsForMonth = [];
  List<Map<String, dynamic>> receivedPaymentsAll = getReceivedPayments();

  for (int i = 0; i < receivedPaymentsAll.length; i++) {
    DateTime date = receivedPaymentsAll[i]['timestamp'].toDate();
    if (months[date.month - 1] == month) {
      receivedPaymentsForMonth.add(receivedPaymentsAll[i]);
    }
  }
  print("received payments: $receivedPaymentsForMonth");
  return receivedPaymentsForMonth;
}

List<Map<String, dynamic>> getRecurringPaymentsForMonth() {
  List<Map<String, dynamic>> recurringPaymentsForMonth = [];
  List<Map<String, dynamic>> recurringPaymentsAll = getRecurringPayments();

  for (int i = 0; i < recurringPaymentsAll.length; i++) {
    recurringPaymentsForMonth.add(recurringPaymentsAll[i]);
  }
  print("reccuring payments: $recurringPaymentsForMonth");
  return recurringPaymentsForMonth;
}

// Calculate the total amount spent in a month
double calculateTotalAmount(String month) {
  double totalAmount = 0;
  double totalAmountGot = 0;

  List<Map<String, dynamic>> recurringPayments = getRecurringPaymentsForMonth();
  List<Map<String, dynamic>> payments = getPaymentsForMonth(month);
  List<Map<String, dynamic>> receivedPayments =getReceivedPaymentsForMonth(month);

  for (int i = 0; i < payments.length; i++) {
    totalAmount = payments[i]['amount'] + totalAmount;
  }

  for (int i = 0; i < receivedPayments.length; i++) {
    totalAmountGot = receivedPayments[i]['amount'] + totalAmountGot;
  }

  for (int i = 0; i < recurringPayments.length; i++) {
    totalAmount = recurringPayments[i]['amount'] + totalAmount;
  }

  print("total amount : ${totalAmount - totalAmountGot}");
  return (totalAmount - totalAmountGot);
}

// Calculate the end of the month amount
double calculateEOFM(String month, double salary, double amountBank) {
  double totalAmount = calculateTotalAmount(month);
  double endOfMonth = salary + amountBank - totalAmount;
  return endOfMonth;
}

double getEOM() {
  Map<String, double> infoAll = getInfo();

  double salary = double.parse(infoAll['salary']?.toString() ?? '0');
  print("salary : $salary");

  double amountBank = double.parse(infoAll['amountBank']?.toString() ?? '0');
  print("amountBank : $amountBank");

  double endOfMonth = calculateEOFM(thisMonth, salary, amountBank);
  print("end of mounth: $endOfMonth");
  return endOfMonth;
}

//-----------------------IN A DAY-----------------------

// Calculate each day how much was spent
List<double> getPaymentsInADay(String day, String month, String year) {
  List<Map<String, dynamic>> paymentsAll = getPayments();
  List<double> paymentsInADay = [];
  for (int i = 0; i < paymentsAll.length; i++) {
    DateTime date = paymentsAll[i]['timestamp'].toDate();
    if (date.day.toString() == day && months[date.month - 1] == month && date.year.toString() == year) {
      paymentsInADay.add(paymentsAll[i]['amount']);
    }
  }
  return paymentsInADay;
}

List<double> getReceivedPaymentsInADay(String day, String month, String year) {
  List<Map<String, dynamic>> receivedPaymentsAll = getReceivedPayments();
  List<double> receivedPaymentsInADay = [];
  for (int i = 0; i < receivedPaymentsAll.length; i++) {
    DateTime date = receivedPaymentsAll[i]['timestamp'].toDate();
    if (date.day.toString() == day && months[date.month - 1] == month && date.year.toString() == year) {
      receivedPaymentsInADay.add(receivedPaymentsAll[i]['amount']);
    }
  }
  return receivedPaymentsInADay;
}

List<double> getRecurringPaymentsInADay(String day) {
  List<Map<String, dynamic>> recurringPaymentsAll = getRecurringPayments();
  List<double> recurringPaymentsInADay = [];
  for (int i = 0; i < recurringPaymentsAll.length; i++) {
    String date = recurringPaymentsAll[i]['date'].toString();
    if (date == day) {
      recurringPaymentsInADay.add(recurringPaymentsAll[i]['amount']);
    }
  }
  return recurringPaymentsInADay;
}



List<Map<int, double>> spentPerDayInMonth(String month) {

  DateTime now = DateTime.now();

  List<Map<int, double>> spentPerDay = [];
  int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
  for (int i = 0; i < daysInMonth; i++) {
    spentPerDay.add({i + 1: 0.0});
  }

  List<Map<String, dynamic>> payments = getPaymentsForMonth(month);
  List<Map<String, dynamic>> receivedPayments =getReceivedPaymentsForMonth(month);
  List<Map<String, dynamic>> recurringPayments = getRecurringPaymentsForMonth();

  // Process payments
  for (var payment in payments) {
    if (payment['timestamp'] != null) {
      DateTime date = (payment['timestamp'] as Timestamp).toDate();
      int day = date.day;
      spentPerDay[day - 1][day] =
          (spentPerDay[day - 1][day] ?? 1) + payment['amount'];
    }
  }

  // Process received payments
  for (var payment in receivedPayments) {
    if (payment['timestamp'] != null) {
      DateTime date = (payment['timestamp'] as Timestamp).toDate();
      int day = date.day;
      spentPerDay[day - 1][day] =
          (spentPerDay[day - 1][day] ?? 1) - payment['amount'];
    }
  }

  // Process recurring payments
  for (var payment in recurringPayments) {
    if (payment['date'] != null) {
      DateTime date = (payment['date'] as Timestamp).toDate();
      int day = date.day;
      spentPerDay[day - 1][day] =
          (spentPerDay[day - 1][day] ?? 1) + payment['date'];
    }
  }
  return spentPerDay;
}

double syncBankAmountToDay(String day, String month, String year) {
  Map<String, double> infoAll = getInfo();
  String amountBank = infoAll['amountBank']?.toString() ?? '0';
  double salary = double.parse(infoAll['salary']?.toString() ?? '0');

  double amountBankDouble = double.parse(amountBank);

  getPaymentsInADay(day,month,year).forEach((element) {
    amountBankDouble -= element;
  });

  List<Map<String, dynamic>> reccuringPayments = getRecurringPaymentsForMonth();
  int dateI;

  for (var element in reccuringPayments) {
    String date = (element['date']);
    dateI = int.parse(date);

    if (dateI == int.parse(day)) {
      amountBankDouble -= element['amount'];
    }
  }

  List<Map<String, dynamic>> receivedPayments =
      getReceivedPaymentsForMonth(month);
  for (var element in receivedPayments) {
    DateTime date = element['timestamp'].toDate();
    if (date.day.toString() == day) {
      amountBankDouble += element['amount'];
    }
  }

  amountBankDouble = amountBankDouble + salary;

  print("amount bank today: $amountBankDouble");
  return amountBankDouble;
}
