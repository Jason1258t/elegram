part of 'messenger_bloc.dart';

@immutable
sealed class MessengerEvent {}

class InitializeMessengerEvent extends MessengerEvent {}

class UpdateChatEvent extends MessengerEvent {
  final List<Chat> chats;

  UpdateChatEvent(this.chats);
}

class MessengerLoadingEvent extends MessengerEvent {}