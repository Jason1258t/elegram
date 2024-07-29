import 'package:messenger_test/models/chat.dart';
import 'package:messenger_test/models/message.dart';
import 'package:messenger_test/services/remote/chat/chat_service.dart';
import 'package:rxdart/rxdart.dart';


/// Uses to interpret receiving messages as a rooms stream
class ChatsInterpreter {
  final RemoteMessengerService _chatService;
  final String _userId;

  late final BehaviorSubject<List<Chat>> _roomsStream;
  bool _roomsStreamInitialized = false;

  final List<Message> _pendingMessages = [];
  final List<String> _pendingChats = [];

  ChatsInterpreter(RemoteMessengerService chatService, String userId)
      : _chatService = chatService,
        _userId = userId;

  Future<BehaviorSubject<List<Chat>>> getRoomsStream() async {
    if (_roomsStreamInitialized) return _roomsStream;

    _roomsStream = BehaviorSubject<List<Chat>>();
    _roomsStreamInitialized = true;

    final chats = await _getChatsPreviews();
    _roomsStream.add(chats);

    _subscribeMessagesForRoomsStream();

    return _roomsStream;
  }

  /// return date sorted list of chats
  Future<List<Chat>> _getChatsPreviews() async {
    final chats = await _chatService.getAllUserChats(_userId);
    final List<Future> processes = [];

    for (var chat in chats) {
      processes.add(_loadChatLastMessage(chat));
    }

    await Future.wait(processes);

    _sortChatsByMessageDate(chats);

    return chats;
  }

  Future _loadChatLastMessage(Chat chat) async {
    final message = await _chatService.getChatLastMessage(chat.id);
    chat.lastMessage = message;
  }

  static void _sortChatsByMessageDate(List<Chat> chats) {
    chats.sort((a, b) {
      DateTime? aDt, bDt;
      if (a.lastMessage != null) aDt = a.lastMessage!.lastUpdate;
      if (b.lastMessage != null) bDt = b.lastMessage!.lastUpdate;

      return (aDt ?? DateTime(1900)).compareTo((bDt ?? DateTime(1900)));
    });
  }

  void _subscribeMessagesForRoomsStream() async {
    final messagesStream = await _chatService.getGeneralMessagesStream();

    messagesStream.listen((Message newMessage) async {
      final currentRooms = await _roomsStream.last;

      if (currentRooms.where((e) => e.id == newMessage.chatId).isNotEmpty) {
        final updatedRooms = _updateLastMessage(currentRooms, newMessage);
        _roomsStream.add(updatedRooms);
      } else {
        _handleMessageForNewChat(newMessage);
      }
    });
  }

  List<Chat> _updateLastMessage(List<Chat> chats, Message message) {
    if (chats.where((e) => e.id == message.chatId).isEmpty) {
      throw Exception('No chat for this message');
    }

    for (int i = 0; i < chats.length; i++) {
      if (chats[i].id == message.id) {
        chats[i].lastMessage = message;
        break;
      }
    }
    return chats;
  }

  void _handleMessageForNewChat(Message newMessage) {
    if (_pendingChats.contains(newMessage.chatId)) {
      _pendingMessages.add(newMessage);
    } else {
      _pendingChats.add(newMessage.chatId);
      _pendingMessages.add(newMessage);
      _addNewChat(newMessage.chatId);
    }
  }

  Future<void> _addNewChat(String chatId) async {
    final chat = await _chatService.getChatById(chatId);
    final lastMessage = _pendingMessages.where((e) => e.chatId == chatId).last;
    chat.lastMessage = lastMessage;
    _roomsStream.add((await _roomsStream.last)..add(chat));
    _clearPendingData(chatId);
  }

  void _clearPendingData(String chatId) {
    _pendingMessages.removeWhere((e) => e.chatId == chatId);
    _pendingChats.remove(chatId);
  }
}
