import 'package:flutter_test/flutter_test.dart';
import 'package:messenger_test/models/chat.dart';
import 'package:messenger_test/models/message.dart';

void main() {
  group('Objects parsing', () {
    final message = Message(
        id: '1',
        authorId: '1',
        chatId: '1',
        isOwned: false,
        text: 'assa',
        lastUpdate: DateTime.now(),
        action: MessageSendActionsEnum.sent,
        status: MessageStatusEnum.sent);

    test('Message serializing', () {
      expect(Message.fromMap(message.toMap()), message);
    });

    final chat = Chat(title: 'title', id: 'id', imageUrl: 'imageUrl');

    test('Chat serializing', () {
      expectLater(Chat.fromMap(chat.toMap()), chat);
    });
  });
}
