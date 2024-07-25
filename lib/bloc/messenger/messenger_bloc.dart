import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:messenger_test/data/chat_repository.dart';
import 'package:messenger_test/models/chat.dart';
import 'package:messenger_test/models/message.dart';
import 'package:meta/meta.dart';

part 'messenger_event.dart';

part 'messenger_state.dart';

// TODO test whole this bloc

class MessengerBloc extends Bloc<MessengerEvent, MessengerState> {
  final ChatRepository _repository;
  late StreamSubscription _messagesSubscription;
  late final StreamSubscription _authSubscription;
  final Map<String, Chat> _chats = {};

  List<Chat> get _chatsAsList => _chats.values.toList();

  MessengerBloc(this._repository) : super(MessengerInitial()) {
    on<InitializeMessengerEvent>(_initialize);
    on<ReceiveMessageEvent>(_receiveMessage);
  }

  _initialize(event, emit) async {
    _subscribeAuth();
    _loadChats(emit);
    _subscribeMessages();
  }

  _loadChats(emit) async {
    emit(MessengerLoadingState());
    final chats = await _syncLoadChatsPreviews();
    _sortChatsByMessageDate(chats);

    _chats.clear();
    _chats.addAll(_transformChatsListToMap(chats));
    emit(MessengerReadyState(_chatsAsList));
  }

  Future<List<Chat>> _syncLoadChatsPreviews() async {
    final chats = await _repository.getUserChats();
    final List<Future> processes = [];

    for (var chat in chats) {
      processes.add(_loadChatLastMessage(chat));
    }

    await Future.wait(processes);
    return chats;
  }

  Future _loadChatLastMessage(Chat chat) async {
    final message = await _repository.getChatLastMessage(chat.id);
    chat.lastMessage = message;
  }

  void _sortChatsByMessageDate(List<Chat> chats) {
    chats.sort((a, b) {
      DateTime? aDt, bDt;
      if (a.lastMessage != null) aDt = a.lastMessage!.lastUpdate;
      if (b.lastMessage != null) bDt = b.lastMessage!.lastUpdate;

      return (aDt ?? DateTime(1900)).compareTo((bDt ?? DateTime(1900)));
    });
  }

  Map<String, Chat> _transformChatsListToMap(List<Chat> chats) {
    final chatsAsMap = <String, Chat>{};

    for (var chat in chats) {
      chatsAsMap[chat.id] = chat;
    }

    return chatsAsMap;
  }

  _subscribeAuth() {
    _authSubscription = _repository.authEventsStream.listen((event) {
      if (event == AuthEventsEnum.logout) {
        _messagesSubscription.cancel();
      } else if (event == AuthEventsEnum.auth) {
        _subscribeMessages();
      }
    });
  }

  _subscribeMessages() async {
    final stream = await _repository.getGeneralMessagesStream();
    _messagesSubscription =
        stream.listen((message) => add(ReceiveMessageEvent(message)));
  }

  _receiveMessage(ReceiveMessageEvent event, emit) async {
    if (_repository.chatCacheNotExist(event.message.chatId)) {
      _repository
          .addToCache(await _repository.getChatMessages(event.message.chatId));
    } else {
      _repository.addToCache([event.message]);
    }
    await _updateDisplayedChats(event.message);
    emit(MessengerReadyState(_chatsAsList));
  }

  Future _updateDisplayedChats(Message receivedMessage) async {
    if (_chats.keys.contains(receivedMessage.chatId)) {
      _chats[receivedMessage.chatId]!.lastMessage = receivedMessage;
    } else {
      await _getNewChatInfo(receivedMessage.chatId, receivedMessage);
    }
  }

  _getNewChatInfo(String chatId, Message receivedMessage) async {
    final newChat = await _repository.getChatInfo(chatId);
    newChat.lastMessage = receivedMessage;
    _chats[chatId] = newChat;
  }

  @override
  Future<void> close() {
    _messagesSubscription.cancel();
    _authSubscription.cancel();
    return super.close();
  }
}
