import 'package:messenger_test/models/user/user.dart';

class UserViewData {
  final String id;
  final String nickname;
  final DateTime lastSeen;
  final String username;
  final String imageUrl;
  final String? phone;
  final bool inContacts;

  UserViewData(
      {required this.username,
      required this.nickname,
      required this.id,
      required this.imageUrl,
      required this.lastSeen,
      this.phone,
      required this.inContacts});

  factory UserViewData.fromUser(User user,
      {bool showPhone = true, required bool inContacts}) {
    return UserViewData(
        username: user.username,
        nickname: user.nickname,
        id: user.id,
        imageUrl: user.imageUrl,
        lastSeen: user.lastSeen,
        phone: showPhone ? user.phone : null,
        inContacts: inContacts);
  }
}
