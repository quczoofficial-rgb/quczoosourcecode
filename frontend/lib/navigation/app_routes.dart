import 'package:flutter/material.dart';

// Auth & Onboarding
import '../features/splash/screens/splash_screen.dart';
import '../features/welcome/screens/welcome_screen.dart';
import '../features/auth/screens/customer_login_screen.dart';
import '../features/auth/screens/otp_verification_screen.dart';

// Location
import '../features/location/screens/location_permission_screen.dart';
import '../features/location/screens/manual_location_screen.dart';

// Customer Home & Search
import '../features/home/screens/customer_home_screen.dart';
import '../features/search/screens/ai_search_screen.dart';
import '../features/search/screens/ai_search_processing_screen.dart';
import '../features/search/screens/voice_search_screen.dart';
import '../features/search/screens/image_search_screen.dart';
import '../features/search/screens/search_results_screen.dart';
import '../features/search/screens/price_comparison_screen.dart';

// Products & Shops
import '../features/products/screens/product_details_screen.dart';
import '../features/shops/screens/shop_details_screen.dart';
import '../features/shops/screens/nearby_shops_map_screen.dart';
import '../features/categories/screens/categories_screen.dart';
import '../features/products/screens/category_products_screen.dart';

// Cart & Orders
import '../features/cart/screens/cart_screen.dart';
import '../features/cart/screens/pickup_checkout_screen.dart';
import '../features/cart/screens/order_success_screen.dart';
import '../features/orders/screens/orders_screen.dart';
import '../features/orders/screens/pickup_status_screen.dart';
import '../features/notifications/screens/notifications_screen.dart';
import '../features/reviews/screens/review_screen.dart';

// Profile & Account
import '../features/profile/screens/profile_screen.dart';
import '../features/profile/screens/edit_profile_screen.dart';
import '../features/profile/screens/saved_locations_screen.dart';
import '../features/profile/screens/saved_shops_screen.dart';
import '../features/profile/screens/settings_screen.dart';
import '../features/profile/screens/help_support_screen.dart';

// Shop Owner Business App
import '../features/shop_owner/screens/shop_owner_login_screen.dart';
import '../features/shop_owner/screens/shop_owner_registration_screen.dart';
import '../features/shop_owner/screens/shop_owner_otp_screen.dart';
import '../features/shop_owner/screens/shop_setup_screen.dart';
import '../features/shop_owner/screens/shop_owner_dashboard_screen.dart';
import '../features/shop_owner/screens/product_management_screen.dart';
import '../features/shop_owner/screens/add_product_screen.dart';
import '../features/shop_owner/screens/edit_product_screen.dart';
import '../features/shop_owner/screens/barcode_scanner_screen.dart';
import '../features/shop_owner/screens/invoice_upload_screen.dart';
import '../features/shop_owner/screens/bulk_upload_screen.dart';
import '../features/shop_owner/screens/inventory_screen.dart';
import '../features/shop_owner/screens/order_management_screen.dart';
import '../features/shop_owner/screens/shop_order_details_screen.dart';
import '../features/shop_owner/screens/customers_screen.dart';
import '../features/shop_owner/screens/shop_analytics_screen.dart';
import '../features/shop_owner/screens/subscription_screen.dart';
import '../features/shop_owner/screens/shop_settings_screen.dart';

// Admin Web Portal
import '../features/admin/screens/admin_login_screen.dart';
import '../features/admin/screens/admin_dashboard_screen.dart';
import '../features/admin/screens/admin_customers_screen.dart';
import '../features/admin/screens/admin_shops_screen.dart';
import '../features/admin/screens/admin_products_screen.dart';
import '../features/admin/screens/admin_categories_screen.dart';
import '../features/admin/screens/admin_orders_screen.dart';
import '../features/admin/screens/admin_shop_verification_screen.dart';
import '../features/admin/screens/admin_analytics_screen.dart';
import '../features/admin/screens/admin_reports_screen.dart';
import '../features/admin/screens/admin_notifications_screen.dart';
import '../features/admin/screens/admin_support_screen.dart';
import '../features/admin/screens/admin_settings_screen.dart';

// Models
import '../models/product_model.dart';
import '../models/shop_model.dart';
import '../models/category_model.dart';

abstract class AppRoutes {
  // Customer Routes
  static const String splash = '/';
  static const String welcomeLanguage = '/welcome-language';
  static const String customerLogin = '/customer-login';
  static const String otpVerification = '/otp-verification';
  static const String locationPermission = '/location-permission';
  static const String locationSelection = '/location-selection';
  static const String customerHome = '/customer-home';
  static const String search = '/search';
  static const String aiSearch = '/ai-search';
  static const String aiSearchProcessing = '/ai-search-processing';
  static const String voiceSearch = '/voice-search';
  static const String imageSearch = '/image-search';
  static const String searchResults = '/search-results';
  static const String priceComparison = '/price-comparison';
  static const String productDetails = '/product-details';
  static const String shopDetails = '/shop-details';
  static const String nearbyShopsMap = '/nearby-shops-map';
  static const String categories = '/categories';
  static const String categoryProducts = '/category-products';
  static const String cart = '/cart';
  static const String pickupCheckout = '/pickup-checkout';
  static const String orderSuccess = '/order-success';
  static const String orders = '/orders';
  static const String pickupStatus = '/pickup-status';
  static const String notifications = '/notifications';
  static const String review = '/review';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String savedLocations = '/saved-locations';
  static const String savedShops = '/saved-shops';
  static const String settings = '/settings';
  static const String helpSupport = '/help-support';

  // Shop Owner Routes
  static const String shopOwnerLogin = '/shop-owner-login';
  static const String shopOwnerRegistration = '/shop-owner-registration';
  static const String shopOwnerOtp = '/shop-owner-otp';
  static const String shopSetup = '/shop-setup';
  static const String shopOwnerDashboard = '/shop-owner-dashboard';
  static const String productManagement = '/product-management';
  static const String addProduct = '/add-product';
  static const String editProduct = '/edit-product';
  static const String barcodeScanner = '/barcode-scanner';
  static const String invoiceUpload = '/invoice-upload';
  static const String bulkUpload = '/bulk-upload';
  static const String inventory = '/inventory';
  static const String orderManagement = '/order-management';
  static const String shopOrderDetails = '/shop-order-details';
  static const String customers = '/customers';
  static const String shopAnalytics = '/shop-analytics';
  static const String subscription = '/subscription';
  static const String shopSettings = '/shop-settings';

  // Admin Routes
  static const String adminLogin = '/admin-login';
  static const String adminDashboard = '/admin-dashboard';
  static const String adminCustomers = '/admin-customers';
  static const String adminShops = '/admin-shops';
  static const String adminProducts = '/admin-products';
  static const String adminCategories = '/admin-categories';
  static const String adminOrders = '/admin-orders';
  static const String adminShopVerification = '/admin-shop-verification';
  static const String adminAnalytics = '/admin-analytics';
  static const String adminReports = '/admin-reports';
  static const String adminNotifications = '/admin-notifications';
  static const String adminSupport = '/admin-support';
  static const String adminSettings = '/admin-settings';

  static Map<String, WidgetBuilder> get routes => {
        // Customer
        splash: (context) => const SplashScreen(),
        welcomeLanguage: (context) => const WelcomeScreen(),
        customerLogin: (context) => const CustomerLoginScreen(),
        otpVerification: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final phone = args is String ? args : '';
          return OtpVerificationScreen(phoneNumber: phone);
        },
        locationPermission: (context) => const LocationPermissionScreen(),
        locationSelection: (context) => const ManualLocationScreen(),
        customerHome: (context) => const CustomerHomeScreen(),
        search: (context) => const AiSearchScreen(),
        aiSearch: (context) => const AiSearchScreen(),
        aiSearchProcessing: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final q = args is String ? args : 'Surf Excel 2kg';
          return AiSearchProcessingScreen(query: q);
        },
        voiceSearch: (context) => const VoiceSearchScreen(),
        imageSearch: (context) => const ImageSearchScreen(),
        searchResults: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final q = args is String ? args : 'LED Bulb';
          return SearchResultsScreen(query: q);
        },
        priceComparison: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final p = args is ProductModel ? args : null;
          return PriceComparisonScreen(product: p);
        },
        productDetails: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final p = args is ProductModel ? args : null;
          return ProductDetailsScreen(product: p);
        },
        shopDetails: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final s = args is ShopModel ? args : null;
          return ShopDetailsScreen(shop: s);
        },
        nearbyShopsMap: (context) => const NearbyShopsMapScreen(),
        categories: (context) => const CategoriesScreen(),
        categoryProducts: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final cat = args is CategoryModel ? args : null;
          return CategoryProductsScreen(category: cat);
        },
        cart: (context) => const CartScreen(),
        pickupCheckout: (context) => const PickupCheckoutScreen(),
        orderSuccess: (context) => const OrderSuccessScreen(),
        orders: (context) => const OrdersScreen(),
        pickupStatus: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final id = args is String ? args : null;
          return PickupStatusScreen(orderId: id);
        },
        notifications: (context) => const NotificationsScreen(),
        review: (context) => const ReviewScreen(),
        profile: (context) => const ProfileScreen(),
        editProfile: (context) => const EditProfileScreen(),
        savedLocations: (context) => const SavedLocationsScreen(),
        savedShops: (context) => const SavedShopsScreen(),
        settings: (context) => const SettingsScreen(),
        helpSupport: (context) => const HelpSupportScreen(),

        // Shop Owner
        shopOwnerLogin: (context) => const ShopOwnerLoginScreen(),
        shopOwnerRegistration: (context) => const ShopOwnerRegistrationScreen(),
        shopOwnerOtp: (context) => const ShopOwnerOtpScreen(),
        shopSetup: (context) => const ShopSetupScreen(),
        shopOwnerDashboard: (context) => const ShopOwnerDashboardScreen(),
        productManagement: (context) => const ProductManagementScreen(),
        addProduct: (context) => const AddProductScreen(),
        editProduct: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final p = args is ProductModel ? args : null;
          return EditProductScreen(product: p);
        },
        barcodeScanner: (context) => const BarcodeScannerScreen(),
        invoiceUpload: (context) => const InvoiceUploadScreen(),
        bulkUpload: (context) => const BulkUploadScreen(),
        inventory: (context) => const InventoryScreen(),
        orderManagement: (context) => const OrderManagementScreen(),
        shopOrderDetails: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final id = args is String ? args : null;
          return ShopOrderDetailsScreen(orderId: id);
        },
        customers: (context) => const CustomersScreen(),
        shopAnalytics: (context) => const ShopAnalyticsScreen(),
        subscription: (context) => const SubscriptionScreen(),
        shopSettings: (context) => const ShopSettingsScreen(),

        // Admin
        adminLogin: (context) => const AdminLoginScreen(),
        adminDashboard: (context) => const AdminDashboardScreen(),
        adminCustomers: (context) => const AdminCustomersScreen(),
        adminShops: (context) => const AdminShopsScreen(),
        adminProducts: (context) => const AdminProductsScreen(),
        adminCategories: (context) => const AdminCategoriesScreen(),
        adminOrders: (context) => const AdminOrdersScreen(),
        adminShopVerification: (context) => const AdminShopVerificationScreen(),
        adminAnalytics: (context) => const AdminAnalyticsScreen(),
        adminReports: (context) => const AdminReportsScreen(),
        adminNotifications: (context) => const AdminNotificationsScreen(),
        adminSupport: (context) => const AdminSupportScreen(),
        adminSettings: (context) => const AdminSettingsScreen(),
      };
}
