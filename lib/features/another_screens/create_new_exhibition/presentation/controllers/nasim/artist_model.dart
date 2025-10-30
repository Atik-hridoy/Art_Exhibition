class ArtistModel {
  final String id;
  final String name;
  final String role;
  final String? profileImage;
  final int followers;

  ArtistModel({
    required this.id,
    required this.name,
    required this.role,
    this.profileImage,
    required this.followers,
  });

  // From API response
  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    return ArtistModel(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? 'ARTIST',
      profileImage: json['profileImage'],
      followers: json['followers'] ?? 0,
    );
  }

  // To API request
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'role': role,
      'profileImage': profileImage ?? '',
      'followers': followers,
    };
  }

  // For display in UI
  String get followersText => '$followers Followers';
}
