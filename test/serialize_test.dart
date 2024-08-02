import 'package:flutter_test/flutter_test.dart';
import 'package:messenger_test/models/chat.dart';
import 'package:messenger_test/models/message/message.dart';
import 'package:messenger_test/models/message/message_statuses.dart';
import 'package:messenger_test/models/user/user.dart';

void main() {
  final user = User(
      id: '1',
      phone: '+79999999999',
      bio: 'bio',
      nickname: 'nickname',
      username: 'username',
      lastSeen: DateTime.now(),
      imageUrl: 'imageUrl');

  final message = Message(
      id: '1',
      authorId: '1',
      chatId: '1',
      isOwned: false,
      text: 'assa',
      lastUpdate: DateTime.now(),
      action: MessageSendActionsEnum.sent,
      status: MessageStatusEnum.sent);

  final chat = Chat(title: 'title', id: 'id', imageUrl: 'imageUrl');

  group('Objects serializing', () {
    test('Message serializing', () {
      expect(Message.fromMap(message.toMap()), message);
    });

    test('Chat serializing', () {
      expectLater(Chat.fromMap(chat.toMap()), chat);
    });

    test('User serializing', () {
      expect(User.fromMap(user.toMap()), user);
    });
  });
}
