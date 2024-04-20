import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
// ignore: depend_on_referenced_packages
import 'package:test/services/calculations/calculations.dart'; // Make sure you have this for date formatting

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  late double totalPayments;
  late double totalReceivedPayments;
  late double totalRecurringPayments;


  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    _selectedDay = DateTime(now.year, now.month, now.day);
    _focusedDay = DateTime(now.year, now.month, now.day);
    _updateDayInfo();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      // Optionally update other state variables or perform network requests here
    });
  }


  void _updateDayInfo() {
    setState(() {
      totalPayments = getTotalPayments(_selectedDay);
      totalReceivedPayments = getTotalReceivedPayments(_selectedDay);
      totalRecurringPayments = getTotalRecurringPayments(_selectedDay);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: CalendarFormat.month,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: _onDaySelected,
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                const amountSpent = /*dailySpending[day] ??*/ 0.0;
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${day.day}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      const Text(
                        '\$$amountSpent',
                        style: TextStyle(color: Colors.tealAccent, fontSize: 12),
                      ),
                    ],
                  ),
                );
              },
            ),
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              defaultDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(4),
              ),
              todayDecoration: BoxDecoration(
                color: Colors.green[700],
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8),
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
              leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
              rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
            ),
          ),
          const SizedBox(height: 50),
          Expanded(
            child : Column(
              children: [
                _infoRow('Selected Day', '${_selectedDay.day}/${_selectedDay.month}/${_selectedDay.year}'),
                _infoDivider(),
                _infoRow('Total Payments', '\$$totalPayments'),
                _infoDivider(),
                _infoRow('Total Received Payments', '\$$totalReceivedPayments'),
                _infoDivider(),
                _infoRow('Total Recurring Payments', '\$$totalRecurringPayments'),
              ],
            ),
          ),
        ],
      ),
    );
  }


  double getTotalPayments(DateTime date) {
    List<double> payments = [];
    double total = 0;
    payments = getPaymentsInADay(
        date.day.toString(), date.month.toString(), date.year.toString());
    for (var payment in payments) {
      total += payment;
    }
    return total;
  }

  double getTotalReceivedPayments(DateTime date) {
    List<double> receivedPayments = [];
    double total = 0;
    receivedPayments = getReceivedPaymentsInADay(
        date.day.toString(), date.month.toString(), date.year.toString());
    for (var payment in receivedPayments) {
      total += payment;
    }
    return total;
  }

  double getTotalRecurringPayments(DateTime date) {
    List<double> recurringPayments = [];
    double total = 0;
    recurringPayments = getRecurringPaymentsInADay(date.day.toString());
    for (var payment in recurringPayments) {
      total += payment;
    }
    return total;
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    child: const Divider(
      height: 1, 
      thickness: 0.5, 
      color: Colors.white24, 
    ),
  );
}

}

