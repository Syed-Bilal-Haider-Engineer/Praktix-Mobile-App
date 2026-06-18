enum MessageSender { user, assistant }

class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.content,
    required this.sender,
    required this.timestamp,
  });

  final String id;
  final String content;
  final MessageSender sender;
  final DateTime timestamp;

  factory ChatMessage.user(String content) {
    return ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      sender: MessageSender.user,
      timestamp: DateTime.now(),
    );
  }

  factory ChatMessage.assistant(String content) {
    return ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      sender: MessageSender.assistant,
      timestamp: DateTime.now(),
    );
  }
}
