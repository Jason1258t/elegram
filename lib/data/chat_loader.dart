import 'package:messenger_test/data/chat_repository.dart';
import 'package:messenger_test/models/chat.dart';

class ChatsLoader {
  final ChatRepository _repository; // TODO I think this dependency is shit

  ChatsLoader(this._repository);

  /// return date sorted list of chats
  Future<List<Chat>> getChatsPreviews() async {
    final chats = await _repository.getUserChats();
    final List<Future> processes = [];

    for (var chat in chats) {
      processes.add(_loadChatLastMessage(chat));
    }

    await Future.wait(processes);

    sortChatsByMessageDate(chats);

    return chats;
  }

  Future _loadChatLastMessage(Chat chat) async {
    final message = await _repository.getChatLastMessage(chat.id);
    chat.lastMessage = message;
  }

  static void sortChatsByMessageDate(List<Chat> chats) {
    chats.sort((a, b) {
      DateTime? aDt, bDt;
      if (a.lastMessage != null) aDt = a.lastMessage!.lastUpdate;
      if (b.lastMessage != null) bDt = b.lastMessage!.lastUpdate;

      return (aDt ?? DateTime(1900)).compareTo((bDt ?? DateTime(1900)));
    });
  }

  static Map<String, Chat> transformChatsListToMap(List<Chat> chats) {
    final chatsAsMap = <String, Chat>{};
    for (var chat in chats) {
      chatsAsMap[chat.id] = chat;
    }

    return chatsAsMap;
  }
}
