import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch all documents from the 'user' -> 'allseller' subcollection for the current user
  Future<List<Map<String, dynamic>>> getAllSellersDetails() async {
    print('Fetching sellers details...');
    try {
      String uid =
          FirebaseAuth.instance.currentUser!.uid; // Get current user ID

      // Reference to the 'user' -> 'uid' -> 'allseller' subcollection
      CollectionReference sellersCollection = _db
          .collection('user') // Root collection
          .doc(uid) // User-specific document ID
          .collection('allseller'); // Subcollection

      // Fetch all documents from 'allseller'
      QuerySnapshot snapshot = await sellersCollection.get();

      // If the collection is empty, create the collection (subcollection is created when a document is added)
      if (snapshot.docs.isEmpty) {
        await sellersCollection.add({
          'defaultField': 'defaultValue',
        });
        print('No sellers found, created default seller entry.');
      }

      // Map the fetched documents to a list of maps
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching sellers details: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getAllAmountDetails() async {
    print('Fetching amount details...');
    try {
      String uid =
          FirebaseAuth.instance.currentUser!.uid; // Get current user ID

      // Reference to the 'user' -> 'uid' -> 'collection' subcollection
      CollectionReference amountCollection = _db
          .collection('user') // Root collection
          .doc(uid) // User-specific document ID
          .collection('collection'); // Subcollection

      // Fetch all documents from 'collection'
      QuerySnapshot snapshot = await amountCollection.get();

      // If the collection is empty, create the collection (subcollection is created when a document is added)
      if (snapshot.docs.isEmpty) {
        await amountCollection.add({
          'defaultField': 'defaultValue',
        });
        print('No amount details found, created default entry.');
      }

      // Map the fetched documents to a list of maps
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching amount details: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getAllCreditDetails() async {
    print('Fetching all users from Firestore...');

    try {
      String uid =
          FirebaseAuth.instance.currentUser!.uid; // Get current user ID

      // Reference to the 'user' -> 'uid' -> 'collection' subcollection
      CollectionReference amountCollection = _db
          .collection('users') // Root collection
          .doc(uid) // User-specific document ID
          .collection('creditUserList'); // Subcollection

      // Fetch all documents from 'collection'
      QuerySnapshot snapshot = await amountCollection.get();

      // If the collection is empty, create the collection (subcollection is created when a document is added)
      if (snapshot.docs.isEmpty) {
        await amountCollection.add({
          'defaultField': 'defaultValue',
        });
        print('No amount details found, created default entry.');
      }

      // Map the fetched documents to a list of maps
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching credit details: $e');
      return [];
    }
  }

  // Update credit details of the current user
  Future<void> updateCreditDetails(
      String creditId, Map<String, dynamic> updatedData) async {
    print('Updating credit details...');
    try {
      String uid =
          FirebaseAuth.instance.currentUser!.uid; // Get current user ID

      // Reference to the 'user' -> 'uid' -> 'creditUserList' subcollection
      DocumentReference creditRef = _db
          .collection('users') // Root collection
          .doc(uid) // User-specific document ID
          .collection('creditUserList') // Subcollection
          .doc(creditId); // Document ID

      // Update the credit details in Firestore
      await creditRef.update(updatedData);
      print('Credit details updated successfully.');
    } catch (e) {
      print('Error updating credit details: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllSalesDetails() async {
    print('Fetching sales details...');
    try {
      String uid =
          FirebaseAuth.instance.currentUser!.uid; // Get current user ID

      // Reference to the 'user' -> 'uid' -> 'sales' subcollection
      CollectionReference salesCollection = _db
          .collection('user') // Root collection
          .doc(uid) // User-specific document ID
          .collection('sales'); // Subcollection

      // Fetch all documents from 'sales'
      QuerySnapshot snapshot = await salesCollection.get();

      // If the collection is empty, create the collection (subcollection is created when a document is added)
      if (snapshot.docs.isEmpty) {
        await salesCollection.add({
          'defaultField': 'defaultValue',
        });
        print('No sales details found, created default entry.');
      }

      // Map the fetched documents to a list of maps
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching sales details: $e');
      return [];
    }
  }
}
