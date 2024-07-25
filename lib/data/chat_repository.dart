import 'package:messenger_test/models/chat.dart';
import 'package:messenger_test/models/message.dart';
import 'package:messenger_test/services/local/chat/chat_cache.dart';
import 'package:messenger_test/services/remote/chat/chat_service.dart';
import 'package:rxdart/rxdart.dart';

enum AuthEventsEnum { auth, logout }

class ChatRepository {
  final ChatService _chatService; // TODO rename
  final ChatCache _chatCacheService; // TODO rename

  ChatRepository(this._chatService, this._chatCacheService);

  final Map<String, List<Message>> _cachedMessages = {};
  String? _userId;

  PublishSubject<AuthEventsEnum> authEventsStream = PublishSubject();

  void logout() {
    _cachedMessages.clear();
    _userId = null;
    authEventsStream.add(AuthEventsEnum.logout);
  }

  void initializeWithUser(String userId) async {
    _userId = userId;
    authEventsStream.add(AuthEventsEnum.auth);
  }

  bool chatCacheNotExist(chatId) => !_cachedMessages.keys.contains(chatId);

  Future<List<Chat>> getUserChats() => _chatService.getAllUserChats(_userId!);

  Future<Chat> getChatInfo(String id) => _chatService.getChatById(id);

  Future<Message?> getChatLastMessage(String chatId) =>
      _chatService.getChatLastMessage(chatId);

  Future<List<Message>> getCachedChatMessages(String chatId) async {
    if (_cachedMessages.keys.contains(chatId)) {
      return _cachedMessages[chatId]!;
    } else {
      final messages = await _getSavedMessages(chatId);
      _cachedMessages[chatId] = messages;
      return messages;
    }
  }

  /// Gets messages from chat service and updates cached messages
  Future<List<Message>> getChatMessages(String chatId) async {
    final messages = await _chatService.getChatMessages(chatId);
    _cachedMessages[chatId] = messages;
    return messages;
  }

  Future<List<Message>> _getSavedMessages(String chatId) async {
    final cachedCopy = await _chatCacheService.getMessages();
    return cachedCopy[chatId] ?? [];
  }

  Future addToCache(List<Message> messages) async {
    final chatId = messages.first.chatId;
    if (chatCacheNotExist(chatId)) _cachedMessages[chatId] = [];
    for (var i in messages) {
      if (_cachedMessages[chatId]!.contains(i)) {
        _cachedMessages[chatId]!.remove(i);
      }
    }
    _cachedMessages[chatId]!.addAll(messages);
  }

  Future saveCache() async {
    final savedCache = await _chatCacheService.getMessages();
    savedCache.addAll(_cachedMessages);
    await _chatCacheService.saveMessages(savedCache);
  }

  Future<BehaviorSubject<Message>> getMessagesStream(String chatId) =>
      _chatService.getMessagesStream(chatId);

  Future<BehaviorSubject<Message>> getGeneralMessagesStream() =>
      _chatService.getGeneralMessagesStream();

  Message createMessage(String text, String chatId) =>
      Message.create(text: text, authorId: _userId!, chatId: chatId);

  Future<void> sendMessage(Message message) =>
      _chatService.sendMessage(message, _userId!);
}
