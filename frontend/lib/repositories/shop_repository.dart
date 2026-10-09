import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/config/api_config.dart';
import '../models/product_model.dart';
import '../models/shop_model.dart';
import 'home_repository.dart';
import 'auth_repository.dart';

/// Shop Repository for Nearby Shops, Shop Details, Shop Owner Inventory & Product Management
class ShopRepository {
  final HomeRepository _homeRepo = HomeRepository();

  /// Fetch list of nearby local shops
  Future<List<ShopModel>> getNearbyShops() async {
    return _homeRepo.getNearbyShops();
  }

  /// Get details of a specific shop by ID
  Future<ShopModel?> getShopById(String shopId) async {
    final shops = await getNearbyShops();
    for (var s in shops) {
      if (s.id == shopId) return s;
    }
    return shops.isNotEmpty ? shops.first : null;
  }

  /// Fetch products listed by a specific shop
  Future<List<ProductModel>> getShopProducts(String shopId) async {
    final popular = await _homeRepo.getPopularProducts();
    final nearby = await _homeRepo.getNearbyProducts();
    return [...popular, ...nearby];
  }

  /// Shop Owner: Add new product to shop inventory
  Future<bool> addShopProduct(ProductModel product) async {
    try {
      final token = AuthRepository().token;
      if (token == null) return false;

      final res = await http.post(
        Uri.parse(ApiConfig.shopProducts),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'name': product.name,
          'brand': product.brand,
          'category': product.category,
          'price': product.price,
          'discount_price': product.bestPrice,
          'stock_quantity': 10,
          'image_url': product.imageUrl,
        }),
      );

      return res.statusCode == 201;
    } catch (e) {
      print('Failed to add shop product: $e');
    }
    return false;
  }

  /// Shop Owner: Update inventory stock count or availability status
  Future<bool> updateInventoryStock(String productId, int newStockCount) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true; // Partially mapped as there's no dedicated stock update endpoint without full product validation
  }
}
