import 'package:flutter/material.dart';
import '../../../../Firebase/db_connection.dart';

class SellerScreen extends StatefulWidget {
  @override
  _SellerScreenState createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  Future<List<Map<String, dynamic>>>? sellersDetails;

  @override
  void initState() {
    super.initState();
    // Fetch sellers details when the screen is initialized
    sellersDetails = _firestoreService.getAllSellersDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: sellersDetails,
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
          final sellers = snapshot.data!;

          return ListView.builder(
            itemCount: sellers.length,
            itemBuilder: (context, index) {
              final seller = sellers[index];
              return ListTile(
                title: Text(seller['name'] ?? 'No Name'),
                subtitle: Text(seller['email'] ?? 'No Email'),
              );
            },
          );
        },
      ),
    );
  }
}
