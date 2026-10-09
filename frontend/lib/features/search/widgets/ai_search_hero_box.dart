import 'package:flutter/material.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/utils/responsive.dart';

/// Primary AI Search Hero Card for Screen 08
class AiSearchHeroBox extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onVoiceTap;
  final VoidCallback? onCameraTap;
  final VoidCallback? onClearTap;
  final String? selectedImageName;
  final VoidCallback? onRemoveSelectedImage;
  final bool isListening;

  const AiSearchHeroBox({
    super.key,
    required this.controller,
    this.onSubmitted,
    this.onVoiceTap,
    this.onCameraTap,
    this.onClearTap,
    this.selectedImageName,
    this.onRemoveSelectedImage,
    this.isListening = false,
  });

  @override
  State<AiSearchHeroBox> createState() => _AiSearchHeroBoxState();
}

class _AiSearchHeroBoxState extends State<AiSearchHeroBox> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChange);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChange);
    super.dispose();
  }

  void _onTextChange() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Responsive.width(context);
    final double scaleFactor = screenWidth <= 360 ? 0.9 : 1.0;
    final bool hasText = widget.controller.text.isNotEmpty;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppCorners.roundedLg,
        boxShadow: AppShadows.card,
        border: Border.all(
          color: AppColors.green.withValues(alpha: 0.35),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row with ✨ AI Search Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr('whatAreYouLookingFor'),
                      style: TextStyle(
                        color: AppColors.navy,
                        fontSize: 18 * scaleFactor,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      context.tr('findProductsNearbySub'),
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12 * scaleFactor,
                        fontWeight: FontWeight.w500,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.greenSubtle,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.auto_awesome,
                      color: AppColors.green,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'AI Search',
                      style: TextStyle(
                        color: AppColors.greenDark,
                        fontSize: 11 * scaleFactor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Selected Image Preview Badge (if image search activated)
          if (widget.selectedImageName != null && widget.selectedImageName!.isNotEmpty) ...[
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.greenSubtle,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.green.withValues(alpha: 0.4)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.image, size: 16, color: AppColors.green),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      '${context.tr('selectedImage')}: ${widget.selectedImageName}',
                      style: TextStyle(
                        color: AppColors.greenDark,
                        fontSize: 12 * scaleFactor,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  InkWell(
                    onTap: widget.onRemoveSelectedImage,
                    child: const Icon(Icons.close, size: 16, color: AppColors.greenDark),
                  ),
                ],
              ),
            ),
          ],

          // Main Interactive Search Bar Box
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: widget.isListening
                  ? AppColors.greenSubtle
                  : AppColors.background,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: widget.isListening ? AppColors.green : AppColors.border,
                width: widget.isListening ? 1.5 : 1.0,
              ),
            ),
            child: Row(
              children: [
                // LEFT: Search Icon
                const Icon(
                  Icons.search,
                  color: AppColors.navy,
                  size: 22,
                ),
                const SizedBox(width: 8),

                // CENTER: Text Input Field
                Expanded(
                  child: TextField(
                    controller: widget.controller,
                    textInputAction: TextInputAction.search,
                    style: TextStyle(
                      color: AppColors.navy,
                      fontSize: 14 * scaleFactor,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      hintText: widget.isListening
                          ? context.tr('listeningState')
                          : context.tr('searchPlaceholder'),
                      hintStyle: TextStyle(
                        color: widget.isListening
                            ? AppColors.greenDark
                            : AppColors.textMuted,
                        fontSize: 13.5 * scaleFactor,
                        fontWeight: widget.isListening ? FontWeight.w700 : FontWeight.w400,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    onSubmitted: widget.onSubmitted,
                  ),
                ),

                // Clear Text Button (X) if typing
                if (hasText) ...[
                  InkWell(
                    onTap: () {
                      widget.controller.clear();
                      if (widget.onClearTap != null) widget.onClearTap!();
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.cancel,
                        color: AppColors.textMuted,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                ],

                const SizedBox(width: 4),

                // RIGHT: Microphone Action Icon (🎙)
                Tooltip(
                  message: 'Voice Search',
                  child: InkWell(
                    onTap: widget.onVoiceTap,
                    borderRadius: BorderRadius.circular(20),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                        color: widget.isListening
                            ? AppColors.green
                            : AppColors.surface,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widget.isListening
                            ? Icons.mic
                            : Icons.mic_none_outlined,
                        color: widget.isListening
                            ? Colors.white
                            : AppColors.navy,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),

                // RIGHT: Camera Action Icon (📷)
                Tooltip(
                  message: 'Image Search',
                  child: InkWell(
                    onTap: widget.onCameraTap,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                        color: AppColors.green.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt_outlined,
                        color: AppColors.green,
                        size: 19,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
