import 'dart:async';

import 'package:messenger_test/models/chat.dart';
import 'package:messenger_test/models/message.dart';
import 'package:messenger_test/services/local/chat/chat_cache.dart';

class ChatCacheMock implements ChatCache {
  @override
  FutureOr<Map<String, List<Message>>> getMessages() {
    return {};
  }

  @override
  FutureOr<List<Chat>> getUserChats() {
    return [];
  }

  @override
  FutureOr<void> saveMessages(Map<String, List<Message>> messages) {}

  @override
  FutureOr<void> saveUserChats(List<Chat> chats) {}
}
