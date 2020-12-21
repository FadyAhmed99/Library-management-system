class User {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String profilePhoto;
  final String username;
  final String facebookId;
  final bool librarian;
  final bool canBorrowItems;
  final bool canEvaluateItems;

  final List<Map<String, bool>> subscribedLibraries;
  final List<Map<String, String>> favorites;

  String token;

  User(
      {this.facebookId,
      this.librarian,
      this.canBorrowItems,
      this.canEvaluateItems,
      this.subscribedLibraries,
      this.favorites,
      this.firstName,
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
        profilePhoto: json['profilePhoto'] ?? '',
        canBorrowItems: json['canBorrowItems'] ?? false,
        canEvaluateItems: json['canEvaluateItems'] ?? false,
        facebookId: json['facebookId'] ?? '',
        favorites: json['favorites'] ?? [],
        librarian: json['librarian'] ?? false,
        subscribedLibraries: json['subscribedLibraries'] ?? []);
  }
}
