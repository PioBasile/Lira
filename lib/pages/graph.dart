// ignore_for_file: library_private_types_in_public_api

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:lira/services/calculations/calculations.dart';


class Graph extends StatefulWidget {
  const Graph({super.key});

  @override
  _GraphState createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  DateTime selectedDate = DateTime.now();
  

  Color getRandomColor() {
    Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );
  }

  List<Color> getColorList(Map<String, double> dataMap) {
    List<Color> colorList = [];
    dataMap.forEach((category, _) {
      if (category == 'not specified') {
        colorList.add(Colors.grey); // Gray for "not specified"
      } else {
        colorList.add(getRandomColor());
      }
    });
    return colorList;
  }

  Map<String, double> getDataMap() {
    String month = DateFormat('MMMM').format(selectedDate);
    int year = selectedDate.year;
    List<Map<String, dynamic>> payments = getPaymentsForMonth(month, year.toString());
    Map<String, double> dataMap = {};
    for (var payment in payments) {
      List category = payment['categories'];
      double amount = payment['amount'];
      for(var cate in category){
        // ignore: unnecessary_null_comparison
        if (cate != null && amount != null) {
          dataMap[cate] = (dataMap[cate] ?? 0) + amount; 
        }
      }
    }
    return dataMap;
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

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = getDataMap();
    List<Color> colorList = getColorList(dataMap);
    // Check if dataMap is empty and handle the "No data" case
    if (dataMap.isEmpty) {
      dataMap = {'No data': 0}; 
      colorList = [Colors.grey]; 
    }
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 20.0), 
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0), 
          child: AppBar(
            title: const Text('Graph', style: TextStyle(color: Colors.white)),
            backgroundColor: const Color.fromARGB(255, 18, 18, 18),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30), // Add some space between month selector and title
          const Text(
            'Category Distribution',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
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
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: PieChart(
                      animationDuration: const Duration(milliseconds: 800),
                      chartLegendSpacing: 32,
                      colorList: colorList,
                      initialAngleInDegree: 0,
                      chartType: ChartType.disc,
                      ringStrokeWidth: 32,
                      centerText: "",
                      dataMap: dataMap,
                      legendOptions: const LegendOptions(
                        showLegendsInRow: true,
                        legendPosition: LegendPosition.bottom,
                        showLegends: true,
                        legendTextStyle: TextStyle(
                          color: Colors.white,
                        ),
                        legendShape: BoxShape.rectangle,
                      ),
                      chartValuesOptions: const ChartValuesOptions(
                        showChartValueBackground: true,
                        showChartValues: true,
                        showChartValuesInPercentage: false,
                        showChartValuesOutside: false,
                        decimalPlaces: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


