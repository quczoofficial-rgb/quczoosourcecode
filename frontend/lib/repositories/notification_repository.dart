import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/config/api_config.dart';
import 'auth_repository.dart';

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String time;
  final bool isRead;
  final String icon;
  final String? reservationId;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.time,
    required this.isRead,
    this.icon = 'notification',
    this.reservationId,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      body: json['body']?.toString() ?? '',
      time: json['time']?.toString() ?? '',
      isRead: json['isRead'] == true,
      icon: json['icon']?.toString() ?? 'notification',
      reservationId: json['reservationId']?.toString(),
    );
  }
}

class NotificationRepository {
  /// Fetch real notifications from backend (derived from reservation status changes).
  Future<List<NotificationModel>> getNotifications() async {
    final token = AuthRepository().token;

    if (token != null) {
      try {
        final res = await http.get(
          Uri.parse('${ApiConfig.baseUrl}/api/notifications'),
          headers: {'Authorization': 'Bearer $token'},
        );

        if (res.statusCode == 200) {
          final data = jsonDecode(res.body);
          if (data['success'] == true && data['data'] != null) {
            return (data['data'] as List)
                .map((n) => NotificationModel.fromJson(n as Map<String, dynamic>))
                .toList();
          }
        }
      } catch (e) {
        // fall through to empty list
        print('Failed to load notifications: $e');
      }
    }

    // If not authenticated or no data, return empty list (not fake data)
    return [];
  }
}
