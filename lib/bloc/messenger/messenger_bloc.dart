import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:messenger_test/data/chat_loader.dart';
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
    on<MessengerLoadingEvent>(_onLoading);
    on<MessengerReadyEvent>(_onReady);
  }

  _initialize(event, emit) async {
    _subscribeAuth();
    _loadChats();
    _subscribeMessages();
  }

  _loadChats() async {
    add(MessengerLoadingEvent());
    final chats = await ChatsLoader(_repository).getChatsPreviews();

    _chats.clear();
    _chats.addAll(ChatsLoader.transformChatsListToMap(chats));
    add(MessengerReadyEvent());
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
    _repository.addToCache([event.message]);

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

  _onLoading(MessengerLoadingEvent event, emit) =>
      emit(MessengerLoadingState());

  _onReady(MessengerReadyEvent event, emit) =>
      emit(MessengerReadyState(_chatsAsList));

  @override
  Future<void> close() {
    _messagesSubscription.cancel();
    _authSubscription.cancel();
    return super.close();
  }
}
