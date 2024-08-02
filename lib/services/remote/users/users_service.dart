import 'package:messenger_test/models/user/user.dart';

abstract interface class UsersService {
  Future<User> getUserById(String userId);

  Future<void> editUserProfile(User newUser);

  Future<void> createUserProfile(User user);

  Future<List<User>> getUserContacts(String userId);

  Future<void> addContact(String userId, String contactId);

  Future<void> removeFromContacts(String userId, String contactId);

  Future<List<User>> searchUsers(String query);
}