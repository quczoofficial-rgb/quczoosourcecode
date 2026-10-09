/// Generic Backend-Ready Product Model for QUCZO Hyperlocal Discovery
class ProductModel {
  final String id;
  final String name;
  final String description;
  final String brand;
  final String category;
  final double price;
  final double? bestPrice;
  final double distanceKm;
  final String availability; // 'In Stock', 'Limited Stock', 'Available Nearby'
  final String shopName;
  final double rating;
  final String imageUrl;
  final int stock;

  const ProductModel({
    required this.id,
    required this.name,
    this.description = '',
    required this.brand,
    required this.category,
    required this.price,
    this.bestPrice,
    required this.distanceKm,
    required this.availability,
    required this.shopName,
    required this.rating,
    required this.imageUrl,
    this.stock = 10,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      brand: json['brand'] as String? ?? '',
      category: json['category'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      bestPrice: (json['bestPrice'] as num?)?.toDouble() ?? (json['selling_price'] as num?)?.toDouble() ?? (json['sellingPrice'] as num?)?.toDouble() ?? (json['price'] as num?)?.toDouble(),
      distanceKm: (json['distanceKm'] as num?)?.toDouble() ?? 0.0,
      availability: json['availability'] as String? ?? 'In Stock',
      shopName: (json['shop'] != null && json['shop'] is Map) ? (json['shop']['name'] ?? '') : (json['shopName'] ?? json['shop_name'] ?? ''),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      imageUrl: (json['image_url'] ?? json['imageUrl'] ?? json['image']) as String? ?? '',
      stock: (json['stock'] as num?)?.toInt() ?? 10,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'brand': brand,
        'category': category,
        'price': price,
        'bestPrice': bestPrice,
        'distanceKm': distanceKm,
        'availability': availability,
        'shopName': shopName,
        'rating': rating,
        'imageUrl': imageUrl,
        'stock': stock,
      };
}
