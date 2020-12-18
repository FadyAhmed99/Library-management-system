class User {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String profilePhoto;
  final String username;
  String token;

  User(
      {this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.profilePhoto,
      this.username,
      this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      username: json['username'] ?? '',
      token: json['token'] ?? '',
    );
  }
}
