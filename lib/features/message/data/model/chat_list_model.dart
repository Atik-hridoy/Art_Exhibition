class ChatModel {
  final String id;
  final Participant participant;

  final LatestMessage latestMessage;

  ChatModel({
    required this.id,
    required this.participant,
    required this.latestMessage,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['_id'] ?? json['id'] ?? '',
      participant: Participant.fromJson(json['participant'] ?? {}),
      latestMessage: LatestMessage.fromJson(json['latestMessage'] ?? json['lastMessage'] ?? {}),
    );
  }
}

class Participant {
  final String id;
  final String fullName;
  final String image;

  Participant({required this.id, required this.fullName, required this.image});

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['_id'] ?? json['id'] ?? '',
      fullName: json['fullName'] ?? json['name'] ?? '',
      image: json['image'] ?? json['profileImage'] ?? '',
    );
  }
}

class LatestMessage {
  final String id;
  final String message;
  final DateTime createdAt;

  LatestMessage({
    required this.id,
    required this.message,
    required this.createdAt,
  });

  factory LatestMessage.fromJson(Map<String, dynamic> json) {
    return LatestMessage(
      id: json['_id'] ?? json['id'] ?? '',
      message: json['message'] ?? json['text'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? json['updatedAt'] ?? '') ??
          DateTime.now(),
    );
  }
}
