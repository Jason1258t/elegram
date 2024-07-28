import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:messenger_test/data/messenger_repository.dart';
import 'package:messenger_test/models/chat.dart';
import 'package:meta/meta.dart';

part 'messenger_event.dart';

part 'messenger_state.dart';

// TODO test whole this bloc

class MessengerBloc extends Bloc<MessengerEvent, MessengerState> {
  final MessengerRepository _repository;
  late StreamSubscription _roomsSubscription;
  late final StreamSubscription _authSubscription;

  MessengerBloc(this._repository) : super(MessengerInitial()) {
    on<InitializeMessengerEvent>(_initialize);
    on<MessengerLoadingEvent>(_onLoading);
    on<UpdateChatEvent>(_updateChats);
  }

  _initialize(event, emit) async {
    _subscribeAuth();
    add(MessengerLoadingEvent());
  }

  _subscribeAuth() {
    _authSubscription = _repository.authEventsStream.listen((event) {
      if (event == AuthEventsEnum.logout) {
        _roomsSubscription.cancel();
      } else if (event == AuthEventsEnum.auth) {
        _subscribeRooms();
      }
    });
  }

  _subscribeRooms() async {
    final stream = await _repository.getRoomsStream();
    _roomsSubscription = stream.listen((chats) {
      add(UpdateChatEvent(chats));
    });
  }

  _updateChats(UpdateChatEvent event, emit) =>
      emit(MessengerReadyState(event.chats));

  _onLoading(MessengerLoadingEvent event, emit) =>
      emit(MessengerLoadingState());

  @override
  Future<void> close() {
    _roomsSubscription.cancel();
    _authSubscription.cancel();
    return super.close();
  }
}
