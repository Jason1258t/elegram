part of 'messenger_bloc.dart';

@immutable
sealed class MessengerEvent {}

class InitializeMessengerEvent extends MessengerEvent {}

class ReceiveMessageEvent extends MessengerEvent {
  final Message message;
  ReceiveMessageEvent(this.message);
}