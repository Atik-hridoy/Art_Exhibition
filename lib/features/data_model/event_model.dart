class EventModel {
  final String? id;
  final String? creatorName;
  final String? title;
  final String? description;
  final String? overview;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? visitingHour;
  final String? venue;
  final List<String>? images;
  final int? ticketPrice;
  final String? bookingUrl;
  final String? status;
  final bool? isOnFavorite;

  const EventModel({
    this.id,
    this.creatorName,
    this.title,
    this.description,
    this.overview,
    this.startDate,
    this.endDate,
    this.visitingHour,
    this.venue,
    this.images,
    this.ticketPrice,
    this.bookingUrl,
    this.status,
    this.isOnFavorite,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
    id: json["_id"],
    creatorName: json["creatorId"]?["name"],
    title: json["title"],
    description: json["description"],
    overview: json["overview"],
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
    visitingHour: json["visitingHour"],
    venue: json["venue"],
    images: json["images"] == null ? [] : List<String>.from(json["images"].map((x) => x)),
    ticketPrice: json["ticketPrice"],
    bookingUrl: json["bookingUrl"],
    status: json["status"],
    isOnFavorite: json["isOnFavorite"],
  );
}
