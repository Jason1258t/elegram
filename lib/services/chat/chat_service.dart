import 'package:messenger_test/models/chat.dart';
import 'package:messenger_test/models/message.dart';
import 'package:rxdart/rxdart.dart';

abstract interface class ChatService {
  Future<List<Chat>> getAllUserChats(String userId);

  Future<List<Message>> getChatMessages(String chatId);

  Future<Message> getChatLastMessage(String chatId);

  Future<BehaviorSubject<Message>> getMessagesStream(String chatId);

  Future<BehaviorSubject<Message>> getAllMessagesStream();

  Future<void> sendMessage(Message message, String userId);
}