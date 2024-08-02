import 'package:messenger_test/models/user.dart';

abstract interface class UsersService {
  Future<User> getUserById(String userId);

  Future<void> editUserProfile(User newUser);

  Future<void> createUserProfile(User user);
}