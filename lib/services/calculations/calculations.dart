import 'package:test/services/database/firestore.dart';


List<Map<String, dynamic>> payments = [];
List<Map<String, dynamic>> receivedPayments = [];
List<Map<String, dynamic>> recurringPayments = [];
Map<String, double> info = {};
//get all the variables from the database
void loadAllData() async {
  payments = await FireStoreService().getTransactionsFromDB();
  receivedPayments = await FireStoreService().getReceivedPaymentsFromDB();
  recurringPayments = await FireStoreService().getRecurringTransactionsFromDB();
  info = await FireStoreService().getInfoFromDB();
}

List<Map<String, dynamic>> getPayments() {
  return payments;
}

List<Map<String, dynamic>> getReceivedPayments() {
  return receivedPayments;
}

List<Map<String, dynamic>> getRecurringPayments() {
  return recurringPayments;
}

Map<String, double> getInfo() {
  return info;
}


// Calculate the end of the month amount
double calculateEOFM(List<double> payments, double salary,double received, double amountBank,List<double> recurringPayments) {
  double maxPayments = 0;

  for (int i = 0; i < payments.length; i++) {
    maxPayments = payments[i] + maxPayments;
  }

  for (int i = 0; i < recurringPayments.length; i++) {
    maxPayments = recurringPayments[i] + maxPayments;
  }

  double maxAmountUHave = salary + amountBank + received;

  double amountEndOfMounth = maxAmountUHave - maxPayments;

  return amountEndOfMounth;
}
