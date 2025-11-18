class LearningMaterialModel {
  final String id;
  final String creatorId;
  final CreatorInfo? creator;
  final String title;
  final String overview;
  final String learningObject;
  final List<LearningTutorial> lessons;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String thumbnail;
  final String totalDuration;
  final int totalLessons;
  bool isOnFavorite;

  LearningMaterialModel({
    required this.id,
    required this.creatorId,
    this.creator,
    required this.title,
    required this.overview,
    required this.learningObject,
    required this.lessons,
    required this.status,
    this.createdAt,
    this.updatedAt,
    this.thumbnail = '',
    this.totalDuration = '',
    this.totalLessons = 0,
    this.isOnFavorite = false,
  });
 
  String get displayThumbnail {
    if (lessons.isNotEmpty && lessons.first.thumbnail.isNotEmpty) {
      return lessons.first.thumbnail;
    }
    if (thumbnail.isNotEmpty) return thumbnail;
    return '';
  }

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

    final lessonsJson = (json['lessons'] as List<dynamic>? ?? json['tutorials'] as List<dynamic>? ?? []);
    final parsedLessons = lessonsJson
        .map((e) => LearningTutorial.fromJson(e as Map<String, dynamic>))
        .toList();

    return LearningMaterialModel(
      id: json['_id']?.toString() ?? '',
      creatorId: parsedCreatorId,
      creator: creator,
      title: json['title']?.toString() ?? '',
      overview: json['overview']?.toString() ?? json['description']?.toString() ?? '',
      learningObject: json['learningObject']?.toString() ?? '',
      lessons: parsedLessons,
      status: json['status']?.toString() ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'].toString())
          : null,
      thumbnail: json['thumbnail']?.toString() ?? json['image']?.toString() ?? '',
      totalDuration: json['totalDuration']?.toString() ?? '',
      totalLessons: (json['totalLessons'] as num?)?.toInt() ?? parsedLessons.length,
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
  final String id;
  final String title;
  final String description;
  final String videoUrl;
  final String thumbnail;
  final String duration;

  const LearningTutorial({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    this.thumbnail = '',
    this.duration = '',
  });

  factory LearningTutorial.fromJson(Map<String, dynamic> json) {
    return LearningTutorial(
      id: json['_id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      videoUrl: json['videoUrl']?.toString() ?? '',
      thumbnail: json['thumbnail']?.toString() ?? '',
      duration: json['duration']?.toString() ?? '',
    );
  }
}
