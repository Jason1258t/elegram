import 'package:cloud_firestore/cloud_firestore.dart';

abstract final class FirebaseCollectionsNames {
  static const users = 'users';
}

abstract final class FirebaseCollections {
  static final _firestore = FirebaseFirestore.instance;

  static final users = _firestore.collection(FirebaseCollectionsNames.users);
}