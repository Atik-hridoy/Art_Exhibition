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

class ShippingAddress {
  final String name;
  final String phone;
  final String address;

  ShippingAddress({
    required this.name,
    required this.phone,
    required this.address,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
    };
  }
}

class ProfileData {
  final String id;
  final String name;
  final String role;
  final String email;
  final String profileImage;
  final String cover;
  final int followers;
  final String status;
  final bool verified;
  final String createdAt;
  final String updatedAt;
  final ShippingAddress? shippingAddress;

  ProfileData({
    required this.id,
    required this.name,
    required this.role,
    required this.email,
    required this.profileImage,
    required this.cover,
    required this.followers,
    required this.status,
    required this.verified,
    required this.createdAt,
    required this.updatedAt,
    this.shippingAddress,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      email: json['email'] ?? '',
      profileImage: json['profileImage'] ?? '',
      cover: json['cover'] ?? '',
      followers: json['followers'] ?? 0,
      status: json['status'] ?? '',
      verified: json['verified'] ?? false,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      shippingAddress: json['shippingAddress'] != null 
          ? ShippingAddress.fromJson(json['shippingAddress'] as Map<String, dynamic>) 
          : null,
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
      'followers': followers,
      'status': status,
      'verified': verified,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'shippingAddress': shippingAddress?.toJson(),
    };
  }

  /// Create update payload for PATCH request
  Map<String, dynamic> toUpdateJson() {
    Map<String, dynamic> data = {
      'name': name,
    };

    if (shippingAddress != null) {
      data['shippingAddress'] = shippingAddress!.toJson();
    }

    return data;
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
    return profileImage.isNotEmpty && profileImage != "";
  }

  /// Check if cover image is available
  bool get hasCoverImage {
    return cover.isNotEmpty;
  }
}
