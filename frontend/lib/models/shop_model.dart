/// Generic Backend-Ready Shop Model for QUCZO Nearby Shops
class ShopModel {
  final String id;
  final String name;
  final String category;
  final double distanceKm;
  final double rating;
  final int itemCount;
  final bool isOpen;
  final String imageUrl;

  const ShopModel({
    required this.id,
    required this.name,
    required this.category,
    required this.distanceKm,
    required this.rating,
    required this.itemCount,
    required this.isOpen,
    required this.imageUrl,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      id: json['id'] as String? ?? '',
      name: (json['name'] ?? json['business_name']) as String? ?? '',
      category:
          (json['category'] ?? json['business_category']) as String? ?? '',
      distanceKm: (json['distanceKm'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      itemCount: (json['itemCount'] as num?)?.toInt() ?? 0,
      isOpen: json['isOpen'] as bool? ?? true,
      imageUrl:
          (json['image_url'] ??
                  json['imageUrl'] ??
                  json['logo_url'] ??
                  json['logo'])
              as String? ??
          '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'category': category,
    'distanceKm': distanceKm,
    'rating': rating,
    'itemCount': itemCount,
    'isOpen': isOpen,
    'imageUrl': imageUrl,
  };
}
