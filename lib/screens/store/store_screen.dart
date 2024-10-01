import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  // Sample data for stores and their associated names
  final List<Map<String, dynamic>> stores = [
    {
      'storeName': 'Mubeeen',
      'associatedNames': ['Credit 200', 'Deposit 1000']
    },
    {
      'storeName': 'Hamza Store',
      'associatedNames': ['Ali', 'Amjad']
    },
    {
      'storeName': 'Zayan Store',
      'associatedNames': ['Shahzaib', 'Talha', 'Afzal', 'Manan']
    },
    {
      'storeName': 'Ali Store',
      'associatedNames': ['Payment Credit', 'Payment Deposit']
    },
    {
      'storeName': 'Raheem Store',
      'associatedNames': ['Store 1', 'Store 2', 'Store 3', 'Store 4']
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stores'),
      ),
      body: ListView.builder(
        itemCount: stores.length,
        itemBuilder: (context, index) {
          final store = stores[index];
          return Card(
            margin: EdgeInsets.all(10.0),
            child: ExpansionTile(
              title: Text(
                store['storeName'],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Associated Names:',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      // Display associated names dynamically
                      ...store['associatedNames']
                          .map<Widget>((name) => Text(name))
                          .toList(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
