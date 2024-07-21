class User {
  final String id;
  final String nickname;
  final String username;
  final String imageUrl;

  const User({
    required this.id,
    required this.nickname,
    required this.username,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nickname': nickname,
      'username': username,
      'imageUrl': imageUrl,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      nickname: map['nickname'] as String,
      username: map['username'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }
}