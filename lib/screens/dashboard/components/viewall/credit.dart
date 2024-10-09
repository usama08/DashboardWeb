import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../Firebase/db_connection.dart';
import '../widgets/payslip.dart';

class CreditScreen extends StatefulWidget {
  @override
  _CreditScreenState createState() => _CreditScreenState();
}

class _CreditScreenState extends State<CreditScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  Future<List<Map<String, dynamic>>>? creditDetails;
  String? selectedUser;
  String? selectedUserId;
  double? currentCreditAmount = 0.0;
  double? depositAmount = 0.0;

  @override
  void initState() {
    super.initState();
    // Fetch credit details when the screen is initialized
    creditDetails = _firestoreService.getAllCreditDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Balance'),
        actions: [
          TextButton.icon(
            onPressed: () {
              _showAddDepositForm(context);
            },
            icon: Icon(Icons.add, color: Colors.white),
            label: Text('Add Deposit', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: creditDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No credit details found.'));
          }

          final credits = snapshot.data!;
          return ListView.builder(
            itemCount: credits.length,
            itemBuilder: (context, index) {
              final credit = credits[index];
              final name = credit['creditName'] ?? 'Unknown';
              final amount = credit['creditAmount']?.toString() ?? 'N/A';

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransactionSlip(
                        name: name,
                        amount: amount,
                        date: 'Date info here',
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color.fromARGB(255, 6, 35, 84),
                        const Color.fromARGB(255, 49, 77, 90)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      color: Colors.white,
                      size: 40.0,
                    ),
                    title: Text(
                      name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Amount: $amount',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Add Deposit Form
  void _showAddDepositForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Deposit'),
          content: FutureBuilder<List<Map<String, dynamic>>>(
            future: creditDetails,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text('No credit details found.');
              }

              final credits = snapshot.data!;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Dropdown to select user
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Select User'),
                    items: credits.map((credit) {
                      return DropdownMenuItem<String>(
                        value: credit['creditName'],
                        child: Text(credit['creditName']),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedUser = value;

                        // Find the selected user's data and update the current credit amount
                        final selectedCredit = credits.firstWhere(
                          (credit) => credit['creditName'] == value,
                        );
                        selectedUserId =
                            selectedCredit['userId']; // Firestore document ID
                        currentCreditAmount = double.tryParse(
                                selectedCredit['creditAmount'].toString()) ??
                            0.0;

                        // Debugging: Print the selected user and current credit amount
                        print('Selected user: $selectedUser');
                        print('User ID: $selectedUserId');
                        print('Current credit amount: $currentCreditAmount');
                      });
                    },
                  ),

                  // Deposit Amount Input
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Deposit Amount',
                      hintText: 'Enter deposit',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        depositAmount = double.tryParse(value);

                        // Debugging: Print the deposit amount
                        print('Deposit amount: $depositAmount');
                      });
                    },
                  ),

                  // Show updated balance
                  Text(
                      "Balance: ${currentCreditAmount != null && depositAmount != null ? (currentCreditAmount! + depositAmount!).toString() : currentCreditAmount.toString()}"),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                _submitDeposit();
              },
              child: Text('Submit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Submit Deposit and update Firestore
  Future<void> _submitDeposit() async {
    // Check that both selectedUserId and depositAmount are not null
    if (selectedUserId != null && depositAmount != null) {
      try {
        String uid = FirebaseAuth.instance.currentUser!.uid;
        CollectionReference amountCollection = FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('creditUserList');

        // Calculate new credit amount
        double newCreditAmount = currentCreditAmount! + depositAmount!;
        print("newcreidtamount$newCreditAmount");

        // Update the existing document with the new credit amount
        await amountCollection.doc(selectedUserId).update({
          'creditAmount': newCreditAmount,
        });

        Navigator.of(context).pop(); // Close the dialog

        setState(() {
          creditDetails =
              _firestoreService.getAllCreditDetails(); // Refresh credit details
        });
      } catch (e) {
        print('Error updating credit amount: $e');
      }
    } else {
      print('User or deposit amount is not selected');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select a user and enter a deposit amount.'),
      ));
    }
  }
}
