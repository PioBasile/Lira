// ignore_for_file: sort_child_properties_last, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:lira/components/detailed_widget.dart';
import 'package:lira/services/calculations/calculations.dart';
import 'package:intl/intl.dart';


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
      _updateDayInfo();
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 20.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: AppBar(
            title: const Text('Calendar', style: TextStyle(color: Colors.white)),
            backgroundColor: const Color.fromARGB(255, 18, 18, 18),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
        ),
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
          double totalPayments = getTotalPayments(day);
          double totalReceived = getTotalReceivedPayments(day);
          double totalRecurring = getTotalRecurringPayments(day);
          double netAmount = totalReceived - (totalPayments + totalRecurring);

          Color textColor;
          if (netAmount > 0) {
            textColor = Colors.teal;
          } else if (netAmount < 0) {
            textColor = Colors.red;
          } else {
            textColor = Colors.grey;
          }

          String displayText = netAmount == 0
              ? "0"
              : "${netAmount > 0 ? '+' : ''}${netAmount.toStringAsFixed(2)}";

          return Container(
            margin: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${day.day}', style: const TextStyle(color: Colors.white)),
                Text(
                  displayText,
                  style: TextStyle(color: textColor, fontSize: 12),
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
          color: const Color.fromARGB(255, 166, 53, 19),
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
    const SizedBox(height: 10),
    _infoRow('Selected Day', '${_selectedDay.day}/${_selectedDay.month}/${_selectedDay.year}'),
    const SizedBox(height: 10),
    Expanded(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: _buildExpansionTile(
              'Total Payments',
              '\$$totalPayments',
              List<Widget>.generate(detailedPayedDay(
                _selectedDay.day,
                _selectedDay.month.toString(),
                _selectedDay.year.toString(),
              ).length, (index) {
                var details = detailedPayedDay(
                  _selectedDay.day,
                  _selectedDay.month.toString(),
                  _selectedDay.year.toString(),
                )[index].values.first;
                return Column(
                  children: [
                    DetailedPaymentRow(
                      amount: details['amount'],
                      time: DateFormat('HH:mm').format(details['timestamp'].toDate()),
                      description: details['description'],
                      category: details['categories'].join(', '),
                    ),
                    if (index < detailedPayedDay(
                      _selectedDay.day,
                      _selectedDay.month.toString(),
                      _selectedDay.year.toString(),
                    ).length - 1)
                      const Divider(
                        color: Colors.white24,
                        thickness: 1,
                        indent: 30,
                        endIndent: 30,
                      ),
                  ],
                );
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: _buildExpansionTile(
              'Total Received Payments',
              '\$$totalReceivedPayments',
              List<Widget>.generate(detailedReceivedDay(
                _selectedDay.day,
                _selectedDay.month.toString(),
                _selectedDay.year.toString(),
              ).length, (index) {
                var details = detailedReceivedDay(
                  _selectedDay.day,
                  _selectedDay.month.toString(),
                  _selectedDay.year.toString(),
                )[index].values.first;
                return Column(
                  children: [
                    DetailedReceivedRow(
                      amount: details['amount'],
                      time: DateFormat('HH:mm').format(details['timestamp'].toDate()),
                      description: details['description'],
                      fromWhom: details['personneWhoSentMoney'],
                    ),
                    if (index < detailedReceivedDay(
                      _selectedDay.day,
                      _selectedDay.month.toString(),
                      _selectedDay.year.toString(),
                    ).length - 1)
                      const Divider(
                        color: Colors.white24,
                        thickness: 1,
                        indent: 30,
                        endIndent: 30,
                      ),
                  ],
                );
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: _buildExpansionTile(
              'Total Recurring Payments',
              '\$$totalRecurringPayments',
              List<Widget>.generate(detailedRecurringDay(
                _selectedDay.day,
              ).length, (index) {
                var details = detailedRecurringDay(
                  _selectedDay.day,
                )[index].values.first;
                return Column(
                  children: [
                    DetailedPaymentRow(
                      amount: details['amount'],
                      time: 'Every ${_selectedDay.day.toString()}',
                      description: details['description'],
                      category: '',
                    ),
                    if (index < detailedRecurringDay(
                      _selectedDay.day,
                    ).length - 1)
                      const Divider(
                        color: Colors.white24,
                        thickness: 1,
                        indent: 30,
                        endIndent: 30,
                      ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    ),
  ],
),
);

  }

  List<Map<int, dynamic>> detailedPayedDay(int day, String month, String year) {
    return getDetailedPayedPerDay(day, month, year);
  }

  List<Map<int, dynamic>> detailedReceivedDay(int day, String month, String year) {
    return getDetailedReceivedPerDay(day, month, year);
  }

  List<Map<int, dynamic>> detailedRecurringDay(int day) {
    return getDetailedRecurringPerDay(day);
  }

  double getTotalPayments(DateTime date) {
    List<double> payments = [];
    double total = 0;
    String day = date.day.toString();
    String month = date.month.toString();
    String year = date.year.toString();

    payments = getPaymentsInADay(day, month, year);
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

  Widget _buildExpansionTile(String title, String value, List<Widget> children) {
    return ExpansionTile(
      title: _infoRow(title, value),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 20), // Ensure the padding is consistent
      children: children.map((child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20), // Add padding to each child
          child: child,
        );
      }).toList(),
      tilePadding: EdgeInsets.zero, // Remove default padding
    );
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

  // ignore: unused_element
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
