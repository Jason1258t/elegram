class AccountData {
  final String userId;

  const AccountData({
    required this.userId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountData &&
          runtimeType == other.runtimeType &&
          userId == other.userId);

  @override
  int get hashCode => userId.hashCode;

  @override
  String toString() {
    return 'AccountData{ userId: $userId,}';
  }

  AccountData copyWith({
    String? userId,
  }) {
    return AccountData(
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
    };
  }

  factory AccountData.fromMap(Map<String, dynamic> map) {
    return AccountData(
      userId: map['userId'] as String,
    );
  }

//</editor-fold>
}