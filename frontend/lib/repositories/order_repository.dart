import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/config/api_config.dart';
import 'auth_repository.dart';

/// Order Lifecycle Status Enums
enum OrderLifecycleStatus {
  orderPlaced,
  shopReceived,
  shopAccepted,
  stockReserved,
  readyForPickup,
  customerCollects,
  completed,
}

extension OrderLifecycleStatusExtension on OrderLifecycleStatus {
  String get displayName {
    switch (this) {
      case OrderLifecycleStatus.orderPlaced:
        return 'Order Placed';
      case OrderLifecycleStatus.shopReceived:
        return 'Shop Received';
      case OrderLifecycleStatus.shopAccepted:
        return 'Shop Accepted';
      case OrderLifecycleStatus.stockReserved:
        return 'Stock Reserved';
      case OrderLifecycleStatus.readyForPickup:
        return 'Ready for Pickup';
      case OrderLifecycleStatus.customerCollects:
        return 'Customer Collects';
      case OrderLifecycleStatus.completed:
        return 'Completed';
    }
  }
}

/// Order Model representing a Local Pickup Order
class LocalOrder {
  final String orderId;
  final String shopId;
  final String shopName;
  final String shopAddress;
  final String productId;
  final String productName;
  final int quantity;
  final double totalPrice;
  final OrderLifecycleStatus status;
  final DateTime createdAt;

  LocalOrder({
    required this.orderId,
    required this.shopId,
    required this.shopName,
    required this.shopAddress,
    required this.productId,
    this.productName = '',
    required this.quantity,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
  });
}

/// Order Repository for Local Reservation & Pickup Lifecycle Tracking
class OrderRepository {
  static final OrderRepository _instance = OrderRepository._internal();
  factory OrderRepository() => _instance;
  OrderRepository._internal();

  final List<LocalOrder> _orders = [];

  /// Get list of customer pickup orders
  Future<List<LocalOrder>> getCustomerOrders() async {
    final token = AuthRepository().token;
    final customerId = AuthRepository().currentUserPhone;
    if (token == null || customerId == null) return _orders;

    try {
      final res = await http.get(
        Uri.parse('${ApiConfig.reservations}/customer/$customerId'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (res.statusCode == 200) {
        // Just return the local list for now, ideally parse from response
      }
    } catch (e) {
      print('Error fetching orders: $e');
    }
    return List.from(_orders);
  }

  /// Create new local store pickup reservation order
  Future<LocalOrder?> createPickupReservation({
    required String shopId,
    required String shopName,
    required String shopAddress,
    required String productId,
    String productName = '',
    required int quantity,
    required double totalPrice,
  }) async {
    final token = AuthRepository().token;
    final customerId = AuthRepository().currentUserPhone;
    
    if (token == null || customerId == null) return null;

    try {
      final res = await http.post(
        Uri.parse(ApiConfig.reservations),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'customerId': customerId,
          'productId': productId,
          'quantity': quantity,
        }),
      );

      if (res.statusCode == 201) {
        final data = jsonDecode(res.body)['data'];
        final newOrder = LocalOrder(
          orderId: data['reservation_id']?.toString() ?? 'QCZ-NEW',
          shopId: shopId,
          shopName: shopName,
          shopAddress: shopAddress,
          productId: productId,
          productName: productName,
          quantity: quantity,
          totalPrice: totalPrice,
          status: OrderLifecycleStatus.orderPlaced,
          createdAt: DateTime.now(),
        );

        _orders.insert(0, newOrder);
        return newOrder;
      }
    } catch (e) {
      print('Error creating reservation: $e');
    }
    return null;
  }

  /// Update order status for shop owner lifecycle management
  Future<bool> updateOrderStatus(String orderId, OrderLifecycleStatus newStatus) async {
    final token = AuthRepository().token;
    if (token == null) return false;

    try {
      if (newStatus == OrderLifecycleStatus.completed) {
        final res = await http.patch(
          Uri.parse('${ApiConfig.reservations}/$orderId/complete'),
          headers: {'Authorization': 'Bearer $token'},
        );
        if (res.statusCode == 200) return true;
      }
    } catch (e) {
      print('Error updating order: $e');
    }
    return false;
  }

  /// Get list of shop orders
  Future<List<dynamic>> getShopOrders(String shopId) async {
    final token = AuthRepository().token;
    if (token == null) return [];

    try {
      final res = await http.get(
        Uri.parse('${ApiConfig.reservations}/shop/$shopId'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return data['data'] ?? [];
      }
    } catch (e) {
      print('Error fetching shop orders: $e');
    }
    return [];
  }

  /// Accept order
  Future<bool> acceptOrder(String orderId) async {
    final token = AuthRepository().token;
    if (token == null) return false;

    try {
      final res = await http.patch(
        Uri.parse('${ApiConfig.reservations}/$orderId/accept'),
        headers: {'Authorization': 'Bearer $token'},
      );
      return res.statusCode == 200;
    } catch (e) {
      print('Error accepting order: $e');
    }
    return false;
  }

  /// Reject order
  Future<bool> rejectOrder(String orderId) async {
    final token = AuthRepository().token;
    if (token == null) return false;

    try {
      final res = await http.patch(
        Uri.parse('${ApiConfig.reservations}/$orderId/reject'),
        headers: {'Authorization': 'Bearer $token'},
      );
      return res.statusCode == 200;
    } catch (e) {
      print('Error rejecting order: $e');
    }
    return false;
  }
}
