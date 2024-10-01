import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  // Sample data for notifications
  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'Payment Received',
      'message': 'Your payment of \$200 has been credited to your account.',
      'time': '2 hours ago',
      'icon': Icons.payment
    },
    {
      'title': 'Deposit Confirmation',
      'message': 'Your deposit of \$1000 has been successfully processed.',
      'time': '5 hours ago',
      'icon': Icons.account_balance_wallet
    },
    {
      'title': 'New Store Available',
      'message': 'Hamza Store has been added to your list.',
      'time': '1 day ago',
      'icon': Icons.store
    },
    {
      'title': 'Credit Alert',
      'message': 'You have received a credit of \$500.',
      'time': '2 days ago',
      'icon': Icons.credit_card
    },
    {
      'title': 'Account Update',
      'message': 'Your account has been updated successfully.',
      'time': '1 week ago',
      'icon': Icons.update
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            margin: EdgeInsets.all(10.0),
            child: ExpansionTile(
              leading: Icon(
                notification['icon'],
                size: 30.0,
                color: Colors.blue,
              ),
              title: Text(
                notification['title'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(notification['time']),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(notification['message']),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
