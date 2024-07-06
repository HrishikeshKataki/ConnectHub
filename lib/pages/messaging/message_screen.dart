import 'package:flutter/material.dart';
import 'package:connecthub/pages/messaging/message.dart';

class MessageScreen extends StatelessWidget {
  final Message message;

  const MessageScreen({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(message.sender),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message.content),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: const Text('User'),
                    subtitle: Text('Message $index'),
                    trailing: Text('12:0$index PM'),
                  );
                },
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
