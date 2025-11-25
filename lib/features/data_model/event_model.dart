class EventModel {
  final String? id;
  final String? creatorName;
  final String? creatorId; // Add creatorId field
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
    this.creatorId,
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

  factory EventModel.fromJson(Map<String, dynamic> json) {
  try {
    // Handle creatorId - it can be a string (from my-events) or an object (from event details)
    String? creatorName;
    String? creatorId;
    
    if (json["creatorId"] is Map) {
      // Event details API response - creatorId is an object with name
      creatorId = json["creatorId"]["_id"]?.toString();
      creatorName = json["creatorId"]["name"]?.toString();
    } else {
      // My events API response - creatorId is a string
      creatorId = json["creatorId"]?.toString();
      creatorName = json["creatorName"]?.toString() ?? json["creatorId"]?.toString();
    }
    
    return EventModel(
      id: json["_id"]?.toString(),
      creatorName: creatorName,
      creatorId: creatorId,
      title: json["title"]?.toString(),
      description: json["description"]?.toString(),
      overview: json["overview"]?.toString(),
      startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"].toString()),
      endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"].toString()),
      visitingHour: json["visitingHour"]?.toString(),
      venue: json["venue"]?.toString(),
      images: json["images"] == null ? [] : List<String>.from((json["images"] as List).map((x) => x.toString())),
      ticketPrice: json["ticketPrice"] is int ? json["ticketPrice"] : int.tryParse(json["ticketPrice"]?.toString() ?? ""),
      bookingUrl: json["bookingUrl"]?.toString(),
      status: json["status"]?.toString(),
      isOnFavorite: json["isOnFavorite"] is bool ? json["isOnFavorite"] : null,
    );
  } catch (e) {
    print('Error parsing EventModel: $e');
    print('JSON data: $json');
    rethrow;
  }
}
}
