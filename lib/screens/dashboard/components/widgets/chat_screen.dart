import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Auth/controller/authcontroller.dart';
import '../../../controller/globalApp.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final appController = Get.put(AppController());
  final authController = Get.put(AuthController());
  bool isChatOpen = false;
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    appController.chat(authController.userData.value['UserID'].toString());
  }

  void toggleChat() {
    setState(() {
      isChatOpen = !isChatOpen;
    });
  }

  void sendMessage() {
    final message = _messageController.text;
    final userId = authController.userData.value['UserID'].toString();
    if (message.isNotEmpty) {
      appController.sendMessageToAdmin(userId, message, false).then((_) {
        appController.chat(userId);
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Support"),
        backgroundColor: Colors.blueGrey[800],
        actions: [
          IconButton(
            icon: Icon(Icons.chat),
            onPressed: toggleChat,
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Welcome to United Insurance Group (UIG)!",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blueGrey[800],
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "UIG House\n"
                    "4.4 ★ • 30 Google reviews\n\n"
                    "Insurance Company in Lahore\n"
                    "Address: House 1, UIG, Upper Mall Scheme,\n"
                    "Lahore, Punjab 54000\n\n"
                    "Hours: 9 am open ⋅ Closes 5 pm\n"
                    "Phone: 0320 1465926",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blueGrey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          if (isChatOpen)
            Container(
              width: 400,
              color: Colors.grey[200],
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    color: Colors.blueGrey[700],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Chat with Admin",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.white),
                          onPressed: toggleChat,
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
                              bool isFromAdmin = (message['isAdmin'] == 1);

                              String timestamp =
                                  message['message_time'].toString();
                              DateTime dateTime = DateTime.parse(timestamp);
                              String formattedTime =
                                  "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";

                              return Align(
                                alignment: isFromAdmin
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: isFromAdmin
                                        ? Colors.grey[300]
                                        : Colors.blue[300],
                                    borderRadius: BorderRadius.circular(8),
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
                                              ? Colors.black
                                              : Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        formattedTime,
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 12),
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
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            decoration: InputDecoration(
                              hintText: "Type a message...",
                              filled: true,
                              fillColor: Colors.black,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            icon: Icon(Icons.send, color: Colors.white),
                            onPressed: sendMessage,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      floatingActionButton: !isChatOpen
          ? FloatingActionButton(
              backgroundColor: Colors.blueGrey[800],
              onPressed: toggleChat,
              child: Icon(Icons.chat),
            )
          : null,
    );
  }
}
