import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../../../repositories/cart_repository.dart';

/// SCREEN 19 — CART & RESERVATION BASKET SCREEN
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartRepository _cartRepo = CartRepository();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _cartRepo,
      builder: (context, _) {
        final items = _cartRepo.items;
        final subtotal = _cartRepo.subtotal;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            title: const Text('Pickup Cart', style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: AppColors.surface,
            foregroundColor: AppColors.navy,
            elevation: 0.5,
          ),
          body: SafeArea(
            child: items.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.shopping_cart_outlined, size: 64, color: AppColors.textMuted),
                          const SizedBox(height: 16),
                          const Text('Your cart is empty', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.navy)),
                          const SizedBox(height: 8),
                          const Text(
                            'Add products from nearby shops to reserve them.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.green,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: AppCorners.roundedMd),
                            ),
                            child: const Text('Continue Shopping', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Pickup Shop Info Banner
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.greenSubtle,
                            borderRadius: AppCorners.roundedMd,
                            border: Border.all(color: AppColors.green.withValues(alpha: 0.3)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.storefront, color: AppColors.green, size: 24),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('Selected Shop for Pickup', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy, fontSize: 14)),
                                    Text('Pay physically upon pickup.', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        const Text('RESERVED ITEMS', style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.8)),
                        const SizedBox(height: 10),

                        // List of dynamic cart items
                        ...items.map((item) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: AppCorners.roundedMd,
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.network(
                                    item.product.imageUrl.isNotEmpty ? item.product.imageUrl : 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=200&q=80',
                                    width: 60, height: 60, fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Container(width: 60, height: 60, color: Colors.grey[200]),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item.product.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy, fontSize: 14)),
                                      const SizedBox(height: 4),
                                      Text('₹${item.product.bestPrice ?? item.product.price} / unit', style: const TextStyle(color: AppColors.green, fontWeight: FontWeight.bold, fontSize: 13)),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          Container(
                                            height: 32,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: AppColors.border),
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                  icon: const Icon(Icons.remove, color: AppColors.navy, size: 16),
                                                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () => _cartRepo.updateQuantity(item.product.id, -1),
                                                ),
                                                Container(
                                                  width: 24,
                                                  alignment: Alignment.center,
                                                  child: Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                                ),
                                                IconButton(
                                                  icon: const Icon(Icons.add, color: AppColors.green, size: 16),
                                                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () => _cartRepo.updateQuantity(item.product.id, 1),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          GestureDetector(
                                            onTap: () => _cartRepo.removeItem(item.product.id),
                                            child: Row(
                                              children: const [
                                                Icon(Icons.delete_outline, color: Colors.red, size: 18),
                                                SizedBox(width: 4),
                                                Text('Remove', style: TextStyle(color: Colors.red, fontSize: 13, fontWeight: FontWeight.bold)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),

                        const SizedBox(height: 24),

                        // Total Summary
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: AppCorners.roundedMd,
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Total Reservation Value', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy, fontSize: 15)),
                                  Text('₹${subtotal.toInt()}', style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.green, fontSize: 18)),
                                ],
                              ),
                              const SizedBox(height: 6),
                              const Text('No payment required now. Pay directly at the shop upon physical pickup.', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          bottomNavigationBar: items.isEmpty ? null : Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pickup-checkout');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.green,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: AppCorners.roundedMd),
              ),
              child: const Text('Proceed to Pickup Confirmation', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        );
      }
    );
  }
}
