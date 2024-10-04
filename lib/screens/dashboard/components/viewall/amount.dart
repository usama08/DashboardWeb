import 'package:flutter/material.dart';
import '../../../../Firebase/db_connection.dart';

class AmountCollection extends StatefulWidget {
  @override
  _AmountCollectionState createState() => _AmountCollectionState();
}

class _AmountCollectionState extends State<AmountCollection> {
  final FirestoreService _firestoreService = FirestoreService();

  Future<List<Map<String, dynamic>>>? amountDetails;

  @override
  void initState() {
    super.initState();
    // Fetch sellers details when the screen is initialized
    amountDetails = _firestoreService.getAllAmountDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: amountDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No sellers found.'));
          }

          // If data is available, display it
          final amount = snapshot.data!;

          return ListView.builder(
            itemCount: amount.length,
            itemBuilder: (context, index) {
              final amountcollection = amount[index];
              return ListTile(
                title: Text(amountcollection['name'] ?? 'No Name'),
                subtitle: Text(amountcollection['email'] ?? 'No Email'),
              );
            },
          );
        },
      ),
    );
  }
}
