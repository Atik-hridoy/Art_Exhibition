class SavedLearningCardModel {
  final String id;
  final String title;
  final String description;
  final String image;
  bool isOnFavorite;

  SavedLearningCardModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.isOnFavorite,
  });

  factory SavedLearningCardModel.fromJson(Map<String, dynamic> json) {
    final item = json['item'] as Map<String, dynamic>? ?? {};
    return SavedLearningCardModel(
      id: item['_id']?.toString() ?? '',
      title: item['title']?.toString() ?? '',
      description: item['description']?.toString() ?? '',
      image: item['image']?.toString() ?? '',
      isOnFavorite: json['isOnFavorite'] as bool? ?? true,
    );
  }
}
