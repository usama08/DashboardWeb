import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dashboarweb/screens/AdminSide/controller/admincontroller.dart';
import '../../Auth/controller/authcontroller.dart';
import '../../controller/globalApp.dart';

class UserNotifications extends StatefulWidget {
  const UserNotifications({super.key});

  @override
  State<UserNotifications> createState() => _UserNotificationsState();
}

class _UserNotificationsState extends State<UserNotifications> {
  final adminController = Get.put(AdminController());
  final appController = Get.put(AppController());
  final authController = Get.put(AuthController());

  bool isChatOpen = false;
  String currentUserId = '';
  final TextEditingController _messageController = TextEditingController();
  var fullname = '';

  @override
  void initState() {
    super.initState();
    adminController.userNotification();
  }

  void toggleChat(String userId, String userName) {
    setState(() {
      isChatOpen = !isChatOpen;
      currentUserId = userId; // Set current user ID for sending messages
      fullname = userName;
    });
  }

  void sendMessage() {
    final message = _messageController.text;
    if (message.isNotEmpty && currentUserId.isNotEmpty) {
      // Send message with `user_id` including admin/user indicator
      appController.sendMessageToAdmin(currentUserId, message, true).then((_) {
        appController.chat(currentUserId); // Refresh chat for user
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Notifications'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWideScreen = constraints.maxWidth > 600;

          return Obx(() {
            if (adminController.userNotifications.isEmpty) {
              return const Center(
                child: Text('No notifications available'),
              );
            }

            List<Map<String, dynamic>> uniqueUserNotifications = [];
            Set<String> seenUserIds = {};

            for (var notification in adminController.userNotifications) {
              String fullname = notification['fullName'].toString();
              if (!seenUserIds.contains(fullname)) {
                seenUserIds.add(fullname);
                uniqueUserNotifications.add(notification);
              }
            }

            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isWideScreen ? 3 : 1,
                      mainAxisSpacing: 16.0,
                      crossAxisSpacing: 16.0,
                      childAspectRatio: 3,
                    ),
                    itemCount: uniqueUserNotifications.length,
                    itemBuilder: (context, index) {
                      final userNotification = uniqueUserNotifications[index];
                      final userId =
                          userNotification['user_id']?.toString() ?? 'Unknown';
                      final userName =
                          userNotification['fullName']?.toString() ?? 'Unknown';

                      return Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            child: Text(
                              userName.isNotEmpty
                                  ? userName[0].toUpperCase()
                                  : '?',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            'User: $userName',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: isWideScreen ? 16 : 14,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.message,
                                color: Colors.blueAccent),
                            onPressed: () {
                              toggleChat(userId,
                                  userName); // Open chat for selected user
                              appController
                                  .chat(userId); // Load messages for user
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (isChatOpen)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 400,
                      height: constraints.maxHeight,
                      color: Colors.grey[200],
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            color: Colors.blueGrey[700],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Chat with $fullname",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close,
                                      color: Colors.white),
                                  onPressed: () {
                                    toggleChat;
                                  },
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Obx(() {
                                final messages = appController.chatReceived;
                                return ListView.builder(
                                    itemCount: messages.length,
                                    itemBuilder: (context, index) {
                                      final message = messages[index];
                                      bool isFromAdmin =
                                          (message['isAdmin'] == 1);

                                      String timestamp =
                                          message['message_time'].toString();
                                      DateTime dateTime =
                                          DateTime.parse(timestamp);
                                      String formattedTime =
                                          "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";

                                      return Align(
                                        alignment: isFromAdmin
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: isFromAdmin
                                                ? Colors.blue[300]
                                                : Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: isFromAdmin
                                                ? CrossAxisAlignment.end
                                                : CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                message['message'],
                                                style: TextStyle(
                                                  color: isFromAdmin
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                formattedTime,
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _messageController,
                                    decoration: InputDecoration(
                                      hintText: "Type a message...",
                                      filled: true,
                                      fillColor: Colors.black,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 16),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  child: IconButton(
                                    icon: const Icon(Icons.send,
                                        color: Colors.white),
                                    onPressed: sendMessage,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          });
        },
      ),
    );
  }
}
