import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test/services/auth/auth_service.dart';

class FireStoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get the current user
  User? user = AuthService().getCurrentUser();

  //-----------------------PAYMENT/RECEIPT-----------------------
  Future<void> updateOrCreateTransaction(double amount, String description,
      DateTime timestamp, List<String> categories) async {
    DocumentReference userDoc = _firestore.collection('users').doc(user?.uid);

    DocumentSnapshot snapshot = await userDoc.get();

    if (snapshot.exists) {
      await userDoc.update({
        'transactions': FieldValue.arrayUnion([
          {
            'amount': amount,
            'description': description,
            'timestamp': timestamp,
            'categories': categories,
            'type': 'payment'
          }
        ])
      });
    }
  }

  Future<void> createReceivedPayment(double amount, String description, DateTime timestamp, String personneName) async {
    DocumentReference userDoc = _firestore.collection('users').doc(user?.uid);

    DocumentSnapshot snapshot = await userDoc.get();

    if (snapshot.exists) {
      await userDoc.update({
        'transactions': FieldValue.arrayUnion([
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
  
  //---------------------- CATEGORY ----------------------
  Future<void> updateOrCreateCategory(List<String> categories) async {
    // ignore: no_leading_underscores_for_local_identifiers
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    var user = FirebaseAuth.instance.currentUser; // Ensuring you have a user instance

    if (user != null) {
      DocumentReference userDoc = _firestore.collection('users').doc(user.uid);

      try {
        DocumentSnapshot snapshot = await userDoc.get();

        if (snapshot.exists) {
          await userDoc
              .update({'categories': FieldValue.arrayUnion(categories)});
        } else {
          // If the document doesn't exist, create it with the categories
          await userDoc.set({'categories': categories});
        }
      } catch (e) {
        // ignore: avoid_print
        print("Error updating categories: $e");
      }
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
  Future<void> updateOrCreateRecurringTransaction(List<Map<String, dynamic>> transactions) async {
    DocumentReference userDoc = _firestore.collection('users').doc(user?.uid);

    DocumentSnapshot snapshot = await userDoc.get();

    if (snapshot.exists) {
      await userDoc.update({
        'recurringTransactions': FieldValue.arrayUnion(transactions)
      });
    }
  }

  Future<List<Map<String, dynamic>>> getRecurringTransactionsFromDB() async {
    // ignore: no_leading_underscores_for_local_identifiers
    DocumentReference userDoc = _firestore.collection('users').doc(user?.uid);
    try {
      DocumentSnapshot snapshot = await userDoc.get();

      if (snapshot.exists && snapshot.data() != null) {
        var recurringTransactions = snapshot.get('recurringTransactions');
        if (recurringTransactions is List<dynamic>) {
          return List<Map<String, dynamic>>.from(recurringTransactions);
        }
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error getting recurring transactions: $e");
    }
    return [];
  }

  Future<bool> removeRecurringTransactionFromDb(Map<String, dynamic> recurringTransaction) async {
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
        'recurringTransactions': FieldValue.arrayRemove([recurringTransaction])
      });
      return true; // Success
    }
    return false; // User document does not exist
  } catch (e) {
    return false; // Error occurred
  }
}

}
