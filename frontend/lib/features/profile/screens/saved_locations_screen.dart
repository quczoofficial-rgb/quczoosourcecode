import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';

/// SCREEN 28 — SAVED SEARCH LOCATIONS SCREEN
class SavedLocationsScreen extends StatelessWidget {
  const SavedLocationsScreen({super.key});

  static const List<String> _savedLocations = [
    'Anna Nagar, Chennai (Active Area)',
    'T. Nagar, Chennai',
    'Velachery, Chennai',
    'Koramangala, Bengaluru',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Saved Search Areas', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.navy,
        elevation: 0.5,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Locations are used to discover nearby local shop inventory.', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  itemCount: _savedLocations.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final loc = _savedLocations[index];
                    final bool isActive = index == 0;
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: AppCorners.roundedMd,
                        border: Border.all(color: isActive ? AppColors.green : AppColors.border, width: isActive ? 1.5 : 1.0),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.location_on, color: isActive ? AppColors.green : AppColors.textSecondary),
                        title: Text(loc, style: TextStyle(fontWeight: isActive ? FontWeight.bold : FontWeight.w600, color: AppColors.navy)),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline, color: AppColors.textMuted),
                          onPressed: () {},
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/location-selection');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(borderRadius: AppCorners.roundedMd),
                ),
                icon: const Icon(Icons.add_location_alt_outlined),
                label: const Text('Add Search Location', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
