class SavedEventCardModel {
  final String id;
  final String cover;
  final String title;
  final String date; // e.g. "01"
  final String month; // e.g. "Oct"
  final String venue;
  bool isOnFavorite;

  SavedEventCardModel({
    required this.id,
    required this.cover,
    required this.title,
    required this.date,
    required this.month,
    required this.venue,
    required this.isOnFavorite,
  });

  /// Factory for normal event JSON
  factory SavedEventCardModel.fromJson(Map<String, dynamic> json) {
    final startDate = DateTime.parse(json["item"]['startDate']);
    return SavedEventCardModel(
      id: json["item"]['_id'] ?? '',
      cover: json["item"]['images'] != null && json["item"]['images'].isNotEmpty
          ? json["item"]['images'][0]
          : '',
      title: json["item"]['title'] ?? '',
      date: startDate.day.toString().padLeft(2, '0'),
      month: _getMonthAbbr(startDate.month),
      venue: json["item"]['venue'] ?? '',
      isOnFavorite: true,
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
