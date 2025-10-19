class Exhibition {
  final String? id;
  final CreatorId? creatorId;
  final String? title;
  final String? description;
  final int? ticketPrice;
  final List<String>? images;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? visitingHour;
  final String? venue;
  final String? field;
  final String? bookingUrl;
  final List<Artist>? artists;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? isOnFavorite;

  Exhibition({
    this.id,
    this.creatorId,
    this.title,
    this.description,
    this.ticketPrice,
    this.images,
    this.startDate,
    this.endDate,
    this.visitingHour,
    this.venue,
    this.field,
    this.bookingUrl,
    this.artists,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.isOnFavorite,
  });

  factory Exhibition.fromJson(Map<String, dynamic> json) => Exhibition(
    id: json["_id"],
    creatorId: json["creatorId"] == null ? null : CreatorId.fromJson(json["creatorId"]),
    title: json["title"],
    description: json["description"],
    ticketPrice: json["ticketPrice"],
    images: json["images"] == null ? [] : List<String>.from(json["images"].map((x) => x)),
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
    visitingHour: json["visitingHour"],
    venue: json["venue"],
    field: json["field"],
    bookingUrl: json["bookingUrl"],
    artists: json["artists"] == null
        ? []
        : List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
    status: json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    isOnFavorite: json["isOnFavorite"],
  );
}

class CreatorId {
  final String? id;
  final String? name;
  final String? role;
  final String? profileImage;

  CreatorId({this.id, this.name, this.role, this.profileImage});

  factory CreatorId.fromJson(Map<String, dynamic> json) => CreatorId(
    id: json["_id"],
    name: json["name"],
    role: json["role"],
    profileImage: json["profileImage"],
  );
}

class Artist {
  final String? id;
  final String? name;
  final String? profileImage;
  final int? followers;
  final String? role;

  Artist({this.id, this.name, this.profileImage, this.followers, this.role});

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
    id: json["_id"],
    name: json["name"],
    profileImage: json["profileImage"],
    followers: json["followers"],
    role: json["role"],
  );
}
