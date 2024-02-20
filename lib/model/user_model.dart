class UserModel {
  final int id;
  final String email;
  final String firstname;
  final String lastname;
  final String avatar;
  final int favorite;

  UserModel({
    required this.id,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.avatar,
    required this.favorite,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      email: json["email"],
      firstname: json["first_name"],
      lastname: json["last_name"],
      avatar: json["avatar"],
      favorite: 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "email": email,
      "first_name": firstname,
      "last_name": lastname,
      "avatar": avatar,
      "favourite": favorite,
    };
  }
}
