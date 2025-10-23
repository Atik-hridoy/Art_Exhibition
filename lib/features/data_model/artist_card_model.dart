class ArtistCardModel {
  final String id;
  final String name;
  final String role;
  final String? profileImage;
  final int followers;

  ArtistCardModel({
    required this.id,
    required this.name,
    required this.role,
    this.profileImage,
    required this.followers,
  });

  factory ArtistCardModel.fromJson(Map<String, dynamic> json) {
    return ArtistCardModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      profileImage: json['profileImage'],
      followers: json['followers'] ?? 0,
    );
  }
}
