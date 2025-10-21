class CollectionData {
  final String id;
  final String artist;
  final int v;
  final List<MyArtListing> arts;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CollectionData({
    this.id = '',
    this.artist = '',
    this.v = 0,
    this.arts = const [],
    this.createdAt,
    this.updatedAt,
  });

  factory CollectionData.fromJson(Map<String, dynamic> json) {
    return CollectionData(
      id: json['_id'] ?? '',
      artist: json['artist'] ?? '',
      v: json['__v'] ?? 0,
      arts: (json['arts'] as List?)?.map((e) => MyArtListing.fromJson(e)).toList() ?? [],
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
    );
  }
}

class MyArtListing {
  final String id;
  final String image;
  final String title;
  final String category;
  final int price;
  final String status;
  final bool sold;

  MyArtListing({
    this.id = '',
    this.image = '',
    this.title = '',
    this.category = '',
    this.price = 0,
    this.status = '',
    this.sold = false,
  });

  factory MyArtListing.fromJson(Map<String, dynamic> json) {
    return MyArtListing(
      id: json['_id'] ?? '',
      image: json['image'] ?? '',
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      price: json['price'] ?? 0,
      status: json['status'] ?? '',
      sold: json['sold'] ?? false,
    );
  }
}
