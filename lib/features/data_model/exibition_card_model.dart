class ExhibitionCardModel {
  final String? id;
  final String? title;
  final String? image; // only the first image
  final DateTime? startDate;
  final DateTime? endDate;
  final String? venue;
  final bool? isOnFavorite;

  ExhibitionCardModel({
    this.id,
    this.title,
    this.image,
    this.startDate,
    this.endDate,
    this.venue,
    this.isOnFavorite,
  });

  factory ExhibitionCardModel.fromJson(Map<String, dynamic> json) {
    // extract the first image if available
    String? firstImage;
    if (json["images"] != null && json["images"] is List && json["images"].isNotEmpty) {
      firstImage = json["images"][0];
    }

    return ExhibitionCardModel(
      id: json["_id"],
      title: json["title"],
      image: firstImage,
      startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
      endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
      venue: json["venue"],
      isOnFavorite: json["isOnFavorite"],
    );
  }
}
