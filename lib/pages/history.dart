// ignore_for_file: avoid_print, library_private_types_in_public_api
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:test/components/history_detailed_row.dart';
import 'package:test/services/calculations/calculations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class History extends StatefulWidget {
  const History({super.key});
  
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  DateTime selectedDate = DateTime.now();

  List<Map<String, dynamic>> getDataMap() {
    String month = DateFormat('MMMM').format(selectedDate);
    int year = selectedDate.year;
    return getAllInfoForHistory(month, year.toString());
  }

  void _incrementMonth() {
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month + 1);
    });
  }

  void _decrementMonth() {
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month - 1);
    });
  }

  String formatDate(DateTime date) {
    final daySuffix = (date.day == 1 || date.day == 21 || date.day == 31) ? 'st'
      : (date.day == 2 || date.day == 22) ? 'nd'
      : (date.day == 3 || date.day == 23) ? 'rd'
      : 'th';
    return DateFormat('EEEE d').format(date) + daySuffix;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> dataMap = getDataMap();

    // Group transactions by date and keep actual DateTime objects for sorting
    Map<DateTime, List<Map<String, dynamic>>> groupedData = {};
    for (var item in dataMap) {
      DateTime timestamp;
      if (item['timestamp'] != null) {
        timestamp = item['timestamp'].toDate();
      } else {
        timestamp = DateTime.now(); // Default to now if no timestamp
      }
      DateTime dateWithoutTime = DateTime(timestamp.year, timestamp.month, timestamp.day);
      if (!groupedData.containsKey(dateWithoutTime)) {
        groupedData[dateWithoutTime] = [];
      }
      groupedData[dateWithoutTime]!.add(item);
    }

    // Sort dates in descending order
    List<DateTime> sortedDates = groupedData.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 20.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: AppBar(
            title: const Text('History', style: TextStyle(color: Colors.white)),
            backgroundColor: const Color.fromARGB(255, 18, 18, 18),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_left, color: Colors.white),
                onPressed: _decrementMonth,
              ),
              Text(
                DateFormat('MMMM yyyy').format(selectedDate),
                style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_right, color: Colors.white),
                onPressed: _incrementMonth,
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: sortedDates.length,
              itemBuilder: (context, index) {
                DateTime date = sortedDates[index];
                String formattedDate = formatDate(date);
                List<Map<String, dynamic>> transactions = groupedData[date]!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '- $formattedDate ',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 1.0,
                            indent: 16.0,
                            endIndent: 16.0,
                          ),
                        ],
                      ),
                    ),
                    ...transactions.map((item) {
                      String time = '';
                      if (item['timestamp'] != null) {
                        try {
                          time = DateFormat('HH:mm').format(item['timestamp'].toDate());
                        } catch (e) {
                          print('Error formatting date: $e');
                        }
                      }

                      String detail = '';
                      if (item.containsKey('categories') && item['categories'] != null) {
                        detail = (item['categories'] as List<dynamic>).join(', ');
                      } else if (item.containsKey('personneWhoSentMoney') && item['personneWhoSentMoney'] != null) {
                        detail = item['personneWhoSentMoney'];
                      } else {
                        detail = 'Not specified';
                      }

                      return HistoryTransactionRow(
                        type: item['type'], // Adjust this according to your data structure
                        amount: item['amount'],
                        time: time,
                        description: item['description'],
                        detail: detail,
                      );
                    }),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

List<Map<String, dynamic>> getAllInfoForHistory(String month, String year) {
  List<Map<String, dynamic>> payments = getPaymentsForMonth(month, year);
  List<Map<String, dynamic>> receivedPayments = getReceivedPaymentsForMonth(month, year);
  List<Map<String, dynamic>> recurringPayments = getRecurringPaymentsForMonth();

  List<Map<String, dynamic>> allInfo = [];

  for (var payment in payments) {
    payment['type'] = 'Payment'; 
    allInfo.add(payment);
  }

  for (var payment in receivedPayments) {
    payment['type'] = 'Received'; 
    allInfo.add(payment);
  }

  for (var payment in recurringPayments) {
    payment['type'] = 'Recurring'; 
    int day = int.parse(payment['date']);
    payment['timestamp'] = Timestamp.fromDate(DateTime(int.parse(year), DateFormat.MMMM().parse(month).month, day));
    allInfo.add(payment);
  }

  return allInfo;
}

