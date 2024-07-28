import 'package:messenger_test/models/account.dart';

abstract interface class RepositoryWithAuthorization {
  void initialize(AccountData account) {}
}