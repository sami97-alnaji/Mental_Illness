import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatScreen extends StatefulWidget {
  static const String screenRoute = 'chat_screen';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String signedInUserEmail;
  final messageTextController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String messageText = '';

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    // Replace with your authentication logic
    signedInUserEmail = "user@example.com"; // Placeholder email
  }

  void scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void sendMessage() async {
    if (messageText.isNotEmpty) {
      final response = await http.post(
        Uri.parse('http://localhost:3000/messages'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'text': messageText,
          'sender': signedInUserEmail,
          'timestamp': DateTime.now().toIso8601String(),
        }),
      );
      if (response.statusCode == 200) {
        messageTextController.clear();
        setState(() {});
        scrollToBottom(); // Scroll to the latest message
      } else {
        // Handle error
        print('Error sending message');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[900],
        title: Row(
          children: [
            Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7k_8X4O7C6CSmFRWJmaiTMJXQbmlfsOB7A8pIo9AKamp95L3KqY9WBCxBbEW228Q7Q6A&usqp=CAU',
              height: 25,
            ),
            const SizedBox(width: 10),
            const Text('MessageMe')
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Handle sign out
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: MessagesStream(controller: _scrollController), // Pass the ScrollController here
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.orange,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        hintText: 'Write your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: sendMessage,
                    child: Text(
                      'Send',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  final ScrollController controller;

  MessagesStream({required this.controller});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
      stream: fetchMessages(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          );
        }

        final messages = snapshot.data!;
        List<MessageBubble> messageWidgets = [];
        for (var message in messages) {
          final messageText = message.text;
          final messageSender = message.sender;

          final messageWidget = MessageBubble(
              sender: messageSender,
              text: messageText,
              timestamp: message.timestamp);
          messageWidgets.add(messageWidget);
        }

        return ListView(
          controller: controller,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          children: messageWidgets,
        );
      },
    );
  }

  Stream<List<Message>> fetchMessages() async* {
    while (true) {
      final response = await http.get(Uri.parse('http://localhost:3000/messages'));
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        List<Message> messages = jsonList.map((json) => Message(
          sender: json['sender'],
          text: json['text'],
          timestamp: json['timestamp'],
        )).toList();

        // Ensure messages are ordered from oldest to newest
        messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));

        yield messages;
      } else {
        throw Exception('Failed to load messages');
      }
      await Future.delayed(const Duration(seconds: 2)); // Poll every 2 seconds
    }
  }
}

class Message {
  final String sender;
  final String text;
  final String timestamp;

  Message({required this.sender, required this.text, required this.timestamp});
}

class MessageBubble extends StatelessWidget {
  MessageBubble({required this.sender, required this.text, required this.timestamp});

  final String sender;
  final String text;
  final String timestamp;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
          Text(
            timestamp,
            style: const TextStyle(fontSize: 10, color: Colors.black54),
          ),
          Material(
            borderRadius: BorderRadius.circular(10),
            elevation: 5,
            color: Colors.blue[100],
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                text,
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
