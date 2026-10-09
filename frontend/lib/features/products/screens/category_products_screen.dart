import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../../../models/category_model.dart';
import '../../../models/product_model.dart';
import '../../../navigation/app_routes.dart';
import '../../../repositories/home_repository.dart';

/// SCREEN 18 — CATEGORY PRODUCTS GRID SCREEN
class CategoryProductsScreen extends StatefulWidget {
  final CategoryModel? category;

  const CategoryProductsScreen({super.key, this.category});

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  final HomeRepository _repository = HomeRepository();
  List<ProductModel> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCategoryProducts();
  }

  Future<void> _fetchCategoryProducts() async {
    final popular = await _repository.getPopularProducts();
    final nearby = await _repository.getNearbyProducts();

    if (mounted) {
      setState(() {
        _products = [...popular, ...nearby];
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String catTitle = widget.category?.fallbackTitle ?? 'Category Products';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(catTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.navy,
        elevation: 0.5,
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: AppColors.green))
            : GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.72,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final p = _products[index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.productDetails, arguments: p);
                    },
                    borderRadius: AppCorners.roundedMd,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: AppCorners.roundedMd,
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  p.imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (ctx, err, stack) => const Icon(Icons.image, size: 40, color: AppColors.textMuted),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            p.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.navy),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${p.brand} • ${p.distanceKm} km',
                            style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '₹${(p.bestPrice ?? p.price).toInt()}',
                                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: AppColors.green),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.greenSubtle,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text('Reserve', style: TextStyle(color: AppColors.greenDark, fontSize: 10, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
