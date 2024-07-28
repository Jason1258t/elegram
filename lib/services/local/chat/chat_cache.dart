import 'dart:async';

import 'package:messenger_test/models/chat.dart';
import 'package:messenger_test/models/message.dart';

abstract interface class ChatCacheService {
  FutureOr<void> saveUserChats(List<Chat> chats);

  FutureOr<List<Chat>> getUserChats();

  FutureOr<void> saveMessages(Map<String, List<Message>> messages);

  FutureOr<Map<String, List<Message>>> getMessages();

  FutureOr<void> logout();
}