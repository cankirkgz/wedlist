class UserModel {
  final String email;
  final String name;
  final DateTime createdAt;

  UserModel({
    required this.email,
    required this.name,
    required this.createdAt,
  });

  // JSON'dan UserModel oluşturmak için
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] as String,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  // UserModel'i JSON'a çevirmek için
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
