part of 'messenger_bloc.dart';

@immutable
sealed class MessengerState {}

final class MessengerInitial extends MessengerState {}

final class MessengerLoadingState extends MessengerState {}

final class MessengerReadyState extends MessengerState {
  final List<Chat> chats;

  MessengerReadyState(this.chats);
}

final class MessengerErrorState extends MessengerState {}