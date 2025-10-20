// --- Embedded Exhibition Item ---
class SavedExibitionCardModel {
  final String? id;
  final String? title;
  final String? image;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? venue;
  bool? isOnFavorite;

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
    if (json["item"]["images"] != null &&
        json["item"]["images"] is List &&
        json["item"]["images"].isNotEmpty) {
      firstImage = json["item"]["images"][0];
    }

    return SavedExibitionCardModel(
      id: json["item"]["_id"],
      title: json["item"]["title"],
      image: firstImage,
      startDate: json["item"]["startDate"] == null
          ? null
          : DateTime.parse(json["item"]["startDate"]),
      endDate: json["item"]["endDate"] == null
          ? null
          : DateTime.parse(json["item"]["endDate"]),
      venue: json["item"]["venue"],
      isOnFavorite: true, // since it’s inside favorites
    );
  }
}
