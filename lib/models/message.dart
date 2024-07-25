import 'package:equatable/equatable.dart';
import 'package:messenger_test/utils/extensions/string_to_enum.dart';
import 'package:uuid/uuid.dart';

enum MessageStatusEnum { preparing, sent, read }

enum MessageSendActionsEnum { sent, edited }

class Message extends Equatable {
  final String id;
  final String text;
  final String authorId;
  final bool isOwned;
  final String chatId;
  final DateTime lastUpdate;

  final MessageStatusEnum status;
  final MessageSendActionsEnum action;

  const Message(
      {required this.id,
      required this.authorId,
      required this.chatId,
      required this.isOwned,
      required this.text,
      required this.lastUpdate,
      required this.action,
      required this.status});

  Message.create(
      {required this.text, required this.authorId, required this.chatId})
      : lastUpdate = DateTime.now(),
        status = MessageStatusEnum.preparing,
        action = MessageSendActionsEnum.sent,
        isOwned = true,
        id = const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'authorId': authorId,
      'isOwned': isOwned,
      'chatId': chatId,
      'lastUpdate': lastUpdate.toIso8601String(),
      'action': action.toString().split('.')[1],
      'status': status.toString().split('.')[1]
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
        id: map['id'] as String,
        text: map['text'] as String,
        authorId: map['authorId'] as String,
        isOwned: map['isOwned'] as bool,
        chatId: map['chatId'] as String,
        lastUpdate: DateTime.parse(map['lastUpdate']),
        status: (map['status'] as String).toEnum(MessageStatusEnum.values),
        action:
            (map['action'] as String).toEnum(MessageSendActionsEnum.values));
  }

  @override
  String toString() {
    return 'Message{id: $id, text: $text, authorId: $authorId}';
  }

  Message copyWith({
    String? id,
    String? text,
    String? authorId,
    bool? isOwned,
    String? chatId,
    DateTime? lastUpdate,
    MessageStatusEnum? status,
    MessageSendActionsEnum? action,
  }) {
    return Message(
      id: id ?? this.id,
      text: text ?? this.text,
      authorId: authorId ?? this.authorId,
      isOwned: isOwned ?? this.isOwned,
      chatId: chatId ?? this.chatId,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      status: status ?? this.status,
      action: action ?? this.action,
    );
  }

  @override
  List<Object?> get props => [id, text, authorId, status, action, lastUpdate];
}
