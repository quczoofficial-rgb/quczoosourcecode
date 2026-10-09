import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../../../navigation/app_routes.dart';

/// SCREEN 06 — MANUAL LOCATION SELECTION SCREEN
class ManualLocationScreen extends StatefulWidget {
  const ManualLocationScreen({super.key});

  @override
  State<ManualLocationScreen> createState() => _ManualLocationScreenState();
}

class _ManualLocationScreenState extends State<ManualLocationScreen> {
  final TextEditingController _locationSearchController = TextEditingController();

  static const List<String> _popularLocations = [
    'Anna Nagar, Chennai',
    'T. Nagar, Chennai',
    'Velachery, Chennai',
    'Adyar, Chennai',
    'Koramangala, Bengaluru',
    'Indiranagar, Bengaluru',
    'Madhapur, Hyderabad',
  ];

  @override
  void dispose() {
    _locationSearchController.dispose();
    super.dispose();
  }

  void _selectLocation(String location) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context, location);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.customerHome);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.navy,
        elevation: 0.5,
        title: const Text(
          'Select Search Area',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Location Search Box
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppCorners.roundedMd,
                  border: Border.all(color: AppColors.border),
                ),
                child: TextField(
                  controller: _locationSearchController,
                  decoration: const InputDecoration(
                    hintText: 'Search city, area or pincode...',
                    prefixIcon: Icon(Icons.search, color: AppColors.green),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (val) {
                    if (val.trim().isNotEmpty) _selectLocation(val);
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Use Current Location
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColors.greenSubtle,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.my_location, color: AppColors.green),
                ),
                title: const Text(
                  'Use current location',
                  style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy),
                ),
                subtitle: const Text('Using GPS for nearby shop discovery'),
                onTap: () => _selectLocation('Current Location'),
              ),

              const Divider(height: 32),

              const Text(
                'POPULAR SEARCH AREAS',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 12),

              Expanded(
                child: ListView.separated(
                  itemCount: _popularLocations.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final loc = _popularLocations[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.location_on_outlined, color: AppColors.textSecondary),
                      title: Text(
                        loc,
                        style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.navy),
                      ),
                      trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted),
                      onTap: () => _selectLocation(loc),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
