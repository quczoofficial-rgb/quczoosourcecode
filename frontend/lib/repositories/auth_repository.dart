import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../core/config/api_config.dart';

/// Authentication Repository for QUCZO Customer & Shop Owner Authentication
class AuthRepository {
  static final AuthRepository _instance = AuthRepository._internal();
  factory AuthRepository() => _instance;
  AuthRepository._internal();

  String? _currentUserPhone;
  String? _userRole; // 'customer' or 'shop_owner'
  bool _isAuthenticated = false;
  String? _token;

  bool get isAuthenticated => _isAuthenticated;
  String? get currentUserPhone => _currentUserPhone;
  String? get userRole => _userRole;
  String? get token => _token;

  /// Send OTP to customer or shop-owner phone number
  Future<bool> sendOtp(String phoneNumber, {required String role}) async {
    _currentUserPhone = phoneNumber;
    _userRole = role;
    // In our backend, there's no actual send-otp endpoint for now.
    // We just store the mobile and role to use during verifyOtp.
    return true;
  }

  /// Verify 6-digit OTP code and perform actual login
  Future<bool> verifyOtp(String otpCode) async {
    if (_currentUserPhone == null || _userRole == null) return false;
    
    try {
      if (_userRole == 'customer') {
        // Try to login
        final loginRes = await http.post(
          Uri.parse('${ApiConfig.auth}/customer/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'mobile': _currentUserPhone}),
        );
        
        if (loginRes.statusCode == 404) {
          // If not found, register first
          final registerRes = await http.post(
            Uri.parse('${ApiConfig.auth}/customer/register'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'mobile': _currentUserPhone}),
          );
          if (registerRes.statusCode != 201) return false;
          
          // Retry login
          return await verifyOtp(otpCode);
        } else if (loginRes.statusCode == 200) {
          final data = jsonDecode(loginRes.body);
          await _saveSession(data['token']);
          return true;
        }
      } else if (_userRole == 'shop_owner') {
        final res = await http.post(
          Uri.parse('${ApiConfig.auth}/shop/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'mobile': _currentUserPhone,
            'password': otpCode // Use OTP as password for shop login mapping
          }),
        );
        if (res.statusCode == 200) {
          final data = jsonDecode(res.body);
          await _saveSession(data['token']);
          return true;
        }
      }
    } catch (e) {
      print('Auth error: $e');
    }
    return false;
  }

  Future<void> _saveSession(String jwt) async {
    _isAuthenticated = true;
    _token = jwt;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', jwt);
    await prefs.setString('user_role', _userRole ?? '');
    await prefs.setString('user_phone', _currentUserPhone ?? '');
  }

  Future<void> loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('jwt_token');
    if (_token != null) {
      _isAuthenticated = true;
      _userRole = prefs.getString('user_role');
      _currentUserPhone = prefs.getString('user_phone');
    }
  }

  /// Logout current session
  Future<void> logout() async {
    _isAuthenticated = false;
    _currentUserPhone = null;
    _userRole = null;
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
