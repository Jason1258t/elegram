import 'package:messenger_test/models/chat.dart';
import 'package:messenger_test/models/message.dart';
import 'package:messenger_test/services/remote/chat/chat_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class ChatServiceMock implements RemoteMessengerService {
  @override
  Future<List<Chat>> getAllUserChats(String userId) {
    // TODO: implement getAllUserChats
    throw UnimplementedError();
  }

  @override
  Future<Message> getChatLastMessage(String chatId) {
    // TODO: implement getChatLastMessage
    throw UnimplementedError();
  }

  final Map<String, List<Message>> _messages = {};
  final BehaviorSubject<Message> _generalMessagesStream =
      BehaviorSubject<Message>();

  ChatServiceMock() {
    _initializeFakeData();
  }

  void _initializeFakeData() {
    final fakeMessages = [
      Message(
        id: const Uuid().v4(),
        text: 'Hello, this is a test message.',
        authorId: 'user1',
        chatId: 'chat1',
        isOwned: true,
        lastUpdate: DateTime.now().subtract(const Duration(minutes: 5)),
        status: MessageStatusEnum.sent,
        action: MessageSendActionsEnum.sent,
      ),
      Message(
        id: const Uuid().v4(),
        text: 'Hi there, another test message.',
        authorId: 'user2',
        chatId: 'chat1',
        isOwned: false,
        lastUpdate: DateTime.now().subtract(const Duration(minutes: 3)),
        status: MessageStatusEnum.read,
        action: MessageSendActionsEnum.sent,
      ),
      Message(
        id: const Uuid().v4(),
        text: 'Hello from chat 2!',
        authorId: 'user1',
        chatId: 'chat2',
        isOwned: true,
        lastUpdate: DateTime.now().subtract(const Duration(minutes: 10)),
        status: MessageStatusEnum.sent,
        action: MessageSendActionsEnum.sent,
      ),
    ];

    for (var message in fakeMessages) {
      if (!_messages.containsKey(message.chatId)) {
        _messages[message.chatId] = [];
      }
      _messages[message.chatId]!.add(message);
      _generalMessagesStream.add(message);
    }
  }

  @override
  Future<List<Message>> getChatMessages(String chatId) async {
    return _messages[chatId] ?? [];
  }

  @override
  Future<BehaviorSubject<Message>> getGeneralMessagesStream() async {
    return _generalMessagesStream;
  }

  @override
  Future<BehaviorSubject<Message>> getMessagesStream(String chatId) async {
    if (!_messages.containsKey(chatId)) {
      _messages[chatId] = [];
    }
    final BehaviorSubject<Message> chatStream = BehaviorSubject<Message>();
    for (var message in _messages[chatId]!) {
      chatStream.add(message);
      await Future.delayed(const Duration(seconds: 5));
    }
    return chatStream;
  }

  @override
  Future<void> sendMessage(Message message, String userId) async {
    if (!_messages.containsKey(message.chatId)) {
      _messages[message.chatId] = [];
    }
    _messages[message.chatId]!.add(message);
    _generalMessagesStream.add(message);
  }

  @override
  Future<Chat> getChatById(String id) {
    // TODO: implement getChatById
    throw UnimplementedError();
  }
}
