import 'package:messenger_test/data/repository_with_authorize.dart';
import 'package:messenger_test/models/account.dart';
import 'package:messenger_test/models/user/user.dart';
import 'package:messenger_test/models/user/user_view.dart';
import 'package:messenger_test/services/remote/users/users_service.dart';
import 'package:messenger_test/utils/exceptions.dart';

class ProfileRepository implements RepositoryWithAuthorization {
  final UsersService _usersService;

  ProfileRepository(UsersService usersService) : _usersService = usersService;

  AccountData? _account;
  User? _currentUser;
  final List<UserViewData> _contacts = [];

  @override
  void initialize(AccountData account) {
    _account = account;
  }

  @override
  void logout() {
    _account = null;
    _currentUser = null;
    _contacts.clear();
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

  Future<void> editUserProfile(User newUserData) async {
    _guardAuth();

    await _usersService.editUserProfile(newUserData);
    getUserProfile();
  }

  Future<List<UserViewData>> getUserContacts() async {
    _guardAuth();

    if (_contacts.isEmpty) {
      _contacts.addAll(await _usersService.getUserContacts(_account!.userId));
    }
    return _contacts;
  }

  Future<void> addToContacts(UserViewData user) async {
    _guardAuth();

    await _usersService.addContact(_account!.userId, user.id);
    _contacts.add(user);
  }

  Future<void> removeFromContacts(UserViewData user) async {
    _guardAuth();

    await _usersService.removeFromContacts(_account!.userId, user.id);
    _contacts.remove(user);
  }
}
