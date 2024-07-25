import 'package:flutter_test/flutter_test.dart';
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

    test('Message parsing', () {
      expect(Message.fromMap(message.toMap()), message);
    });
  });
}
