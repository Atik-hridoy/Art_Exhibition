// --- Embedded Exhibition Item ---
class SavedExibitionCardModel {
  final String? id;
  final String? title;
  final String? image;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? venue;
  final bool? isOnFavorite;

  SavedExibitionCardModel({
    this.id,
    this.title,
    this.image,
    this.startDate,
    this.endDate,
    this.venue,
    this.isOnFavorite,
  });

  factory SavedExibitionCardModel.fromJson(Map<String, dynamic> json) {
    String? firstImage;
    if (json["images"] != null && json["images"] is List && json["images"].isNotEmpty) {
      firstImage = json["images"][0];
    }

    return SavedExibitionCardModel(
      id: json["_id"],
      title: json["title"],
      image: firstImage,
      startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
      endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
      venue: json["venue"],
      isOnFavorite: true, // since it’s inside favorites
    );
  }
}
