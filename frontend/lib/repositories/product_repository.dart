import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../core/config/api_config.dart';
import '../models/product_model.dart';

/// Product Repository for QUCZO Product Search, Category Filtering, Product Details & Price Comparison
class ProductRepository {
  /// Search products by query across nearby shops
  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      final uri = query.trim().isEmpty
          ? Uri.parse(ApiConfig.products)
          : Uri.parse('${ApiConfig.products}?q=${Uri.encodeComponent(query)}');
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        if (data['success'] == true && data['data'] != null) {
          return (data['data'] as List).map((json) {
            return ProductModel(
              id: json['id']?.toString() ?? '',
              name: json['name'] ?? '',
              description: json['description'] ?? '',
              brand: json['brand'] ?? 'Unknown',
              category: json['category'] ?? 'Uncategorized',
              price: (json['price'] as num?)?.toDouble() ?? 0.0,
              bestPrice:
                  (json['selling_price'] as num?)?.toDouble() ??
                  (json['sellingPrice'] as num?)?.toDouble() ??
                  (json['price'] as num?)?.toDouble() ??
                  0.0,
              distanceKm: 0.5,
              availability: json['stock'] != null && json['stock'] > 0
                  ? 'In Stock'
                  : 'Out of Stock',
              shopName: json['shop'] != null
                  ? json['shop']['name']
                  : (json['shop_name'] ?? json['shopName'] ?? 'Shop'),
              rating: 4.5,
              imageUrl:
                  (json['image_url'] ?? json['imageUrl']) as String? ?? '',
              stock: (json['stock'] as num?)?.toInt() ?? 10,
            );
          }).toList();
        }
      }
    } catch (e) {
      print('Failed to search products: $e');
    }
    return [];
  }

  /// Get product details by ID
  Future<ProductModel?> getProductById(String id) async {
    try {
      final res = await http.get(Uri.parse('${ApiConfig.products}/$id'));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        if (data['success'] == true && data['data'] != null) {
          final json = data['data'];
          return ProductModel(
            id: json['id']?.toString() ?? '',
            name: json['name'] ?? '',
            description: json['description'] ?? '',
            brand: json['brand'] ?? 'Unknown',
            category: json['category'] ?? 'Uncategorized',
            price: (json['price'] as num?)?.toDouble() ?? 0.0,
            bestPrice:
                (json['selling_price'] as num?)?.toDouble() ??
                (json['sellingPrice'] as num?)?.toDouble() ??
                (json['price'] as num?)?.toDouble() ??
                0.0,
            distanceKm: 0.5,
            availability: json['stock'] != null && json['stock'] > 0
                ? 'In Stock'
                : 'Out of Stock',
            shopName: json['shop'] != null
                ? json['shop']['name']
                : (json['shop_name'] ?? json['shopName'] ?? 'Shop'),
            rating: 4.5,
            imageUrl: (json['image_url'] ?? json['imageUrl']) as String? ?? '',
            stock: (json['stock'] as num?)?.toInt() ?? 10,
          );
        }
      }
    } catch (e) {
      print('Failed to get product by ID: $e');
    }
    return null;
  }

  /// Get shop comparison list for a specific product
  Future<List<Map<String, dynamic>>> getShopsForProduct(
    String productId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return const [
      {
        'shopId': 's1',
        'shopName': 'Super Fresh Supermarket',
        'price': 295.0,
        'distanceKm': 0.5,
        'rating': 4.8,
        'isOpen': true,
        'availability': 'In Stock (15+ units)',
        'address': 'No. 42, 2nd Avenue, Anna Nagar East, Chennai',
      },
      {
        'shopId': 's2',
        'shopName': 'Anna Nagar Fresh Mart',
        'price': 310.0,
        'distanceKm': 0.8,
        'rating': 4.7,
        'isOpen': true,
        'availability': 'In Stock (8 units)',
        'address': 'Plot 12, 5th Main Road, Anna Nagar, Chennai',
      },
      {
        'shopId': 's3',
        'shopName': 'Green Leaf General Store',
        'price': 325.0,
        'distanceKm': 1.2,
        'rating': 4.6,
        'isOpen': true,
        'availability': 'Limited Stock (2 units)',
        'address': '18, 3rd Street, Anna Nagar West, Chennai',
      },
    ];
  }
}
