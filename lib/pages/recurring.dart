import 'package:flutter/material.dart';
import 'package:test/services/database/firestore.dart';

class RecurringPaymentsPage extends StatefulWidget {
  const RecurringPaymentsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RecurringPaymentsPageState createState() => _RecurringPaymentsPageState();
}

class _RecurringPaymentsPageState extends State<RecurringPaymentsPage> {
  List<Map<String, dynamic>> _recurringPayments = [];

  @override
  void initState() {
    super.initState();
    _loadPayments();
  }

  void _loadPayments() async {
    List<Map<String, dynamic>> paymentsFromDb = await FireStoreService().getRecurringTransactionsFromDB();
    setState(() {
      _recurringPayments = paymentsFromDb;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _recurringPayments.isEmpty
            ? const Center(
                child: Text(
                  'No recurring payments yet.',
                  style: TextStyle(color: Colors.white60, fontSize: 16),
                ),
              )
            : ListView.builder(
                itemCount: _recurringPayments.length,
                itemBuilder: (context, index) {
                  return _paymentRow(_recurringPayments[index], index);
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddPaymentDialog,
        // ignore: sort_child_properties_last
        child: const Icon(Icons.add),
        backgroundColor: Colors.redAccent, // Bordeaux red as FAB color
      ),
    );
  }

  Widget _paymentRow(Map<String, dynamic> payment, int index) {
    return ListTile(
      tileColor: const Color.fromARGB(255, 45, 45, 48),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: const Icon(Icons.repeat, color: Colors.green), 
      title: Text('\$${payment['amount']} - ${payment['description']}', 
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      subtitle: Text('Due on: ${payment['date']}', 
              style: const TextStyle(color: Colors.white70)),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () => _removeRecurringPayment(index),
      ),
    );
  }

  void _showAddPaymentDialog() {
    TextEditingController amountController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController dateController = TextEditingController();

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
                decoration: const InputDecoration(hintText: "Enter amount (e.g., 123.45)"),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(hintText: "Enter description (e.g., Rent...)"),
              ),
              TextField(
                controller: dateController,
                decoration: const InputDecoration(hintText: "Enter date (e.g., 3 = 3rd of each month)"),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (amountController.text.isNotEmpty && descriptionController.text.isNotEmpty && dateController.text.isNotEmpty) {
                  _addPayment(
                    double.parse(amountController.text),
                    descriptionController.text,
                    dateController.text
                  );
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _addPayment(double amount, String description, String date) {
    setState(() {
      _recurringPayments.add({'amount': amount, 'description': description, 'date': date});
    });
    FireStoreService().updateOrCreateRecurringTransaction(_recurringPayments);
  }

  void _removeRecurringPayment(int index) {
    setState(() {
      _recurringPayments.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Recurring payment removed successfully."),
      backgroundColor: Colors.green,
    ));
  }
}
