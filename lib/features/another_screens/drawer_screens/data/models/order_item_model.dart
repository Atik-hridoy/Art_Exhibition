class OrderItemModel {
  final String id;
  final String title;
  final String price;
  final String image;
  final String status;

  const OrderItemModel({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.status,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    final art = json['art'] as Map<String, dynamic>?;
    final artId = json['artId'] as Map<String, dynamic>?;

    String _firstNonEmpty(List<dynamic> values, {String fallback = ''}) {
      for (final value in values) {
        if (value == null) continue;
        if (value is String && value.trim().isNotEmpty) {
          return value.trim();
        }
        final text = value.toString().trim();
        if (text.isNotEmpty && text != 'null') return text;
      }
      return fallback;
    }

    String _formatPrice(dynamic value) {
      if (value == null) return '0';
      if (value is num) {
        final isInt = value.truncateToDouble() == value;
        return isInt ? value.toStringAsFixed(0) : value.toStringAsFixed(2);
      }
      return value.toString();
    }

    return OrderItemModel(
      id: _firstNonEmpty([
        json['id'],
        json['_id'],
        art?['id'],
        artId?['id'],
        artId?['_id'],
      ]),
      title: _firstNonEmpty([
        json['title'],
        json['Title'],
        json['artTitle'],
        json['name'],
        art?['title'],
        art?['Title'],
        art?['name'],
        artId?['title'],
        artId?['name'],
      ], fallback: 'Untitled'),
      price: _formatPrice(
        json['price'] ??
            art?['price'] ??
            json['totalPrice'] ??
            art?['amount'] ??
            artId?['price'] ??
            artId?['amount'],
      ),
      image: _firstNonEmpty([
        json['image'],
        json['imageUrl'],
        json['thumbnail'],
        art?['coverImage'],
        art?['image'],
        art?['thumbnail'],
        artId?['image'],
        artId?['coverImage'],
      ]),
      status: _firstNonEmpty([
        json['status'],
        json['orderStatus'],
        json['state'],
        artId?['status'],
      ], fallback: 'Pending'),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'image': image,
        'status': status,
      };
}
