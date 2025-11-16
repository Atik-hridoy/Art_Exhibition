class LearningMaterialModel {
  final String id;
  final String creatorId;
  final CreatorInfo? creator;
  final String title;
  final String description;
  final List<LearningTutorial> tutorials;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String image;
  bool isOnFavorite;

  LearningMaterialModel({
    required this.id,
    required this.creatorId,
    this.creator,
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
    final creatorData = json['creatorId'];
    CreatorInfo? creator;
    String parsedCreatorId = '';

    if (creatorData is Map<String, dynamic>) {
      creator = CreatorInfo.fromJson(creatorData);
      parsedCreatorId = creator.id;
    } else {
      parsedCreatorId = creatorData?.toString() ?? '';
    }

    return LearningMaterialModel(
      id: json['_id']?.toString() ?? '',
      creatorId: parsedCreatorId,
      creator: creator,
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

class CreatorInfo {
  final String id;
  final String name;
  final String email;
  final String profileImage;
  final String about;

  const CreatorInfo({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.about,
  });

  factory CreatorInfo.fromJson(Map<String, dynamic> json) {
    return CreatorInfo(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      profileImage: json['profileImage']?.toString() ?? '',
      about: json['about']?.toString() ?? '',
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
