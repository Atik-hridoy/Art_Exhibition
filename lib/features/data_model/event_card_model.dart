class EventCardModel {
  final String id;
  final String cover;
  final String title;
  final String date; // e.g. "01"
  final String month; // e.g. "Oct"
  final String venue;
  bool isOnFavorite;

  EventCardModel({
    required this.id,
    required this.cover,
    required this.title,
    required this.date,
    required this.month,
    required this.venue,
    required this.isOnFavorite,
  });

  factory EventCardModel.fromJson(Map<String, dynamic> json) {
    final startDate = DateTime.parse(json['startDate']);

    return EventCardModel(
      id: json['_id'] ?? '',
      cover: json['images'] != null && json['images'].isNotEmpty ? json['images'][0] : '',
      title: json['title'] ?? '',
      date: startDate.day.toString().padLeft(2, '0'),
      month: _getMonthAbbr(startDate.month),
      venue: json['venue'] ?? '',
      isOnFavorite: json['isOnFavorite'] ?? false,
    );
  }

  static String _getMonthAbbr(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}
