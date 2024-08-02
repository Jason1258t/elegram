import 'package:messenger_test/data/repository_with_authorize.dart';
import 'package:messenger_test/models/account.dart';
import 'package:messenger_test/models/user.dart';
import 'package:messenger_test/services/remote/users/users_service.dart';
import 'package:messenger_test/utils/exceptions.dart';

class ProfileRepository implements RepositoryWithAuthorization {
  final UsersService _usersService;

  ProfileRepository(UsersService usersService) : _usersService = usersService;

  AccountData? _account;
  User? _currentUser;

  @override
  void initialize(AccountData account) {
    _account = account;
  }

  @override
  void logout() {
    _account = null;
    _currentUser = null;
  }

  void _guardAuth() {
    if (_account == null) throw UserNotAuthorizedException();
  }

  User get profile {
    _guardAuth();
    return _currentUser!;
  }

  Future<User> getUserProfile() async {
    _guardAuth();
    _currentUser = await _usersService.getUserById(_account!.userId);
    return _currentUser!;
  }

  Future<void> createUserProfile(User user) async {
    _guardAuth();
    await _usersService.createUserProfile(user);
  }

  Future<void> editUserProfile(User newUserData) async {
    _guardAuth();
    await _usersService.editUserProfile(newUserData);
    getUserProfile();
  }
}
