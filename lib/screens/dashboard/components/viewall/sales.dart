import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../Firebase/db_connection.dart';

class SalesScreen extends StatefulWidget {
  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  Future<List<Map<String, dynamic>>>? salesDetails;

  @override
  void initState() {
    super.initState();
    // Fetch credit details when the screen is initialized
    salesDetails = _firestoreService.getAllSalesDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Credit Dashboard'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: salesDetails,
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

          // If data is available, display it
          final sales = snapshot.data!;

          return ListView.builder(
            itemCount: sales.length,
            itemBuilder: (context, index) {
              final mysales = sales[index];

              // Extract the fields
              final amount = mysales['amount'] ?? 'Unknown';
              final month = mysales['month'] ?? 'N/A';

              // Handling the Timestamp conversion
              final timestamp = mysales['date'] as Timestamp?;
              final date = timestamp != null
                  ? DateFormat('dd/MM/yyyy').format(timestamp.toDate())
                  : 'Unknown Date';

              return Card(
                margin: EdgeInsets.all(10.0),
                child: ListTile(
                  title: Text('month: $month'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Amount: $amount'),
                      Text('Date: $date'), // Formatted date
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
