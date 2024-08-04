import 'package:messenger_test/models/user/user.dart';
import 'package:messenger_test/models/user/user_view.dart';

abstract interface class UsersService {
  Future<User> getUserById(String userId);

  Future<UserViewData> getUserViewById(String userId);

  Future<void> editUserProfile(User newUser);

  Future<List<UserViewData>> getUserContacts(String userId);

  Future<void> addContact(String userId, String contactId);

  Future<void> removeFromContacts(String userId, String contactId);

  Future<List<UserViewData>> searchUsers(String query);
}
