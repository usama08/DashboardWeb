import 'package:flutter/material.dart';

class TransactionSlip extends StatelessWidget {
  final String name;
  final String amount;
  final String date;

  TransactionSlip(
      {required this.name, required this.amount, required this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Slip'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centers content vertically
          crossAxisAlignment:
              CrossAxisAlignment.center, // Centers content horizontally
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    'Transaction Amount',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Name: $name',
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 211, 209, 209),
                    ),
                  ),
                  Text(
                    'Amount: $amount',
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 211, 209, 209),
                    ),
                  ),
                  Text(
                    'Date: $date',
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 211, 209, 209),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Transaction Details',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            // Add any other detailed information or additional sections here
          ],
        ),
      ),
    );
  }
}
