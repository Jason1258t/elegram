import 'package:messenger_test/models/user/contacts_list.dart';
import 'package:messenger_test/models/user/user.dart';
import 'package:messenger_test/models/user/user_view.dart';
import 'package:messenger_test/services/remote/firebase_collections.dart';
import 'package:messenger_test/services/remote/users/users_service.dart';
import 'package:messenger_test/utils/exceptions.dart';

class UsersServiceImpl implements UsersService {
  final _users = FirebaseCollections.users;
  final _contacts = FirebaseCollections.contacts;

  @override
  Future<void> editUserProfile(User newUser) async {
    await _users.doc(newUser.id).update(newUser.toMap());
  }

  @override
  Future<User> getUserById(String userId) async {
    final snapshot = await _users.doc(userId).get();
    if (snapshot.exists) return User.fromMap(snapshot.data()!);
    throw UserNotFoundException(message: 'id $userId not found');
  }

  @override
  Future<void> addContact(String userId, String contactId) async {
    final contacts = await _getContactsList(userId);
    contacts.usersIds.add(contactId);
    await _contacts.doc(userId).set(contacts.toMap());
  }

  Future<List<String>> _getUsersWhichHaveUserAsAContact(String userId) async {
    final contactsSnapshot =
        await _contacts.where('usersIds', arrayContains: userId).get();
    if (contactsSnapshot.docs.isNotEmpty) {
      final contacts = <String>[];
      for (var doc in contactsSnapshot.docs) {
        contacts.add(doc.data()['ownerId'] as String);
      }
      return contacts;
    }
    return [];
  }

  Future<ContactsList> _getContactsList(String userId) async {
    final contactsSnapshot = await _contacts.doc(userId).get();
    final ContactsList contactsList;
    if (contactsSnapshot.exists) {
      contactsList = ContactsList.fromMap(contactsSnapshot.data()!);
    } else {
      contactsList = ContactsList(userId, []);
    }
    return contactsList;
  }

  @override
  Future<List<UserViewData>> getUserContacts(String userId) async {
    final contactsList = await _getContactsList(userId);

    final usersWhichHaveContact = contactsList.usersIds.isNotEmpty
        ? await _getUsersWhichHaveUserAsAContact(userId)
        : [];

    final usersLoad = <Future<User>>[];

    for (String id in contactsList.usersIds) {
      usersLoad.add(getUserById(id));
    }

    final users = await Future.wait(usersLoad);

    final result = <UserViewData>[];
    for (var i in users) {
      result.add(UserViewData.fromUser(i,
          showPhone: usersWhichHaveContact.contains(i.id), inContacts: true));
    }

    return result;
  }

  @override
  Future<UserViewData> getUserViewById(String userId) async {
    final usersWhichHaveContact =
        await _getUsersWhichHaveUserAsAContact(userId);
    final showPhone = usersWhichHaveContact.contains(userId);

    final user = await getUserById(userId);

    final contacts = await _getContactsList(userId);

    return UserViewData.fromUser(user,
        showPhone: showPhone, inContacts: contacts.usersIds.contains(userId));
  }

  @override
  Future<void> removeFromContacts(String userId, String contactId) async {
    final contacts = await _getContactsList(userId);
    contacts.usersIds.remove(contactId);
    _contacts.doc(userId).set(contacts.toMap());
  }

  @override
  Future<List<UserViewData>> searchUsers(String query) {
    // TODO: implement searchUsers
    throw UnimplementedError();
  }
}
