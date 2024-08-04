import 'package:equatable/equatable.dart';
import 'package:messenger_test/models/chat/chat.dart';
import 'package:messenger_test/models/message/message.dart';

import '../user/user.dart';

// ignore: must_be_immutable
class GroupChat extends Equatable implements Chat  {
  @override
  final String id;
  @override
  final String title;
  @override
  final String imageUrl;
  @override
  Message? lastMessage;
  final List<User> members;

//<editor-fold desc="Data Methods">
  GroupChat({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.lastMessage,
    required this.members,
  });

  @override
  String toString() {
    return 'GroupChat{ id: $id, title: $title, imageUrl: $imageUrl, lastMessage: $lastMessage, members: $members,}';
  }

  @override
  GroupChat copyWith({
    String? id,
    String? title,
    String? imageUrl,
    Message? lastMessage,
    List<User>? members,
  }) {
    return GroupChat(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      lastMessage: lastMessage ?? this.lastMessage,
      members: members ?? this.members,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'lastMessage': lastMessage?.toMap(),
      'members': members.map((e) => e.toMap()).toList(),
    };
  }

  factory GroupChat.fromMap(Map<String, dynamic> map) {
    return GroupChat(
      id: map['id'] as String,
      title: map['title'] as String,
      imageUrl: map['imageUrl'] as String,
      lastMessage: map['lastMessage'] != null
          ? Message.fromMap(map['lastMessage'])
          : null,
      members: (map['members'] as List).map((e) => User.fromMap(e)).toList(),
    );
  }

  @override
  List<Object?> get props => [id, title, imageUrl, members];


//</editor-fold>
}
