import 'package:cloud_firestore/cloud_firestore.dart';

abstract final class FBCollectionsNames {
  static const users = 'users';
  static const contacts = 'contacts';
}

abstract final class FirebaseCollections {
  static final _fs = FirebaseFirestore.instance;

  static final users = _fs.collection(FBCollectionsNames.users);
  static final contacts = _fs.collection(FBCollectionsNames.contacts);
}
