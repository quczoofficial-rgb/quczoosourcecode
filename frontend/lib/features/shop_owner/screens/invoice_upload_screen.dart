import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';

/// SCREEN 41 — INVOICE UPLOAD SCREEN
class InvoiceUploadScreen extends StatelessWidget {
  const InvoiceUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Upload Supplier Invoice', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.navy,
        elevation: 0.5,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Snap or upload paper distributor invoice to extract product inventory automatically.', style: TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 20),

              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppCorners.roundedMd,
                  border: Border.all(color: AppColors.green, width: 1.5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.document_scanner_outlined, color: AppColors.green, size: 44),
                    SizedBox(height: 10),
                    Text('Select Invoice Image / PDF', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invoice parsed: 12 products added to draft stock.')));
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: AppCorners.roundedMd),
                ),
                child: const Text('Upload & Extract Stock', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
