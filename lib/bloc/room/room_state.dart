part of 'room_bloc.dart';

@immutable
sealed class RoomState {}

final class RoomInitial extends RoomState {}

final class RoomLoadingState extends RoomState {}

final class RoomReadyState extends RoomState {
  final List<Message> messages;

  RoomReadyState(this.messages);
}

final class RoomPreviewState extends RoomState {
  final List<Message> messages;

  RoomPreviewState(this.messages);
}