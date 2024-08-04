import 'dart:async';

import 'package:messenger_test/models/chat/chat.dart';
import 'package:messenger_test/models/message/message.dart';
import 'package:messenger_test/services/local/chat/chat_cache.dart';

class ChatCacheMock implements ChatCacheService {
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

  @override
  FutureOr<void> logout() {}
}
