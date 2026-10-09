import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../models/product_model.dart';
import '../../../models/shop_model.dart';
import '../../../repositories/home_repository.dart';
import '../../../repositories/cart_repository.dart';
import '../../../repositories/location_repository.dart';
import '../widgets/custom_bottom_nav.dart';

import '../../../widgets/common_branding.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  final HomeRepository _repository = HomeRepository();
  final ScrollController _scrollController = ScrollController();
  int _currentNavIndex = 0;
  String? _userSelectedLocation;

  List<ProductModel>? _popularProducts;
  List<ProductModel>? _nearbyProducts;
  List<ShopModel>? _nearbyShops;
  bool _isLocatingLocation = true;

  @override
  void initState() {
    super.initState();
    _fetchLocationSilently();
    _loadHomeData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchLocationSilently() async {
    final locRepo = LocationRepository();
    final permGranted = await locRepo.requestLocationPermission();
    if (mounted) {
      setState(() {
        if (permGranted) {
          _userSelectedLocation = locRepo.currentLocation;
        }
        _isLocatingLocation = false;
      });
    }
  }

  Future<void> _loadHomeData() async {
    try {
      final popular = await _repository.getPopularProducts();
      if (mounted) setState(() => _popularProducts = popular);
    } catch (e) {
      if (mounted) setState(() => _popularProducts = []);
    }

    try {
      final nearby = await _repository.getNearbyProducts();
      if (mounted) setState(() => _nearbyProducts = nearby);
    } catch (e) {
      if (mounted) setState(() => _nearbyProducts = []);
    }

    try {
      final shops = await _repository.getNearbyShops();
      if (mounted) setState(() => _nearbyShops = shops);
    } catch (e) {
      if (mounted) setState(() => _nearbyShops = []);
    }
  }

  Widget _buildImage(String? url, double width, double height, BoxFit fit) {
    final Widget placeholder = Container(
      width: width,
      height: height,
      color: const Color(0xFFF1F5F9),
      alignment: Alignment.center,
      child: const QuczoBrandLogo(size: 32, showWordmark: false),
    );

    if (url == null || url.trim().isEmpty || !url.startsWith('https://')) {
      return placeholder;
    }
    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          width: width,
          height: height,
          color: const Color(0xFFF1F5F9),
          alignment: Alignment.center,
          child: const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.green,
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) => placeholder,
    );
  }

  @override
  Widget build(BuildContext context) {
    final String currentSearchLocation =
        _userSelectedLocation ??
        (_isLocatingLocation ? 'Getting location...' : 'Location unavailable');

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // TOP HEADER
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.white,
              child: Row(
                children: [
                  const QuczoBrandLogo(size: 36, showWordmark: false),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, '/location-selection'),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Delivering to',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                currentSearchLocation,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.navy,
                                ),
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down,
                                size: 16,
                                color: AppColors.navy,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_none,
                      color: AppColors.navy,
                    ),
                    onPressed: () =>
                        Navigator.pushNamed(context, '/notifications'),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.person_outline,
                      color: AppColors.navy,
                    ),
                    onPressed: () => Navigator.pushNamed(context, '/profile'),
                  ),
                ],
              ),
            ),

            // MAIN SCROLLABLE CONTENT
            Expanded(
              child: RefreshIndicator(
                onRefresh: _loadHomeData,
                color: AppColors.green,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // WELCOME / SEARCH AREA
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Good morning, Customer',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: AppColors.navy,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Find products from nearby shops',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: TextField(
                                textInputAction: TextInputAction.search,
                                decoration: InputDecoration(
                                  hintText: 'Search products, shops...',
                                  hintStyle: const TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 14,
                                  ),
                                  border: InputBorder.none,
                                  icon: const Icon(
                                    Icons.search,
                                    color: AppColors.textSecondary,
                                  ),
                                  suffixIcon: Container(
                                    margin: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Icon(
                                      Icons.mic_none,
                                      size: 18,
                                      color: AppColors.green,
                                    ),
                                  ),
                                ),
                                onSubmitted: (query) {
                                  if (query.trim().isNotEmpty) {
                                    Navigator.pushNamed(
                                      context,
                                      '/search-results',
                                      arguments: query.trim(),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),

                      // CATEGORY SECTION
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'Categories',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.navy,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Row(
                                children: [
                                  _buildCategoryItem(
                                    'Groceries',
                                    'https://images.unsplash.com/photo-1542838132-92c53300491e?w=400&q=80',
                                  ),
                                  _buildCategoryItem(
                                    'Home',
                                    'https://images.unsplash.com/photo-1583847268964-b28ce8f7d1e3?w=400&q=80',
                                  ),
                                  _buildCategoryItem(
                                    'Personal Care',
                                    'https://images.unsplash.com/photo-1629198688000-71f23e745b6e?w=400&q=80',
                                  ),
                                  _buildCategoryItem(
                                    'Electronics',
                                    'https://images.unsplash.com/photo-1498049794561-7780e7231661?w=400&q=80',
                                  ),
                                  _buildCategoryItem(
                                    'Stationery',
                                    'https://images.unsplash.com/photo-1456735190827-d1262f71b8a3?w=400&q=80',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),

                      // NEARBY SHOPS
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'Nearby Shops',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.navy,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            if (_nearbyShops == null)
                              _buildShopsSkeleton()
                            else if (_nearbyShops!.isEmpty)
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'Unable to load nearby shops',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              )
                            else
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: Row(
                                  children: _nearbyShops!
                                      .map((shop) => _buildShopCard(shop))
                                      .toList(),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),

                      // POPULAR PRODUCTS
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'Popular Near You',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.navy,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            if (_popularProducts == null)
                              _buildProductsSkeleton()
                            else if (_popularProducts!.isEmpty)
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                child: Text(
                                  'No products found',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              )
                            else
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                itemCount: _popularProducts!.length > 5
                                    ? 5
                                    : _popularProducts!.length,
                                separatorBuilder: (c, i) => const Divider(
                                  height: 20,
                                  color: AppColors.border,
                                ),
                                itemBuilder: (c, i) =>
                                    _buildProductCard(_popularProducts![i]),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),

                      // AVAILABLE NEAR YOU
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'Available Near You',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.navy,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'In-stock items at nearby shops',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            if (_nearbyProducts == null)
                              _buildProductsSkeleton()
                            else if (_nearbyProducts!.isEmpty)
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                child: Text(
                                  'No products found',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              )
                            else
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                itemCount: _nearbyProducts!.length > 6
                                    ? 6
                                    : _nearbyProducts!.length,
                                separatorBuilder: (c, i) => const Divider(
                                  height: 20,
                                  color: AppColors.border,
                                ),
                                itemBuilder: (c, i) =>
                                    _buildProductCard(_nearbyProducts![i]),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          setState(() => _currentNavIndex = index);
          if (index == 1) {
            Navigator.pushNamed(context, '/search');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/cart');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/orders');
          } else if (index == 4) {
            Navigator.pushNamed(context, '/profile');
          }
        },
      ),
    );
  }

  Widget _buildCategoryItem(String label, String imageUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/search-results',
          arguments: label,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9), // Slate 100 
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Icon(Icons.category, color: Colors.grey));
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator(color: AppColors.green, strokeWidth: 2));
                },
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.navy,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShopsSkeleton() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(
          3,
          (i) => Container(
            width: 140,
            height: 160,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductsSkeleton() {
    return Column(
      children: List.generate(
        3,
        (i) => Container(
          height: 100,
          margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildShopCard(ShopModel shop) {
    return Container(
      width: 150,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(shop.imageUrl, double.infinity, 90, BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shop.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: AppColors.navy,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 12,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '${shop.distanceKm.toStringAsFixed(1)} km',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  shop.isOpen ? 'Open Now' : 'Closed',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: shop.isOpen ? AppColors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(ProductModel product) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, '/product-details', arguments: product),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: _buildImage(product.imageUrl, 80, 80, BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.navy,
                  ),
                ),
                const SizedBox(height: 2),
                if (product.shopName.isNotEmpty)
                  Row(
                    children: [
                      const Icon(
                        Icons.storefront_outlined,
                        size: 12,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          product.shopName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 6),
                Text(
                  '₹${(product.bestPrice ?? product.price).toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.green,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                product.stock > 0 ? 'In Stock' : 'Out of Stock',
                style: TextStyle(
                  fontSize: 11,
                  color: product.stock > 0 ? AppColors.green : Colors.red,
                ),
              ),
              const SizedBox(height: 8),
              _buildCartButton(product),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCartButton(ProductModel product) {
    return ListenableBuilder(
      listenable: CartRepository(),
      builder: (context, _) {
        final cartItems = CartRepository().items;
        final index = cartItems.indexWhere((i) => i.product.id == product.id);

        if (index != -1 && cartItems[index].quantity > 0) {
          final qty = cartItems[index].quantity;
          return Container(
            decoration: BoxDecoration(
              color: AppColors.green,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => CartRepository().updateQuantity(product.id, -1),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Icon(Icons.remove, size: 16, color: Colors.white),
                  ),
                ),
                Text(
                  '$qty',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                InkWell(
                  onTap: () => CartRepository().updateQuantity(product.id, 1),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Icon(Icons.add, size: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        }

        return OutlinedButton(
          onPressed: product.stock > 0
              ? () => CartRepository().addItem(product)
              : null,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.green,
            side: const BorderSide(color: AppColors.green),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            minimumSize: const Size(60, 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Text(
            'ADD',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
