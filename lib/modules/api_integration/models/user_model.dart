class UserModel {
  const UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    this.age,
    this.isDeleted = false,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final int? age;
  final bool isDeleted;

  String get fullName => '$firstName $lastName'.trim();

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] is String
          ? int.tryParse(json['id'] as String) ?? 0
          : (json['id'] as num?)?.toInt() ?? 0,
      firstName: json['firstName']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      age: (json['age'] as num?)?.toInt(),
      isDeleted: json['isDeleted'] == true,
    );
  }

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        if (email.isNotEmpty) 'email': email,
        if (username.isNotEmpty) 'username': username,
        if (age != null) 'age': age,
      };
}
