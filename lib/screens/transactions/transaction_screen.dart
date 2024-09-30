import 'package:flutter/material.dart';

import '../../constants.dart';

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final List<Map<String, String>> transactions = [
    {'name': 'Transaction 1', 'amount': '\$100', 'date': '2024-09-30'},
    {'name': 'Transaction 2', 'amount': '\$200', 'date': '2024-09-28'},
    {'name': 'Transaction 3', 'amount': '\$50', 'date': '2024-09-27'},
    {'name': 'Transaction 4', 'amount': '\$300', 'date': '2024-09-25'},
  ];

  Map<String, String>? selectedTransaction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Transactions'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // Tablet / Larger Screen Layout
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TransactionList(
                      transactions: transactions,
                      onTap: (transaction) {
                        setState(() {
                          selectedTransaction = transaction;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: bgColor,
                      child: selectedTransaction == null
                          ? Center(
                              child:
                                  Text('Select a transaction to view details'),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: TransactionDetail(
                                  transaction: selectedTransaction!),
                            ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            // Mobile Layout - Just the list
            return TransactionList(
              transactions: transactions,
              onTap: (transaction) {
                // Navigate to a details page for mobile screens
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TransactionDetailScreen(transaction: transaction),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class TransactionList extends StatelessWidget {
  final List<Map<String, String>> transactions;
  final Function(Map<String, String>) onTap;

  const TransactionList({required this.transactions, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return Card(
          margin: EdgeInsets.all(10.0),
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.monetization_on),
            ),
            title: Text(transaction['name']!),
            subtitle: Text(transaction['date']!),
            trailing: Text(transaction['amount']!),
            onTap: () => onTap(transaction),
          ),
        );
      },
    );
  }
}

class TransactionDetail extends StatelessWidget {
  final Map<String, String> transaction;

  const TransactionDetail({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Transaction Name: ${transaction['name']}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text('Amount: ${transaction['amount']}'),
        SizedBox(height: 10),
        Text('Date: ${transaction['date']}'),
      ],
    );
  }
}

class TransactionDetailScreen extends StatelessWidget {
  final Map<String, String> transaction;

  const TransactionDetailScreen({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TransactionDetail(transaction: transaction),
      ),
    );
  }
}
