import 'package:equatable/equatable.dart';

import 'message.dart';

class Chat extends Equatable {
  final String title;
  final String id;
  final String imageUrl;
  Message? lastMessage;

//<editor-fold desc="Data Methods">
  Chat({
    required this.title,
    required this.id,
    required this.imageUrl,
    this.lastMessage,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Chat &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          id == other.id &&
          imageUrl == other.imageUrl &&
          lastMessage == other.lastMessage);

  @override
  int get hashCode =>
      title.hashCode ^ id.hashCode ^ imageUrl.hashCode ^ lastMessage.hashCode;

  @override
  String toString() {
    return 'Chat{ title: $title, id: $id, imageUrl: $imageUrl, lastMessage: $lastMessage,}';
  }

  Chat copyWith({
    String? title,
    String? id,
    String? imageUrl,
    Message? lastMessage,
  }) {
    return Chat(
      title: title ?? this.title,
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'imageUrl': imageUrl,
      'lastMessage': lastMessage,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      title: map['title'] as String,
      id: map['id'] as String,
      imageUrl: map['imageUrl'] as String,
      lastMessage: map['lastMessage'] != null
          ? Message.fromMap(map['lastMessage'])
          : null,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, imageUrl];

//</editor-fold>
}
