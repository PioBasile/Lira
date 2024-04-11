import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Graph extends StatelessWidget {
  Graph({super.key});

  //can put a list of items for the piechart, and so i can
  //create a list for each day and replace it in the piechart

  final List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.pink,
    Colors.purple,
    Colors.orange,
    Colors.cyan,
    Colors.teal,
    Colors.lime,
    Colors.indigo,
    Colors.amber,
    Colors.brown,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
        appBar: AppBar(
          title: const Text('Graph', style: TextStyle(
            color: Colors.white,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 18, 18, 18),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Center(
          child: PieChart(
            animationDuration: const Duration(milliseconds: 800),
            chartLegendSpacing: 32,
            colorList: colorList,
            initialAngleInDegree: 0,
            chartType: ChartType.disc,
            ringStrokeWidth: 32,
            centerText: "HYBRID",
            dataMap: const {
              'Food': 5,
              'Transport': 3,
              'Entertainment': 2,
              'Other': 1,
            },
            legendOptions: const LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.right,
              showLegends: true,
              legendTextStyle: TextStyle(
                color: Colors.white,
              ),
            ),
            chartValuesOptions: const ChartValuesOptions(
              showChartValueBackground: true,
              showChartValues: true,
              showChartValuesInPercentage: false,
              showChartValuesOutside: false,
              decimalPlaces: 1,
            ),
          ),
        )
    );
  }
}
