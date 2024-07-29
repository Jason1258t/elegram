import 'package:messenger_test/data/chats_interpreter.dart';
import 'package:messenger_test/data/repository_with_authorize.dart';
import 'package:messenger_test/models/account.dart';
import 'package:messenger_test/models/chat.dart';
import 'package:messenger_test/models/message.dart';
import 'package:messenger_test/services/local/chat/chat_cache.dart';
import 'package:messenger_test/services/remote/chat/chat_service.dart';
import 'package:messenger_test/utils/exceptions.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

enum AuthEventsEnum { auth, logout }

class MessengerRepository implements RepositoryWithAuthorization {
  final RemoteMessengerService _remoteChatService;
  final ChatCacheService _chatCacheService;

  ChatsInterpreter? _chatsInterpreter;

  MessengerRepository(
      RemoteMessengerService remoteService, ChatCacheService cacheService)
      : _remoteChatService = remoteService,
        _chatCacheService = cacheService;

  final Map<String, List<Message>> _cachedMessages = {};
  String? _userId;

  BehaviorSubject<AuthEventsEnum> authEventsStream = BehaviorSubject();

  void logout() {
    _cachedMessages.clear();
    _userId = null;
    _chatCacheService.logout();
    authEventsStream.add(AuthEventsEnum.logout);
  }

  @override
  void initialize(AccountData account) async {
    _userId = account.userId;
    authEventsStream.add(AuthEventsEnum.auth);
  }

  _guardUserAuthorization() {
    if (_userId == null) throw UserNotAuthorizedException();
  }

  Future<BehaviorSubject<List<Chat>>> getRoomsStream() async {
    _guardUserAuthorization();
    _chatsInterpreter ??= ChatsInterpreter(_remoteChatService, _userId!)
      ..getRoomsStream();

    return _chatsInterpreter!.getRoomsStream();
  }

  Future<List<Message>> getCachedChatMessages(String chatId) async {
    if (_chatCacheNotExist(chatId)) {
      final messages = await _getSavedMessages(chatId);
      _cachedMessages[chatId] = messages;
    }

    return _cachedMessages[chatId]!;
  }

  bool _chatCacheNotExist(chatId) => !_cachedMessages.keys.contains(chatId);

  /// Gets messages from chat service and updates cached messages
  Future<List<Message>> getChatMessages(String chatId) async {
    final messages = await _remoteChatService.getChatMessages(chatId);
    _cachedMessages[chatId] = messages;
    return messages;
  }

  Future<List<Message>> _getSavedMessages(String chatId) async {
    final cachedCopy = await _chatCacheService.getMessages();
    return cachedCopy[chatId] ?? [];
  }

  Future saveCache() async {
    final savedCache = await _chatCacheService.getMessages();
    savedCache.addAll(_cachedMessages);
    await _chatCacheService.saveMessages(savedCache);
  }

  Future<BehaviorSubject<Message>> getMessagesStream(String chatId) {
    _guardUserAuthorization();
    return _remoteChatService.getMessagesStream(chatId);
  }

  Message createMessage(String text, String chatId) {
    _guardUserAuthorization();
    return Message.create(text: text, authorId: _userId!, chatId: chatId);
  }

  Future<void> sendMessage(Message message) async {
    _guardUserAuthorization();
    _remoteChatService.sendMessage(message, _userId!);
  }
}
