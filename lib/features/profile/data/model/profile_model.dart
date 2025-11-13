class ProfileResponse {
  final bool success;
  final String message;
  final ProfileData? data;

  ProfileResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? ProfileData.fromJson(json['data']) : null,
    );
  }
}

class ProfileData {
  final String id;
  final String name;
  final String role;
  final String email;
  final String profileImage;
  final String cover;
  final String status;

  ProfileData({
    required this.id,
    required this.name,
    required this.role,
    required this.email,
    required this.profileImage,
    required this.cover,
    required this.status,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      email: json['email'] ?? '',
      profileImage: json['profileImage'] ?? '',
      cover: json['cover'] ?? '',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'role': role,
      'email': email,
      'profileImage': profileImage,
      'cover': cover,
      'status': status,
    };
  }

  /// Get formatted role display text
  String get formattedRole {
    switch (role.toUpperCase()) {
      case 'ARTIST':
        return 'Artist';
      case 'COLLECTOR':
        return 'Collector';
      case 'CURATOR':
        return 'Curator';
      case 'GALLERY':
        return 'Gallery Owner';
      default:
        return 'Member';
    }
  }

  /// Check if profile image is available
  bool get hasProfileImage {
    return profileImage.isNotEmpty;
  }

  /// Check if cover image is available
  bool get hasCoverImage {
    return cover.isNotEmpty;
  }
}
