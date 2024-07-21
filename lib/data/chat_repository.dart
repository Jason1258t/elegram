import 'package:messenger_test/models/chat.dart';
import 'package:messenger_test/models/message.dart';
import 'package:messenger_test/services/chat/chat_service.dart';

class ChatRepository {
  final ChatService _chatService;

  ChatRepository(this._chatService);

  final Map<String, List<Message>> _cachedMessages = {};
  String? _userId;


  void logout() => _userId = null;

  void initializeWithUser(String userId) async {
    _userId = userId;
   final generalMessagesStream = await _chatService.getAllMessagesStream();
   generalMessagesStream.stream.listen(_sortMessagesFromStream);
  }

  void _sortMessagesFromStream(Message message) {
    if (_chatCacheNotExist(message.chatId)) {
      _cachedMessages[message.chatId] = [];
    }

    _cachedMessages[message.chatId]!.add(message);
  }

  bool _chatCacheNotExist(chatId) => !_cachedMessages.keys.contains(chatId);

  Future<List<Chat>> getUserChats() async {
    return await _chatService.getAllUserChats(_userId!);
  }

  Future<List<Message>> getChatMessages(String chatId) async {
    if (_cachedMessages.keys.contains(chatId)) {
      return _cachedMessages[chatId]!;
    }
    final messages = await _chatService.getChatMessages(chatId);
    _cachedMessages[chatId] = messages;
    return messages;
  }

  Future getMessagesStream(String chatId) async {
    return await _chatService.getMessagesStream(chatId);
  }

  Future<void> sendMessage(Message message) async {
    await _chatService.sendMessage(message, _userId!);
  }
}