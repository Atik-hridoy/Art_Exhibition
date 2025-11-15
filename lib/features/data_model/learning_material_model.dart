class LearningMaterialModel {
  final String id;
  final String creatorId;
  final String title;
  final String description;
  final List<LearningTutorial> tutorials;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String image;
  final bool isOnFavorite;

  const LearningMaterialModel({
    required this.id,
    required this.creatorId,
    required this.title,
    required this.description,
    required this.tutorials,
    required this.status,
    this.createdAt,
    this.updatedAt,
    this.image = '',
    this.isOnFavorite = false,
  });

  factory LearningMaterialModel.fromJson(Map<String, dynamic> json) {
    return LearningMaterialModel(
      id: json['_id']?.toString() ?? '',
      creatorId: json['creatorId']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      tutorials: (json['tutorials'] as List<dynamic>? ?? [])
          .map((e) => LearningTutorial.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status']?.toString() ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'].toString())
          : null,
      image: json['image']?.toString() ?? '',
      isOnFavorite: json['isOnFavorite'] as bool? ?? false,
    );
  }
}

class LearningTutorial {
  final String title;
  final String description;
  final String videoUrl;

  const LearningTutorial({
    required this.title,
    required this.description,
    required this.videoUrl,
  });

  factory LearningTutorial.fromJson(Map<String, dynamic> json) {
    return LearningTutorial(
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      videoUrl: json['videoUrl']?.toString() ?? '',
    );
  }
}
