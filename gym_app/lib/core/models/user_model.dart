class User {
  final String id;
  final String name;
  final String email;
  final String? profileImage;
  final String? bio;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.profileImage,
    this.bio,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      profileImage: json['profileImage'],
      bio: json['bio'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'profileImage': profileImage,
    'bio': bio,
  };

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? profileImage,
    String? bio,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      bio: bio ?? this.bio,
    );
  }
}
