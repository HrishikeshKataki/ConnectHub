class Message {
  final String sender;
  final String content;
  final bool isSentByUser;

  Message(
      {required this.sender, required this.content, this.isSentByUser = false});
}

