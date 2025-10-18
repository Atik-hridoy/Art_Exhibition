class ArtsResponse {
  final bool success;
  final String? message;
  final Pagination? pagination;
  final List<ArtDetails> data;

  ArtsResponse({
    required this.success,
    this.message,
    this.pagination,
    required this.data,
  });

  factory ArtsResponse.fromJson(Map<String, dynamic> json) {
    return ArtsResponse(
      success: json['success'] == true,
      message: json['message'] as String?,
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => ArtDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Pagination {
  final int total;
  final int limit;
  final int page;
  final int totalPage;

  Pagination({
    required this.total,
    required this.limit,
    required this.page,
    required this.totalPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      total: (json['total'] ?? 0) as int,
      limit: (json['limit'] ?? 0) as int,
      page: (json['page'] ?? 0) as int,
      totalPage: (json['totalPage'] ?? 0) as int,
    );
  }
}

class ArtDetails {
  final String id;
  final Artist? artist;
  final List<String> images; // all images (new addition)
  final String? seller;
  final String title;
  final String? category;
  final num? price;
  final String? description;
  final Dimensions? dimensions;
  final String? authentication;
  final String? status;
  final bool sold;
  final bool acceptOffer;
  final bool sendOffer;
  final bool isOnFavorite;
  final bool? resale;
  final ResaleInfo? resaleInfo;
  final String? collector;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ArtDetails({
    required this.id,
    this.artist,
    required this.images,
    this.seller,
    required this.title,
    this.category,
    this.price,
    this.description,
    this.dimensions,
    this.authentication,
    this.status,
    required this.sold,
    required this.acceptOffer,
    required this.sendOffer,
    required this.isOnFavorite,
    this.resale,
    this.resaleInfo,
    this.collector,
    this.createdAt,
    this.updatedAt,
  });

  factory ArtDetails.fromJson(Map<String, dynamic> json) {
    // Parse images safely
    // List<String> parsedImages = [];
    // if (json['images'] is List) {
    //   parsedImages = (json['images'] as List)
    //       .where((e) => e != null)
    //       .map((e) => e.toString())
    //       .toList();
    // } else if (json['image'] is String) {
    //   parsedImages = [json['image']];
    // }

    return ArtDetails(
      id: (json['_id'] ?? '') as String,
      artist: json['artist'] == null
          ? null
          : Artist.fromJson(json['artist'] as Map<String, dynamic>),
      images: (json['images'] is List)
          ? (json['images'] as List)
                .where((e) => e != null)
                .map((e) => e.toString())
                .toList()
          : [],
      seller: json['seller'] as String?,
      title: (json['title'] ?? '') as String,
      category: json['category'] as String?,
      price: json['price'] as num?,
      description: json['description'] as String?,
      dimensions: json['daimentions'] == null
          ? null
          : Dimensions.fromJson(json['daimentions'] as Map<String, dynamic>),

      authentication: json['authentication'] as String?,
      status: json['status'] as String?,
      sold: json['sold'] == true,
      acceptOffer: json['acceptOffer'] == true,
      sendOffer: json['sendOffer'] == true,
      isOnFavorite: json['isOnFavorite'] == true,
      resale: json['resale'] as bool?,
      resaleInfo: json['resaleInfo'] == null
          ? null
          : ResaleInfo.fromJson(json['resaleInfo'] as Map<String, dynamic>),
      collector: json['collector'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'] as String)
          : null,
    );
  }
}

class Artist {
  final String id;
  final String? name;
  final String? role;
  final String? profileImage;

  Artist({required this.id, this.name, this.role, this.profileImage});

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
    id: (json['_id'] ?? '') as String,
    name: json['name'] as String?,
    role: json['role'] as String?,
    profileImage: json['profileImage'] as String?,
  );
}

class Dimensions {
  final double? height;
  final double? width;

  Dimensions({this.height, this.width});

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
    height: json['height'] != null
        ? (json['height'] is num
              ? (json['height'] as num).toDouble()
              : double.tryParse(json['height'].toString()))
        : null,
    width: json['width'] != null
        ? (json['width'] is num
              ? (json['width'] as num).toDouble()
              : double.tryParse(json['width'].toString()))
        : null,
  );
}

class ResaleInfo {
  final String? id;
  final String? condition;
  final String? additionalInfo;
  final DateTime? prevPurchase;
  final num? originalPrice;
  final String? resalerId;

  ResaleInfo({
    this.id,
    this.condition,
    this.additionalInfo,
    this.prevPurchase,
    this.originalPrice,
    this.resalerId,
  });

  factory ResaleInfo.fromJson(Map<String, dynamic> json) => ResaleInfo(
    id: json['_id'] as String?,
    condition: json['condition'] as String?,
    additionalInfo: json['additionalInfo'] as String?,
    prevPurchase: json['prevPurchase'] != null
        ? DateTime.tryParse(json['prevPurchase'] as String)
        : null,
    originalPrice: json['originalPrice'] as num?,
    resalerId: json['resalerId'] as String?,
  );
}
