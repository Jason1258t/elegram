import 'package:messenger_test/data/repository_with_authorize.dart';
import 'package:messenger_test/models/account.dart';
import 'package:messenger_test/models/user/user.dart';
import 'package:messenger_test/services/remote/users/users_service.dart';

class UsersRepository implements RepositoryWithAuthorization {
  final UsersService _usersService;

  UsersRepository(UsersService usersService) : _usersService = usersService;

  AccountData? _account;
  final Map<String, User> _cachedUsers = {};


  @override
  void initialize(AccountData account) {
    _account = account;
  }

  @override
  void logout() {
    _account = null;
    _cachedUsers.clear(); // i don't sure
  }

  /// Use for showing preview
  User? getCachedUser(String userId) => _cachedUsers[userId];

  Future<User> getUserData(String userId) async {
    final user = await _usersService.getUserById(userId);
    _cachedUsers[userId] = user;
    return user;
  }

  Future<List<User>> searchUsers(String query) async {
    final result = await _usersService.searchUsers(query);
    return result;
  }
}