class ArtistDetailsModel {
  final String id;
  final String name;
  final String email;
  final String profileImage;
  final String cover;
  final int followers;
  final String role;
  final bool verified;
  final String status;
  final String about;
  final String keyAchievements;
  final bool isFollowing;
  final List<ArtistArtItem> arts;
  final List<ArtistExhibitionItem> exhibitions;
  final List<ArtistEventItem> events;

  ArtistDetailsModel({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.cover,
    required this.followers,
    required this.role,
    required this.verified,
    required this.status,
    required this.about,
    required this.keyAchievements,
    required this.isFollowing,
    required this.arts,
    required this.exhibitions,
    required this.events,
  });

  factory ArtistDetailsModel.fromJson(Map<String, dynamic> json) {
    return ArtistDetailsModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      profileImage: json['profileImage'] ?? '',
      cover: json['cover'] ?? '',
      followers: json['followers'] ?? 0,
      role: json['role'] ?? 'ARTIST',
      verified: json['verified'] ?? false,
      status: json['status'] ?? '',
      about: json['about'] ?? '',
      keyAchievements: json['keyAchivements'] ?? '',
      isFollowing: json['isFollowing'] ?? false,
      arts: (json['arts'] as List<dynamic>? ?? [])
          .map((e) => ArtistArtItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      exhibitions: (json['exhibitions'] as List<dynamic>? ?? [])
          .map((e) => ArtistExhibitionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      events: (json['events'] as List<dynamic>? ?? [])
          .map((e) => ArtistEventItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ArtistArtItem {
  final String id;
  final String title;
  final String image;
  final num price;

  ArtistArtItem({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
  });

  factory ArtistArtItem.fromJson(Map<String, dynamic> json) {
    return ArtistArtItem(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      price: json['price'] ?? 0,
    );
  }
}

class ArtistExhibitionItem {
  final String id;
  final String title;
  final List<String> images;
  final String startDate;
  final String endDate;
  final String visitingHour;
  final String venue;
  final String status;
  final num ticketPrice;

  ArtistExhibitionItem({
    required this.id,
    required this.title,
    required this.images,
    required this.startDate,
    required this.endDate,
    required this.visitingHour,
    required this.venue,
    required this.status,
    required this.ticketPrice,
  });

  factory ArtistExhibitionItem.fromJson(Map<String, dynamic> json) {
    return ArtistExhibitionItem(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      images: (json['images'] as List<dynamic>? ?? []).cast<String>(),
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      visitingHour: json['visitingHour'] ?? '',
      venue: json['venue'] ?? '',
      status: json['status'] ?? '',
      ticketPrice: json['ticketPrice'] ?? 0,
    );
  }
}

class ArtistEventItem {
  final String id;
  final String title;
  final String description;
  final String startDate;
  final String endDate;
  final String visitingHour;
  final String venue;
  final List<String> images;
  final num ticketPrice;

  ArtistEventItem({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.visitingHour,
    required this.venue,
    required this.images,
    required this.ticketPrice,
  });

  factory ArtistEventItem.fromJson(Map<String, dynamic> json) {
    return ArtistEventItem(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      visitingHour: json['visitingHour'] ?? '',
      venue: json['venue'] ?? '',
      images: (json['images'] as List<dynamic>? ?? []).cast<String>(),
      ticketPrice: json['ticketPrice'] ?? 0,
    );
  }
}
