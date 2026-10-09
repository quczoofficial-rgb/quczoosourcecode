import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../core/config/api_config.dart';
import '../core/theme/app_colors.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';
import '../models/shop_model.dart';

/// Generic Backend-Ready Repository for QUCZO Customer Home Marketplace
class HomeRepository {
  /// Fetch list of categories representing the broad QUCZO marketplace
  Future<List<CategoryModel>> getCategories() async {
    return const [
      CategoryModel(
        id: 'grocery',
        titleKey: 'catGrocery',
        fallbackTitle: 'Grocery & Supermarket',
        imageUrl: 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=400&q=80',
        icon: Icons.shopping_basket_outlined,
        backgroundColor: AppColors.yellowSubtle,
        iconColor: Color(0xFFD97706),
      ),
      CategoryModel(
        id: 'fresh',
        titleKey: 'catFreshProduce',
        fallbackTitle: 'Fresh Produce',
        imageUrl: 'https://images.unsplash.com/photo-1610832958506-aa56368176cf?w=400&q=80',
        icon: Icons.eco_outlined,
        backgroundColor: AppColors.mintSubtle,
        iconColor: Color(0xFF059669),
      ),
      CategoryModel(
        id: 'snacks',
        titleKey: 'catSnacks',
        fallbackTitle: 'Snacks & Beverages',
        imageUrl: 'https://images.unsplash.com/photo-1566478989037-eec170784d0b?w=400&q=80',
        icon: Icons.fastfood_outlined,
        backgroundColor: AppColors.orangeSubtle,
        iconColor: Color(0xFFEA580C),
      ),
      CategoryModel(
        id: 'household',
        titleKey: 'catHousehold',
        fallbackTitle: 'Household Essentials',
        imageUrl: 'https://images.unsplash.com/photo-1583947215259-38e31be8751f?w=400&q=80',
        icon: Icons.cleaning_services_outlined,
        backgroundColor: AppColors.cyanSubtle,
        iconColor: Color(0xFF0891B2),
      ),
      CategoryModel(
        id: 'personal_care',
        titleKey: 'catPersonalCare',
        fallbackTitle: 'Personal Care',
        imageUrl: 'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=400&q=80',
        icon: Icons.sanitizer_outlined,
        backgroundColor: AppColors.lavenderSubtle,
        iconColor: Color(0xFF7C3AED),
      ),
      CategoryModel(
        id: 'hardware',
        titleKey: 'catHardware',
        fallbackTitle: 'Hardware & Tools',
        imageUrl: 'https://images.unsplash.com/photo-1504148455328-c376907d081c?w=400&q=80',
        icon: Icons.build_outlined,
        backgroundColor: AppColors.slateSubtle,
        iconColor: Color(0xFF475569),
      ),
      CategoryModel(
        id: 'electrical',
        titleKey: 'catElectrical',
        fallbackTitle: 'Electrical & Wiring',
        imageUrl: 'https://images.unsplash.com/photo-1513506003901-1e6a229e2d15?w=400&q=80',
        icon: Icons.electrical_services_outlined,
        backgroundColor: AppColors.yellowSubtle,
        iconColor: Color(0xFFCA8A04),
      ),
      CategoryModel(
        id: 'electronics',
        titleKey: 'catElectronics',
        fallbackTitle: 'Electronics & Mobiles',
        imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400&q=80',
        icon: Icons.devices_outlined,
        backgroundColor: AppColors.blueSubtle,
        iconColor: Color(0xFF2563EB),
      ),
      CategoryModel(
        id: 'plumbing',
        titleKey: 'catPlumbing',
        fallbackTitle: 'Pipes & Plumbing',
        imageUrl: 'https://images.unsplash.com/photo-1581092160607-ee22621dd758?w=400&q=80',
        icon: Icons.plumbing_outlined,
        backgroundColor: AppColors.cyanSubtle,
        iconColor: Color(0xFF0284C7),
      ),
      CategoryModel(
        id: 'home_appliances',
        titleKey: 'catHomeImprovement',
        fallbackTitle: 'Home Appliances',
        imageUrl: 'https://images.unsplash.com/photo-1574269909862-7e1d70bb8078?w=400&q=80',
        icon: Icons.kitchen_outlined,
        backgroundColor: AppColors.peachSubtle,
        iconColor: Color(0xFFDB2777),
      ),
      CategoryModel(
        id: 'mobile',
        titleKey: 'catMobileAccessories',
        fallbackTitle: 'Mobile Accessories',
        imageUrl: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400&q=80',
        icon: Icons.phone_android_outlined,
        backgroundColor: AppColors.blueSubtle,
        iconColor: Color(0xFF2563EB),
      ),
      CategoryModel(
        id: 'stationery',
        titleKey: 'catStationery',
        fallbackTitle: 'Stationery & School',
        imageUrl: 'https://images.unsplash.com/photo-1583485088034-697b5bc54ccd?w=400&q=80',
        icon: Icons.menu_book_outlined,
        backgroundColor: AppColors.lavenderSubtle,
        iconColor: Color(0xFF9333EA),
      ),
      CategoryModel(
        id: 'fashion',
        titleKey: 'catFashion',
        fallbackTitle: 'Fashion & Apparel',
        imageUrl: 'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?w=400&q=80',
        icon: Icons.checkroom_outlined,
        backgroundColor: AppColors.peachSubtle,
        iconColor: Color(0xFFE11D48),
      ),
      CategoryModel(
        id: 'local_stores',
        titleKey: 'catLocalStores',
        fallbackTitle: 'Local Stores',
        imageUrl: 'https://images.unsplash.com/photo-1578916171728-46686eac8d58?w=400&q=80',
        icon: Icons.storefront_outlined,
        backgroundColor: AppColors.slateSubtle,
        iconColor: Color(0xFF0F172A),
      ),
    ];
  }

  /// Fetch popular high-demand products near the customer
  Future<List<ProductModel>> getPopularProducts() async {
    try {
      final res = await http.get(Uri.parse('${ApiConfig.products}'));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        if (data['success'] == true && data['data'] != null) {
          final List products = data['data'];
          return products.map((p) => _mapToProductModel(p)).toList();
        }
      }
    } catch (e) {
      print('Failed to load popular products: $e');
    }
    return [];
  }

  /// Fetch products available in nearby local shops
  Future<List<ProductModel>> getNearbyProducts() async {
    try {
      final res = await http.get(Uri.parse('${ApiConfig.products}'));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        if (data['success'] == true && data['data'] != null) {
          final List products = data['data'];
          return products.map((p) => _mapToProductModel(p)).toList();
        }
      }
    } catch (e) {
      print('Failed to load nearby products: $e');
    }
    return [];
  }

  /// Fetch price comparison deals
  Future<List<ProductModel>> getPriceComparisonDeals() async {
    try {
      final res = await http.get(Uri.parse('${ApiConfig.products}'));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        if (data['success'] == true && data['data'] != null) {
          final List products = data['data'];
          return products.map((p) => _mapToProductModel(p)).toList();
        }
      }
    } catch (e) {
      print('Failed to load price comparison deals: $e');
    }
    return [];
  }

  ProductModel _mapToProductModel(Map<String, dynamic> json) {
    final double price = (json['price'] as num?)?.toDouble() ?? 0.0;
    final double sellingPrice =
        (json['sellingPrice'] as num?)?.toDouble() ??
        (json['selling_price'] as num?)?.toDouble() ??
        price;
    final int stock = (json['stock'] as num?)?.toInt() ?? 0;
    final String category = json['category']?.toString() ?? 'General';
    final String shopName = json['shop'] != null
        ? (json['shop']['name']?.toString() ?? category)
        : (json['shopName'] ?? json['shop_name'] ?? category);
    return ProductModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      brand: json['brand'] ?? category,
      category: category,
      price: price,
      bestPrice: sellingPrice,
      distanceKm: 0.5,
      availability: stock > 0 ? 'In Stock' : 'Out of Stock',
      shopName: shopName,
      rating: 4.5,
      imageUrl: json['image_url'] ?? json['imageUrl'] ?? '',
      stock: stock,
    );
  }

  /// Fetch nearby local shops
  Future<List<ShopModel>> getNearbyShops() async {
    try {
      final res = await http.get(Uri.parse(ApiConfig.nearbyShops));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        if (data['success'] == true && data['data'] is List) {
          return (data['data'] as List).map((json) {
            return ShopModel.fromJson(json as Map<String, dynamic>);
          }).toList();
        }
      }
    } catch (e) {
      print('Failed to load nearby shops: $e');
    }
    return [];
  }
}
