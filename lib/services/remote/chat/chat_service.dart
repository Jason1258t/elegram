import 'package:messenger_test/models/chat.dart';
import 'package:messenger_test/models/message.dart';
import 'package:rxdart/rxdart.dart';

abstract interface class RemoteMessengerService {
  Future<List<Chat>> getAllUserChats(String userId);

  Future<Chat> getChatById(String id);

  Future<List<Message>> getChatMessages(String chatId);

  Future<Message> getChatLastMessage(String chatId);

  Future<BehaviorSubject<Message>> getMessagesStream(String chatId);

  Future<BehaviorSubject<Message>> getGeneralMessagesStream();

  Future<void> sendMessage(Message message, String userId);
}