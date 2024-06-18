// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test/services/database/firestore.dart';
import 'package:intl/intl.dart';


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
String thisYear = now.year.toString();

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
List<Map<String, dynamic>> getPaymentsForMonth(String month, String year) {
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

List<Map<String, dynamic>> getReceivedPaymentsForMonth(String month, String year) {
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

List<Map<int, String>> getCategotoriesPerPaymentPerMonth(String year, String month) {
  List<Map<int, String>> categoriesPerPaymentPerMonth = [];
  List<Map<String, dynamic>> payments = getPaymentsForMonth(month, year);

  print("Payments for $month $year: $payments");

  for (int i = 0; i < payments.length; i++) {
    var categories = payments[i]['categories'];
    if (categories != null && categories is List && categories.isNotEmpty) {
      for (var category in categories) {
        if (category != null && category is String) {
          categoriesPerPaymentPerMonth.add({i + 1: category});
        }
      }
    }
    
  }

  print("Categories per payment per month: $categoriesPerPaymentPerMonth");
  return categoriesPerPaymentPerMonth;
}

// Calculate the total amount spent in a month
double calculateTotalAmount(String month, String year) {
  double totalAmount = 0;
  double totalAmountGot = 0;

  List<Map<String, dynamic>> recurringPayments = getRecurringPaymentsForMonth();
  List<Map<String, dynamic>> payments = getPaymentsForMonth(month, year);
  List<Map<String, dynamic>> receivedPayments =
      getReceivedPaymentsForMonth(month, year);

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
double calculateEOFM(
    String year, String month, double salary, double amountBank) {
  double totalAmount = calculateTotalAmount(month, year);
  double endOfMonth = salary + amountBank - totalAmount;
  return endOfMonth;
}

double getEOM() {
  Map<String, double> infoAll = getInfo();

  double salary = double.parse(infoAll['salary']?.toString() ?? '0');
  print("salary : $salary");

  double amountBank = double.parse(infoAll['amountBank']?.toString() ?? '0');
  print("amountBank : $amountBank");

  double endOfMonth = calculateEOFM(thisYear, thisMonth, salary, amountBank);
  print("end of mounth: $endOfMonth");
  return endOfMonth;
}

//-----------------------IN A DAY-----------------------

// Calculate each day how much was spent
List<double> getPaymentsInADay(String days, String month, String year) {
  List<Map<String, dynamic>> paymentsAll =
      getPayments(); // Assuming this fetches all payment data correctly
  List<double> paymentsInADay = [];

  if (days.contains("/")) {
    days = days.split("/")[0];
  }
  int dayInt = int.parse(days);
  int monthInt = int.parse(month);
  int yearInt = int.parse(year);

  for (var payment in paymentsAll) {
    DateTime date = payment['timestamp'].toDate();
    if (date.day == dayInt && date.month == monthInt && date.year == yearInt) {
      paymentsInADay.add(payment['amount']);
    }
  }
  return paymentsInADay;
}

List<double> getReceivedPaymentsInADay(String day, String month, String year) {
  
  List<Map<String, dynamic>> receivedPaymentsAll = getReceivedPayments();
  List<double> receivedPaymentsInADay = [];

  int dayInt = int.parse(day);
  int monthInt = int.parse(month);
  int yearInt = int.parse(year);
  
  for (int i = 0; i < receivedPaymentsAll.length; i++) {
    DateTime date = receivedPaymentsAll[i]['timestamp'].toDate();
    if (date.day == dayInt && date.month == monthInt && date.year == yearInt) {
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

List<Map<int, double>> spentPerDayInMonth(String month, String year) {
  DateTime now = DateTime.now();

  List<Map<int, double>> spentPerDay = [];
  int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
  for (int i = 0; i < daysInMonth; i++) {
    spentPerDay.add({i + 1: 0.0});
  }

  List<Map<String, dynamic>> payments = getPaymentsForMonth(month, year);
  List<Map<String, dynamic>> receivedPayments =
      getReceivedPaymentsForMonth(month, year);
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
    if (payment['date'] != null && payment['amount'] != null) {
      int day = int.tryParse(payment['date'].toString()) ?? 0;
      double amount = double.tryParse(payment['amount'].toString()) ?? 0.0;

      if (day >= 1 && day <= 31) {
        spentPerDay[day - 1][day] = (spentPerDay[day - 1][day] ?? 0.0) + amount;
      }
    }
  }
  print("spent per day: $spentPerDay");
  return spentPerDay;
}

double syncBankAmountToDay(String day, String month, String year) {
  Map<String, double> infoAll = getInfo();
  String amountBank = infoAll['amountBank']?.toString() ?? '0';
  double salary = double.parse(infoAll['salary']?.toString() ?? '0');

  double amountBankDouble = double.parse(amountBank);

  getPaymentsInADay(day, month, year).forEach((element) {
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
      getReceivedPaymentsForMonth(month, year);
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

List<Map<String, dynamic>> getAllInfoForCalendar(int day, String month,String year){
  List<Map<String, dynamic>> payments = getPaymentsForMonth(month, year);
  List<Map<String, dynamic>> receivedPayments = getReceivedPaymentsForMonth(month, year);
  List<Map<String, dynamic>> recurringPayments = getRecurringPaymentsForMonth();

  List<Map<String, dynamic>> allInfo = [];

  for (var payment in payments) {
    DateTime date = payment['timestamp'].toDate();
    if (date.day == day) {
      allInfo.add(payment);
    }
  }

  for (var payment in receivedPayments) {
    DateTime date = payment['timestamp'].toDate();
    if (date.day == day) {
      allInfo.add(payment);
    }
  }

  for (var payment in recurringPayments) {
    if (payment['date'] == day.toString()) {
      allInfo.add(payment);
    }
  }

  return allInfo;
}

// get all the payments for the day with description and amount and categories
List<Map<int, dynamic>> getDetailedPayedPerDay(int day, String month, String year) {
  List<Map<String, dynamic>> payments = getPaymentsForMonth(month, year);
  List<Map<int, dynamic>> detailedPayments = [];

  print("Payments for $month $year: $payments");
  
  for (int i = 0; i < payments.length; i++) {
    if (payments[i]['timestamp'] != null) {
      DateTime date = DateFormat('MMMM d, yyyy at h:mm:ss a').parse(payments[i]['timestamp']);
      if (date.day == day) {
        detailedPayments.add({i + 1: payments[i]});
      }
    }
  }
  
  print("Detailed payments: $detailedPayments");
  return detailedPayments;
}

//get all the received payments for the day with description and amount and whom
List<Map<int, dynamic>> getDetailedReceivedPerDay(int day, String month, String year){
  List<Map<String, dynamic>> receivedPayments = getReceivedPaymentsForMonth(month, year);
  
  List<Map<int, dynamic>> detailedReceivedPayments = [];
  for (int i = 0; i < receivedPayments.length; i++) {
    DateTime date = receivedPayments[i]['timestamp'].toDate();
    if (date.day == day && date.month == months.indexOf(month) + 1 && date.year == int.parse(year)){
      detailedReceivedPayments.add({i + 1: receivedPayments[i]});
    }
  }
  return detailedReceivedPayments;
}

//get all the recurring payments for the day with description and amount
List<Map<int, dynamic>> getDetailedRecurringPerDay(int day){
  List<Map<String, dynamic>> recurringPayments = getRecurringPaymentsForMonth();
  
  List<Map<int, dynamic>> detailedRecurringPayments = [];
  for (int i = 0; i < recurringPayments.length; i++) {
    if (recurringPayments[i]['date'] == day.toString()) {
      detailedRecurringPayments.add({i + 1: recurringPayments[i]});
    }
  }
  return detailedRecurringPayments;
}
