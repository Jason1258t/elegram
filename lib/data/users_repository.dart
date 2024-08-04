import 'package:messenger_test/data/repository_with_authorize.dart';
import 'package:messenger_test/models/account.dart';
import 'package:messenger_test/models/user/user_view.dart';
import 'package:messenger_test/services/remote/users/users_service.dart';

class UsersRepository implements RepositoryWithAuthorization {
  final UsersService _usersService;

  UsersRepository(UsersService usersService) : _usersService = usersService;

  AccountData? _account;
  final Map<String, UserViewData> _cachedUsers = {};


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
  UserViewData? getCachedUser(String userId) => _cachedUsers[userId];

  Future<UserViewData> getUserData(String userId) async {
    final user = await _usersService.getUserViewById(userId);
    _cachedUsers[userId] = user;
    return user;
  }

  Future<List<UserViewData>> searchUsers(String query) async {
    final result = await _usersService.searchUsers(query);
    return result;
  }
}