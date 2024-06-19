import 'package:flutter/material.dart';

class DetailedPaymentRow extends StatelessWidget {
  final double amount;
  final String time;
  final String description;
  final String category;

  const DetailedPaymentRow({
    super.key,
    required this.amount,
    required this.time,
    required this.description,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$$amount',
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                time,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 4), // Add space between rows
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                description,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Text(
                category,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DetailedReceivedRow extends StatelessWidget {
  final double amount;
  final String time;
  final String description;
  final String fromWhom;

  const DetailedReceivedRow({
    super.key,
    required this.amount,
    required this.time,
    required this.description,
    required this.fromWhom,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$$amount',
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                time,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 4), // Add space between rows
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                description,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Text(
                fromWhom,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
