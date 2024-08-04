import 'package:flutter_test/flutter_test.dart';
import 'package:messenger_test/models/chat/chat.dart';
import 'package:messenger_test/models/chat/direct_chat.dart';
import 'package:messenger_test/models/chat/group_chat.dart';
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

  final directChat =
      DirectChat(id: '1', title: 'title', imageUrl: 'imageUrl', user: user);

  final groupChat = GroupChat(
      id: '1', title: 'title', imageUrl: 'imageUrl', members: [user, user]);

  group('Objects serializing', () {
    test('Message serializing', () {
      expect(Message.fromMap(message.toMap()), message);
    });

    test('Chat serializing', () {
      expect(Chat.fromMap(chat.toMap()), chat);
    });
    test('Direct chat serializing', () {
      expect(DirectChat.fromMap(directChat.toMap()), directChat);
    });

    test('Members list serializing', () {
      expect(
          groupChat.members
              .map((e) => e.toMap())
              .map((e) => User.fromMap(e))
              .toList(),
          groupChat.members);
    });

    test('Group chat serializing', () {
      expect(GroupChat.fromMap(groupChat.toMap()), groupChat);
    });

    test('User serializing', () {
      expect(User.fromMap(user.toMap()), user);
    });
  });
}
