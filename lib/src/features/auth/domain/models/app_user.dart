class AppUser {
  const AppUser({
    required this.id,
    required this.phone,
    this.email,
    this.name,
  });
  final int id;
  final String phone;
  final String? email;
  final String? name;

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        id: json['id'] as int,
        phone: json['phone'] as String,
        email: json['email'] as String?,
        name: json['name'] as String?,
      );
}
