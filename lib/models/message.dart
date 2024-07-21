enum MessageStatusEnum { preparing, sent, read }

enum MessageSendActionsEnum { sent, edited }

class Message {
  final String id;
  final String text;
  final String authorId;
  final bool isOwned;
  final String chatId;
  final DateTime lastUpdate;

  Message({
    required this.id,
    required this.authorId,
    required this.chatId,
    required this.isOwned,
    required this.text,
    required this.lastUpdate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'authorId': authorId,
      'isOwned': isOwned,
      'chatId': chatId,
      'lastUpdate': lastUpdate.toIso8601String()
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
        id: map['id'] as String,
        text: map['text'] as String,
        authorId: map['authorId'] as String,
        isOwned: map['isOwned'] as bool,
        chatId: map['chatId'] as String,
        lastUpdate: DateTime.parse(map['lastUpdate']));
  }

  @override
  String toString() {
    return 'Message{id: $id, text: $text, authorId: $authorId}';
  }
}
