import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:messenger_test/data/messenger_repository.dart';
import 'package:messenger_test/models/message/message.dart';
import 'package:meta/meta.dart';

part 'room_event.dart';

part 'room_state.dart';

// TODO test while this bloc

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final MessengerRepository _repository;
  final List<Message> _messages = [];
  final String _chatId;
  late final StreamSubscription _subscription;

  RoomBloc(this._repository, this._chatId) : super(RoomInitial()) {
    on<InitialLoadingEvent>(_onInitialize);
    on<SendMessageEvent>(_onSendMessage);
    on<ReceiveMessageEvent>(_receiveMessage);
    add(InitialLoadingEvent());
  }

  _onInitialize(InitialLoadingEvent event, emit) async {
    _loadPreview(event, emit);
    _loadMessages(event, emit);

    _subscribeMessages();
  }

  _loadPreview(InitialLoadingEvent event, emit) async {
    final cachedMessages = await _repository.getCachedChatMessages(_chatId);
    if (state is RoomReadyState) return;
    _messages.addAll(cachedMessages);
    emit(RoomPreviewState(_messages));
  }

  _loadMessages(InitialLoadingEvent event, emit) async {
    final newMessages = await _repository.getChatMessages(_chatId);
    _messages.clear();
    _messages.addAll(newMessages);
    _repository.saveCache();
    emit(RoomReadyState(_messages));
  }

  _subscribeMessages() async {
    final stream = await _repository.getMessagesStream(_chatId);
    _subscription =
        stream.listen((message) => add(ReceiveMessageEvent(message)));
  }

  _receiveMessage(ReceiveMessageEvent event, emit) {
    if (_messages.contains(event.message)) {
      _updateMessage(event.message);
    } else {
      _messages.add(event.message);
    }
    emit(RoomReadyState(_messages));
  }

  _onSendMessage(SendMessageEvent event, emit) async {
    final message = _repository.createMessage(event.text, _chatId);

    _messages.add(message);
    _sortMessages();
    emit(RoomReadyState(_messages));
  }

  _updateMessage(Message message) {
    _messages.removeWhere((e) => e.id == message.id);
    _messages.add(message);
    _sortMessages();
  }

  _sortMessages() =>
      _messages.sort((a, b) => a.lastUpdate.compareTo(b.lastUpdate));

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
