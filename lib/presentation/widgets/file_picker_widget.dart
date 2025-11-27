import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';
import 'package:image_picker/image_picker.dart';

/// Widget untuk pick file signature/image
class FilePickerWidget extends StatelessWidget {
  final String label;
  final File? file;
  final VoidCallback onPick;
  final VoidCallback? onRemove;
  final String? errorText;

  const FilePickerWidget({
    super.key,
    required this.label,
    required this.file,
    required this.onPick,
    this.onRemove,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.labelMedium,
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: errorText != null
                  ? Colors.red
                  : file != null
                      ? AppColors.primaryColor
                      : Colors.grey.shade300,
              width: errorText != null || file != null ? 2 : 1,
            ),
          ),
          child: file == null
              ? _buildEmptyState(context)
              : _buildFilePreview(context),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 4),
          Text(
            errorText!,
            style: AppTextStyles.bodySmall.copyWith(color: Colors.red),
          ),
        ],
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return InkWell(
      onTap: onPick,
      borderRadius: BorderRadius.circular(8),
      child: Column(
        children: [
          Icon(
            Icons.upload_file,
            size: 48,
            color: AppColors.primaryColor,
          ),
          const SizedBox(height: 8),
          Text(
            'Tap untuk pilih file',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Format: PNG, JPG (Max 5MB)',
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilePreview(BuildContext context) {
    return Column(
      children: [
        // Image preview
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            file!,
            height: 150,
            width: double.infinity,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 12),
        // File info
        Text(
          file!.path.split('/').last,
          style: AppTextStyles.bodySmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 12),
        // Action buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onPick,
                icon: const Icon(Icons.edit),
                label: const Text('Ganti'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryColor,
                ),
              ),
            ),
            if (onRemove != null) ...[
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onRemove,
                  icon: const Icon(Icons.delete),
                  label: const Text('Hapus'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

/// Helper class untuk pick image
class ImagePickerHelper {
  static final ImagePicker _picker = ImagePicker();

  /// Pick image dari gallery
  static Future<File?> pickFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      debugPrint('Error picking image: $e');
      return null;
    }
  }

  /// Pick image dari camera
  static Future<File?> pickFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      debugPrint('Error taking photo: $e');
      return null;
    }
  }

  /// Show bottom sheet untuk pilih source (gallery atau camera)
  static Future<File?> pickImage(BuildContext context) async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Pilih Sumber Gambar',
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Galeri'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Kamera'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
          ],
        ),
      ),
    );

    if (source == null) return null;

    if (source == ImageSource.gallery) {
      return await pickFromGallery();
    } else {
      return await pickFromCamera();
    }
  }
}
