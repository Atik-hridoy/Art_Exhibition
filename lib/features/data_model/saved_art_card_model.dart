class SavedArtCardModel {
  final String id;
  final String image; // keep single image string
  final String title;
  final String? category;
  final num? price;
  bool isOnFavorite;

  SavedArtCardModel({
    required this.id,
    required this.image,
    required this.title,
    this.category,
    this.price,
    required this.isOnFavorite,
  });

  factory SavedArtCardModel.fromJson(Map<String, dynamic> json) {
    // Extract the nested "item" object safely
    final item = json['item'] ?? {};
    final images = item['images'];

    // Extract first image if exists
    String imagePath = '';
    if (images is List && images.isNotEmpty) {
      imagePath = images.first ?? '';
    }

    return SavedArtCardModel(
      id: item['_id'] ?? json['_id'] ?? '',
      image: imagePath,
      title: item['title'] ?? '',
      category: item['category'],
      price: item['price'],
      // JSON doesn’t include "isOnFavorite" — default to false
      isOnFavorite: json['isOnFavorite'] ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'image': image,
    'title': title,
    'category': category,
    'price': price,
    'isOnFavorite': isOnFavorite,
  };
}
