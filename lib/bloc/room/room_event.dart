part of 'room_bloc.dart';

@immutable
sealed class RoomEvent {}

class InitialLoadingEvent extends RoomEvent {}

class ReceiveMessageEvent extends RoomEvent {
  final Message message;

  ReceiveMessageEvent(this.message);
}

class SendMessageEvent extends RoomEvent {
  final String text;

  SendMessageEvent(this.text);
}

class UpdateMessageStatusEvent extends RoomEvent {}
