class UserModel {
  final String id;
  final String email;
  final String? username;
  final String? img;

  UserModel({required this.id, required this.email, this.username, this.img});

  UserModel.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          email: json['email']! as String,
          username: json['username'] as String,
          img: json['img'] as String,
        );
}
