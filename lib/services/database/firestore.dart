import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test/services/auth/auth_service.dart';

class FireStoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get the current user
  User? user = AuthService().getCurrentUser();

  // Method to update or create a user's transaction
  Future<void> updateOrCreateTransaction(double amount, String description, DateTime timestamp, List<String> categories) async {
    // Get a reference to the user's document in a 'users' collection
    DocumentReference userDoc = _firestore.collection('users').doc(user?.uid);

    // Try to get the user document
    DocumentSnapshot snapshot = await userDoc.get();

    // Check if the document exists
    if (snapshot.exists) {
      // Document exists, update the current amount
      await userDoc.update({
        'transactions': FieldValue.arrayUnion([{
          'amount': amount, 
          'description': description,
          'timestamp': timestamp,
          'categories': categories,
          'type': 'payment' 
        }])
      });
    }
  }

  Future<void> createReceivedPayment(double amount, String description, DateTime timestamp, String personneName ) async {
    // Get a reference to the user's document in a 'users' collection
    DocumentReference userDoc = _firestore.collection('users').doc(user?.uid);

    // Try to get the user document
    DocumentSnapshot snapshot = await userDoc.get();

    // Check if the document exists
    if (snapshot.exists) {
      // Document exists, update the current amount
      await userDoc.update({
        'transactions': FieldValue.arrayUnion([{
          'amount': amount, 
          'description': description,
          'timestamp': timestamp,
          'personneWhoSentMoney' : personneName,
          'type': 'receipt'
  
        }])
      });
    }
  }
}
