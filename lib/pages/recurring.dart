import 'package:flutter/material.dart';
import 'package:test/services/database/firestore.dart';

class RecurringPaymentsPage extends StatefulWidget {
  const RecurringPaymentsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RecurringPaymentsPageState createState() => _RecurringPaymentsPageState();
}

class _RecurringPaymentsPageState extends State<RecurringPaymentsPage> {
  // ignore: prefer_final_fields
  List<Map<String, dynamic>> _recurringPayments = [];

  @override
  void initState() {
    super.initState();
    _loadPayments();
    _savePayments();
  }

  void _loadPayments() async {
  List<Map<String, dynamic>> paymentsFromDb = await loadPaymentDb();
  setState(() {
    _recurringPayments = paymentsFromDb;
  });
}


  void _savePayments() {
    _saveRecurringPayments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      body: _recurringPayments.isEmpty
          ? const Center(
              child: Text('No recurring payments yet.',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            )
          : ListView.builder(
              itemCount: _recurringPayments.length,
              itemBuilder: (context, index) {
                return _paymentRow(_recurringPayments[index], index);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddPaymentDialog,
        // ignore: sort_child_properties_last
        child: const Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
    );
  }

  Widget _paymentRow(Map<String, dynamic> payment, int index) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 76, 75, 75),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$${payment['amount']}',
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
                Text(
                  payment['description'],
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  'Date: ${payment['date']}',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _removeRecurringPayment(index),
            icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
          ),
        ],
      ),
    );
  }

  void _showAddPaymentDialog() {
    TextEditingController dateController = TextEditingController();
    TextEditingController amountController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Recurring Payment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: amountController,
                decoration: const InputDecoration(
                    hintText: "Enter amount (e.g., 123.45)"),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                    hintText: "Enter description (e.g., Rent...)"),
              ),
              TextField(
                controller: dateController,
                decoration: const InputDecoration(
                    hintText: "Enter date (e.g, 3 = 3 of each month)"),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (dateController.text.isNotEmpty &&
                    amountController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty) {
                  _savePayments();
                  _addPayment(
                      double.parse(amountController.text),
                      descriptionController.text,
                      int.parse(dateController.text));
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _addPayment(double amount, String description, int date) {
    setState(() {
      _recurringPayments.add({
        'amount': amount,
        'description': description,
        'date': date,
      });
    });
  }

  Future<List<Map<String, dynamic>>> loadPaymentDb() async {
    return await FireStoreService().getRecurringTransactionsFromDB();  
  }

  void _saveRecurringPayments() async {
    await FireStoreService()
        .updateOrCreateRecurringTransaction(_recurringPayments);
  }

  void _removeRecurringPayment(int index) {
    setState(() {
      _recurringPayments.removeAt(index);
    });

    Map<String, dynamic> recurringToRemove = _recurringPayments[index];

    FireStoreService fireStoreService = FireStoreService();
    fireStoreService
        .removeRecurringTransactionFromDb(recurringToRemove)
        .then((success) {
      String message = success
          ? "Recurring payment removed successfully."
          : "Failed to remove recurring payment.";
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : Colors.red,
      ));
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error removing recurring payment: $e"),
        backgroundColor: Colors.red,
      ));
    });
  }
}
