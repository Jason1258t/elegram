import 'dart:developer';

import 'package:messenger_test/models/user/user.dart';
import 'package:messenger_test/services/remote/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:messenger_test/services/remote/firebase_collections.dart';

class AuthServiceImpl implements AuthService {
  final _auth = FirebaseAuth.instance;
  final _users = FirebaseCollections.users;

  @override
  Future<void> verifyPhone(String phone,
      {required Function(dynamic credentials) verificationCompleted,
      required Function(String varificationId, int? resendToken) onCodeSent,
      Function(Exception e)? onError}) async {
    await _auth.verifyPhoneNumber(
        verificationCompleted: verificationCompleted,
        verificationFailed: onError ??
            (e) {
              log(e.toString());
            },
        codeSent: onCodeSent,
        codeAutoRetrievalTimeout: (message) {});
  }

  @override
  Future<String> confirmCode(String id, String code) async {
    final credentials =
        PhoneAuthProvider.credential(verificationId: id, smsCode: code);
    final userCredentials = await _auth.signInWithCredential(credentials);
    return userCredentials.user!.uid;
  }

  @override
  Future<String> confirmCredentials(credentials) async {
    final userCredentials = await _auth.signInWithCredential(credentials);
    return userCredentials.user!.uid;
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }

  @override
  Future<bool> profileExists(String id) async {
    final snapshot = await _users.doc(id).get();
    return snapshot.exists;
  }

  @override
  Future<void> registerUserProfile(User user) async {
    await _users.doc(user.id).set(user.toMap());
  }

  @override
  Future<bool> authorized() async {
    return _auth.currentUser != null;
  }

  @override
  Future<String> currentUserId() async {
    return _auth.currentUser!.uid;
  }
}
