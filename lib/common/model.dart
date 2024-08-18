enum ChatMessageType { user, bot }

class ChatMessage {
  ChatMessage({
    required this.text,
    this.name,
    required this.chatMessageType,
  });

  final String text;
  final String? name;
  final ChatMessageType chatMessageType;
}
