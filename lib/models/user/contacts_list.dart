class ContactsList {
  final String ownerId;
  final List<String> usersIds;

  ContactsList(this.ownerId, this.usersIds);

  ContactsList.fromMap(Map<String, dynamic> map)
      : ownerId = map['ownerId'],
        usersIds = map['usersIds'] as List<String>;

  Map<String, dynamic> toMap() {
    return {'ownerId': ownerId, 'usersIds': usersIds};
  }
}
