import 'package:connecthub/pages/messaging/message_screen.dart';
import 'package:connecthub/utils/my_colors.dart';
import 'package:connecthub/utils/txt.dart';
import 'package:flutter/material.dart';
import 'package:connecthub/pages/messaging/message.dart';

class MessagesPage extends StatelessWidget {
  final List<Message> _messages = [
    Message(sender: 'John Doe', content: 'Hey, how are you?'),
    Message(sender: 'Jane Doe', content: 'I\'m good, thanks!'),
    Message(sender: 'John Doe', content: 'That\'s great to hear.'),
    Message(sender: 'Jane Doe', content: 'How about you?'),
    Message(sender: 'John Doe', content: 'I\'m doing well, thanks.'),
    Message(sender: 'Jane Doe', content: 'Glad to hear it!'),
  ];

  MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text(
          'Messages',
          style: txt.appBarTitle,
        ),
        backgroundColor: primary,
      ),
      body: ListView.builder(
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          final message = _messages[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text(message.sender[0].toUpperCase()),
            ),
            title: Text(message.sender),
            subtitle: Text(message.content),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessageScreen(message: message),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
