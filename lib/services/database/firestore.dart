import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test/services/auth/auth_service.dart';

class FireStoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get the current user
  User? user = AuthService().getCurrentUser();

  //-----------------------PAYMENT/RECEIPT-----------------------
  Future<void> updateOrCreateTransaction(double amount, String description,
      DateTime timestamp, List<dynamic> categories) async {
    DocumentReference userDoc = _firestore.collection('users').doc(user?.uid);

    DocumentSnapshot snapshot = await userDoc.get();

    if (snapshot.exists) {
      await userDoc.update({
        'Payments': FieldValue.arrayUnion([
          {
            'amount': amount,
            'description': description,
            'timestamp': timestamp,
            'categories': categories,
          }
        ])
      });
    }
  }

  Future<void> createReceivedPayment(double amount, String description,
      DateTime timestamp, String personneName) async {
    DocumentReference userDoc = _firestore.collection('users').doc(user?.uid);

    DocumentSnapshot snapshot = await userDoc.get();

    if (snapshot.exists) {
      await userDoc.update({
        'Received Payments': FieldValue.arrayUnion([
          {
            'amount': amount,
            'description': description,
            'timestamp': timestamp,
            'personneWhoSentMoney': personneName,
            'type': 'receipt'
          }
        ])
      });
    }
  }

  Future<List<Map<String, dynamic>>> getTransactionsFromDB() async {
    // ignore: no_leading_underscores_for_local_identifiers
    DocumentReference userDoc = _firestore.collection('users').doc(user?.uid);
    try {
      DocumentSnapshot snapshot = await userDoc.get();

      if (snapshot.exists && snapshot.data() != null) {
        var payments = snapshot.get('Payments');
        if (payments is List<dynamic>) {
          return List<Map<String, dynamic>>.from(payments);
        }
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error getting payments: $e");
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> getReceivedPaymentsFromDB() async {
    // ignore: no_leading_underscores_for_local_identifiers
    DocumentReference userDoc = _firestore.collection('users').doc(user?.uid);
    try {
      DocumentSnapshot snapshot = await userDoc.get();

      if (snapshot.exists && snapshot.data() != null) {
        var payments = snapshot.get('Received Payments');
        if (payments is List<dynamic>) {
          return List<Map<String, dynamic>>.from(payments);
        }
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error getting payments: $e");
    }
    return [];
  }

  //---------------------- CATEGORY ----------------------
  Future<void> updateOrCreateCategory(List<String> categories) async {
    // ignore: no_leading_underscores_for_local_identifiers
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    DocumentReference userDoc = _firestore.collection('users').doc(user?.uid);
    try {
      DocumentSnapshot snapshot = await userDoc.get();

      if (snapshot.exists) {
        await userDoc
            .update({'categories': FieldValue.arrayUnion(categories)});
      } else {
        await userDoc.set({'categories': categories});
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error updating categories: $e");
    }
  
  }

  //get Categories
  Future<List<String>> getCategoriesFromDB() async {
    // ignore: no_leading_underscores_for_local_identifiers
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    var user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentReference userDoc = _firestore.collection('users').doc(user.uid);

      try {
        DocumentSnapshot snapshot = await userDoc.get();

        if (snapshot.exists && snapshot.data() != null) {
          var categories = snapshot.get('categories');
          if (categories is List<dynamic>) {
            return categories.cast<String>();
          }
        }
      } catch (e) {
        // ignore: avoid_print
        print("Error getting categories: $e");
      }
    }
    return [];
  }

  Future<bool> removeCategoryFromDb(String category) async {
    // ignore: no_leading_underscores_for_local_identifiers
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    var user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return false;
    }

    DocumentReference userDoc = _firestore.collection('users').doc(user.uid);

    try {
      DocumentSnapshot snapshot = await userDoc.get();

      if (snapshot.exists) {
        await userDoc.update({
          'categories': FieldValue.arrayRemove([category])
        });
        return true; // Success
      } else {
        return false; // User document does not exist
      }
    } catch (e) {
      return false; // Error occurred
    }
  }

  //----------------------Recuring----------------------
  Future<void> updateOrCreateRecurringTransaction(
      List<Map<String, dynamic>> recuringPayments) async {
    DocumentReference userDoc = _firestore.collection('users').doc(user?.uid);

    DocumentSnapshot snapshot = await userDoc.get();

    if (snapshot.exists) {
      await userDoc.update(
          {'recurringTransactions': FieldValue.arrayUnion(recuringPayments)});
    }
    else {
      await userDoc.set({
        'recurringTransactions': 
        recuringPayments,
      });
    }
  }

  Future<List<Map<String, dynamic>>> getRecurringTransactionsFromDB() async {
    List<Map<String, dynamic>> recurringPaymentsList = [];
    // ignore: no_leading_underscores_for_local_identifiers
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentReference userDoc = _firestore.collection('users').doc(user.uid);
      try {
        DocumentSnapshot snapshot = await userDoc.get();
        if (snapshot.exists) {
          var data = snapshot.data() as Map<String, dynamic>;
          if (data.containsKey('recurringTransactions') && data['recurringTransactions'] is List) {
            recurringPaymentsList = List<Map<String, dynamic>>.from(data['recurringTransactions']);
          }
        }
      } catch (e) {
        // ignore: avoid_print
        print("Error getting recurring transactions: $e");
      }
    }
    return recurringPaymentsList;
  }


  Future<bool> removeRecurringTransactionFromDb(
      Map<String, dynamic> recurringTransaction) async {
    // ignore: no_leading_underscores_for_local_identifiers
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return false;
    }

    DocumentReference userDoc = _firestore.collection('users').doc(user.uid);
    try {
      DocumentSnapshot snapshot = await userDoc.get();

      if (snapshot.exists) {
        await userDoc.update({
          'recurringTransactions':
              FieldValue.arrayRemove([recurringTransaction])
        });
        return true; // Success
      }
      return false; // User document does not exist
    } catch (e) {
      return false; // Error occurred
    }
  }

//-------------------------------INFO------------------------------
  Future <void> updateOrCreateInfo(double salary, double maxSpendPerDay,double amountBank) async {
    DocumentReference userDoc = _firestore.collection('users').doc(user?.uid);

    DocumentSnapshot snapshot = await userDoc.get();

    if (snapshot.exists) {
      await userDoc.update({
        'salary': salary,
        'amountBank': amountBank,
        'maxSpendPerDay': maxSpendPerDay
      });
    }
    await userDoc.set({
        'Salary&AmountBank&MaxSpend': {
          'salary': salary, 
          'amountBank': amountBank,
          'maxSpendPerDay': maxSpendPerDay,
        },
      });
  }

  Future<Map<String, double>> getInfoFromDB() async {
  Map<String, double> info = {};
  if (user != null) {
    DocumentReference userDoc = _firestore.collection('users').doc(user?.uid);
    try {
      DocumentSnapshot snapshot = await userDoc.get();
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        if (data.containsKey('Salary&AmountBank&MaxSpend')) {
          Map financialInfo = data['Salary&AmountBank&MaxSpend'];
          double amountBank = financialInfo['amountBank']?.toDouble() ?? 0.0;
          double maxSpendPerDay = financialInfo['maxSpendPerDay']?.toDouble() ?? 0.0;
          double salary = financialInfo['salary']?.toDouble() ?? 0.0;
          info['salary'] = salary;
          info['amountBank'] = amountBank;
          info['maxSpendPerDay'] = maxSpendPerDay;          
    }
    } catch (e) {
      // ignore: avoid_print
      print("Error getting financial info: $e");
    }
  }
  return info;
}


}
