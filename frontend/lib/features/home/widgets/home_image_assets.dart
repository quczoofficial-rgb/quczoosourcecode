import 'package:flutter/material.dart';

import '../../../widgets/common_branding.dart';

/// Real Photographic Image Renderer for QUCZO Home Categories and Products.
/// Renders high-resolution, photographic product cutout & category imagery.
class HomeImageAssets {
  static const Map<String, String> _categoryPhotoMap = {
    'grocery': 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=400&q=80',
    'fresh': 'https://images.unsplash.com/photo-1610832958506-aa56368176cf?w=400&q=80',
    'snacks': 'https://images.unsplash.com/photo-1566478989037-eec170784d0b?w=400&q=80',
    'household': 'https://images.unsplash.com/photo-1583947215259-38e31be8751f?w=400&q=80',
    'personal_care':
        'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=400&q=80',
    'hardware': 'https://images.unsplash.com/photo-1504148455328-c376907d081c?w=400&q=80',
    'electrical': 'https://images.unsplash.com/photo-1513506003901-1e6a229e2d15?w=400&q=80',
    'electronics': 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400&q=80',
    'plumbing': 'https://images.unsplash.com/photo-1581092160607-ee22621dd758?w=400&q=80',
    'home_appliances': 'https://images.unsplash.com/photo-1574269909862-7e1d70bb8078?w=400&q=80',
    'mobile': 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400&q=80',
    'stationery': 'https://images.unsplash.com/photo-1583485088034-697b5bc54ccd?w=400&q=80',
    'fashion': 'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?w=400&q=80',
    'local_stores': 'https://images.unsplash.com/photo-1578916171728-46686eac8d58?w=400&q=80',
  };

  /// Render real photographic category image
  static Widget buildCategoryImage(
    String categoryId, {
    double height = 60,
    double width = 80,
    String? imageUrl,
  }) {
    final String key = categoryId.toLowerCase();
    final String photoUrl = (imageUrl != null && imageUrl.isNotEmpty)
        ? imageUrl
        : (_categoryPhotoMap[key] ??
              _categoryPhotoMap.entries
                  .firstWhere(
                    (e) => key.contains(e.key),
                    orElse: () => _categoryPhotoMap.entries.first,
                  )
                  .value);

    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          photoUrl,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              color: const Color(0xFFF1F5F9),
              child: const Center(
                child: SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ),
            );
          },
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) return child;
            return AnimatedOpacity(
              opacity: frame == null ? 0 : 1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              child: child,
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xFFE2E8F0),
              child: const Center(
                child: Icon(Icons.image, color: Color(0xFF64748B), size: 24),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Render real photographic product image
  static Widget buildProductImage(
    String category,
    String name, {
    double height = 85,
    double width = double.infinity,
    String? imageUrl,
  }) {
    final String photoUrl = imageUrl?.trim() ?? '';
    final Widget fallback = Container(
      color: const Color(0xFFF1F5F9),
      alignment: Alignment.center,
      child: const QuczoBrandLogo(size: 30, showWordmark: false),
    );

    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: photoUrl.startsWith('https://')
            ? Image.network(
                photoUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: const Color(0xFFF1F5F9),
                    child: const Center(
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ),
                  );
                },
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  if (wasSynchronouslyLoaded) return child;
                  return AnimatedOpacity(
                    opacity: frame == null ? 0 : 1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    child: child,
                  );
                },
                errorBuilder: (context, error, stackTrace) => fallback,
              )
            : fallback,
      ),
    );
  }
}
