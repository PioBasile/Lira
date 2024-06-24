import 'package:flutter/material.dart';

class HistoryTransactionRow extends StatelessWidget {
  final String type; // "Payment", "Received", or "Recurring"
  final double amount;
  final String time;
  final String description;
  final String detail; // category for payments and recurring, fromWhom for received

  const HistoryTransactionRow({
    super.key,
    required this.type,
    required this.amount,
    required this.time,
    required this.description,
    required this.detail,
  });

  Color _getTypeColor() {
    switch (type) {
      case 'Payment':
        return Colors.redAccent;
      case 'Received':
        return Colors.greenAccent;
      case 'Recurring':
        return Colors.blueAccent;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 28, 28, 28),
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              type,
              style: TextStyle(color: _getTypeColor(), fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8), // Space between type and details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$$amount',
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  time,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8), // Space between rows
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    description,
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ),
                const SizedBox(width: 20), // Space between description and detail
                Text(
                  detail,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
