class FeaturesArtCardModel {
  final String id;
  final Artist? artist;
  final String image;
  final String title;
  final String? category;
  final num? price;
  final bool isOnFavorite;

  FeaturesArtCardModel({
    required this.id,
    this.artist,
    required this.image,
    required this.title,
    this.category,
    this.price,
    required this.isOnFavorite,
  });

  factory FeaturesArtCardModel.fromJson(Map<String, dynamic> json) =>
      FeaturesArtCardModel(
        id: json['_id'] ?? '',
        artist: json['artist'] != null ? Artist.fromJson(json['artist']) : null,
        image: json['image'] ?? '',
        title: json['title'] ?? '',
        category: json['category'],
        price: json['price'],
        isOnFavorite: json['isOnFavorite'] ?? false,
      );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'artist': artist?.toJson(),
    'image': image,
    'title': title,
    'category': category,
    'price': price,
    'isOnFavorite': isOnFavorite,
  };
}

class Artist {
  final String id;
  final String? name;
  final String? role;
  final String? profileImage;

  Artist({required this.id, this.name, this.role, this.profileImage});

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
    id: json['_id'] ?? '',
    name: json['name'],
    role: json['role'],
    profileImage: json['profileImage'],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'role': role,
    'profileImage': profileImage,
  };
}
