class ApiConfig {
  static const String baseUrl = "http://localhost:5000";

  static const String auth = "$baseUrl/api/auth";
  static const String customer = "$baseUrl/api/customer";
  static const String shop = "$baseUrl/api/shop";
  static const String nearbyShops = "$shop/nearby";
  static const String products = "$baseUrl/api/products";
  static const String shopProducts = "$baseUrl/api/shop/products";
  static const String reservations = "$baseUrl/api/reservations";
  static const String inventory = "$baseUrl/api/inventory";
  static const String billing = "$baseUrl/api/billing";
  static const String dashboard = "$baseUrl/api/dashboard";
}
