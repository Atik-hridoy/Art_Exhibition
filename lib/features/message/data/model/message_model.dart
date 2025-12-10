class Sender {
  final String id;
  final String fullName;
  final String image;

  Sender({
    required this.id,
    required this.fullName,
    required this.image,
  });

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      id: json['_id']  ?? '',
      fullName: json['fullName']  ?? '',
      image: json['image']  ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullName': fullName,
      'image': image,
    };
  }
}

class MessageModel {
  final String id;
  final String chat;
  final String message;
  final String type;
  final Sender sender;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;
  final List<String> images;

  MessageModel({
    required this.id,
    required this.chat,
    required this.message,
    required this.type,
    required this.sender,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    this.images = const [],
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    List<String> imagesList = [];
    if (json['images'] != null) {
      if (json['images'] is List) {
        imagesList = (json['images'] as List).map((e) => e.toString()).toList();
      } else if (json['images'] is String) {
        imagesList = [json['images']];
      }
    }

    return MessageModel(
      id: json['_id'] ?? '',
      chat: json['chat'] ?? '',
      message: json['message'] ?? json['text'] ?? '',
      type: json['type'] as String? ?? 'general',
      sender: Sender.fromJson(json['sender'] ?? {}),
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt:
          DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      version: json['__v'] ?? 0,
      images: imagesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'chat': chat,
      'message': message,
      'type': type,
      'sender': sender.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
      'images': images,
    };
  }
}
