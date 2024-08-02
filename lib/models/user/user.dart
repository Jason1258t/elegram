import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String nickname;
  final String username;
  final String phone;
  final String bio;
  final String imageUrl;
  final DateTime lastSeen;

  const User(
      {required this.id,
      required this.phone,
      required this.bio,
      required this.nickname,
      required this.username,
      required this.imageUrl,
      required this.lastSeen});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nickname': nickname,
      'username': username,
      'imageUrl': imageUrl,
      'phone': phone,
      'bio': bio,
      'lastSeen': lastSeen.toIso8601String()
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['id'] as String,
        nickname: map['nickname'] as String,
        username: map['username'] as String,
        imageUrl: map['imageUrl'] as String,
        phone: map['phone'],
        lastSeen: DateTime.parse(map['lastSeen']),
        bio: map['bio']);
  }

  @override
  List<Object?> get props =>
      [id, username, nickname, bio, phone, imageUrl, lastSeen];
}
