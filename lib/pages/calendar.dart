// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime? _selectedDay;
  // ignore: unused_field
  DateTime? _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar', style: TextStyle(
          color: Colors.white, // Change the color to blue.
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      body: Center(
         child: Padding(
           padding: const EdgeInsets.only(top: 100),
           child : TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
            calendarStyle: const CalendarStyle(
              weekendTextStyle: TextStyle(
                color: Colors.white,
              ),
              outsideTextStyle: TextStyle(
                color: Colors.white,
              ),
              defaultTextStyle: TextStyle(
                color: Colors.white
              ),
              todayDecoration: BoxDecoration(
                color:  Color.fromARGB(255, 23, 134, 86),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Color.fromARGB(255, 23, 134, 86),
                shape: BoxShape.circle,
              ),
              todayTextStyle: TextStyle(
                color: Colors.white,
              ),
              selectedTextStyle: TextStyle(
                color: Colors.white,
              ),
              weekNumberTextStyle: TextStyle(
                color: Colors.white,
              ),
              outsideDaysVisible: false,
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
              // Pour les noms des jours de la semaine
              weekdayStyle: TextStyle(color: Colors.white),
              weekendStyle: TextStyle(color: Colors.white),
            ),
            headerStyle: HeaderStyle(
              formatButtonDecoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20.0),
              ),
              formatButtonTextStyle: const TextStyle(
                color: Colors.white,
              ),
              titleTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.white),
              rightChevronIcon: const Icon(Icons.chevron_right, color: Colors.white),
            ),
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay; // update `_focusedDay` here as well
            });
          },
        )
          

         ) 
      ),
    );
  }
}