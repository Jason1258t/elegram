import 'package:messenger_test/models/user/user.dart';

class UserViewData {
  final String nickname;
  final DateTime lastSeen;
  final String username;
  final String imageUrl;

  UserViewData({required User user})
      : nickname = user.nickname,
        username = user.username,
        lastSeen = user.lastSeen,
        imageUrl = user.imageUrl;
}
