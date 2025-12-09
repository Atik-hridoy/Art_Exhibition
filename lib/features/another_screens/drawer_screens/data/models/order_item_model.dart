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
    // artId can be either a Map (art object) or String (art ID)
    final artId = json['artId'];
    Map<String, dynamic>? artIdMap;
    if (artId is Map<String, dynamic>) {
      artIdMap = artId;
    }

    String firstNonEmpty(List<dynamic> values, {String fallback = ''}) {
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

    String formatPrice(dynamic value) {
      if (value == null) return '0';
      if (value is num) {
        final isInt = value.truncateToDouble() == value;
        return isInt ? value.toStringAsFixed(0) : value.toStringAsFixed(2);
      }
      return value.toString();
    }

    // Handle different image structures from API
    String? imageUrl;
    final images = art?['images'];
    if (images != null && images is List && images.isNotEmpty) {
      // Use first image from images array
      imageUrl = firstNonEmpty([images[0]]);
    } else {
      // Fallback to single image fields
      imageUrl = firstNonEmpty([
        json['image'],
        json['imageUrl'],
        json['thumbnail'],
        json['artImage'],  // Handle artImage as direct string field
        art?['coverImage'],
        art?['image'],
        art?['thumbnail'],
        artIdMap?['image'],
        artIdMap?['coverImage'],
      ]);
    }

    // Temporarily return the raw image URL without building full URL
    // to isolate any import/API endpoint issues
    String finalImageUrl = imageUrl;

    return OrderItemModel(
      id: firstNonEmpty([
        json['id'],
        json['_id'],
        art?['id'],
        artIdMap?['id'],
        artIdMap?['_id'],
      ]),
      title: firstNonEmpty([
        json['title'],
        json['Title'],
        json['artTitle'],
        json['name'],
        art?['title'],
        art?['Title'],
        art?['name'],
        artIdMap?['title'],
        artIdMap?['name'],
      ], fallback: 'Untitled'),
      price: formatPrice(
        json['price'] ??
            json['priceOffer'] ??
            art?['price'] ??
            json['totalPrice'] ??
            art?['amount'] ??
            artIdMap?['price'] ??
            artIdMap?['amount'],
      ),
      image: finalImageUrl,
      status: firstNonEmpty([
        json['status'],
        json['orderStatus'],
        json['state'],
        artIdMap?['status'],
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
