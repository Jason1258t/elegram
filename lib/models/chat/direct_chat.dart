import 'package:equatable/equatable.dart';
import 'package:messenger_test/models/chat/chat.dart';
import 'package:messenger_test/models/message/message.dart';
import 'package:messenger_test/models/user/user.dart';

// ignore: must_be_immutable
class DirectChat extends Equatable implements Chat {
  @override
  final String id;
  @override
  final String title;
  @override
  final String imageUrl;
  @override
  Message? lastMessage;

  User user;

  @override
  List<Object?> get props => [id, title, imageUrl, user];

//<editor-fold desc="Data Methods">
  DirectChat({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.user,
    this.lastMessage,
  });

  @override
  String toString() {
    return 'DirectChat{ id: $id, title: $title, imageUrl: $imageUrl, lastMessage: $lastMessage, user: $user}';
  }

  @override
  DirectChat copyWith(
      {String? id,
      String? title,
      String? imageUrl,
      Message? lastMessage,
      User? user}) {
    return DirectChat(
        id: id ?? this.id,
        title: title ?? this.title,
        imageUrl: imageUrl ?? this.imageUrl,
        lastMessage: lastMessage ?? this.lastMessage,
        user: user ?? this.user);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'lastMessage': lastMessage?.toMap(),
      'user': user.toMap()
    };
  }

  factory DirectChat.fromMap(Map<String, dynamic> map) {
    return DirectChat(
        id: map['id'] as String,
        title: map['title'] as String,
        imageUrl: map['imageUrl'] as String,
        lastMessage:
            map['message'] != null ? Message.fromMap(map['message']) : null,
        user: User.fromMap(map['user']));
  }

//</editor-fold>
}
