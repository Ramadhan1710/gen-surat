import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';
import 'package:gen_surat/core/utils/format_utils.dart';
import 'package:gen_surat/domain/entities/generated_file_entity.dart';
import 'package:gen_surat/core/helper/generated_file_helper.dart';
import 'package:gen_surat/presentation/viewmodels/generated_files_viewmodel.dart';
import 'package:intl/intl.dart';

class FileCard extends StatelessWidget {
  final GeneratedFileEntity file;
  final GeneratedFilesViewModel vm;
  final String fileType;
  final Color primaryColor;

  const FileCard({
    super.key,
    required this.file,
    required this.vm,
    required this.fileType,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final fileExists = vm.fileExists(file);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:
              fileExists
                  ? [
                    theme.colorScheme.primary.withValues(
                      alpha: isDark ? 0.1 : 0.1,
                    ),
                    theme.colorScheme.primary.withValues(
                      alpha: isDark ? 0.05 : 0.05,
                    ),
                  ]
                  : [
                    Colors.orange.withValues(alpha: isDark ? 0.2 : 0.1),
                    Colors.orange.withValues(alpha: isDark ? 0.1 : 0.05),
                  ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
              fileExists
                  ? theme.colorScheme.primary.withValues(alpha: 0.3)
                  : Colors.orange.withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: (fileExists ? theme.colorScheme.primary : Colors.orange)
                .withValues(alpha: isDark ? 0.1 : 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: fileExists ? () => vm.openFile(file) : null,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors:
                              fileExists
                                  ? [
                                    primaryColor.withValues(alpha: 0.2),
                                    primaryColor.withValues(alpha: 0.1),
                                  ]
                                  : [
                                    Colors.orange.withValues(alpha: 0.2),
                                    Colors.orange.withValues(alpha: 0.1),
                                  ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.description,
                        color:
                            fileExists
                                ? theme.colorScheme.primary
                                : Colors.orange,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 16),

                    Expanded(
                      child: Text(
                        file.fileName,
                        style: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    PopupMenuButton<String>(
                      onSelected: (value) async {
                        if (value == 'open') {
                          vm.openFile(file);
                        } else if (value == 'share') {
                          vm.shareFile(file);
                        } else if (value == 'delete') {
                          _showDeleteConfirmation(context, file, vm);
                        } else if (value == 'info') {
                          _showFileInfo(context, file);
                        }
                      },
                      icon: Icon(
                        Icons.more_vert,
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
                      itemBuilder:
                          (context) => [
                            if (fileExists) ...[
                              PopupMenuItem(
                                value: 'open',
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.open_in_new,
                                      size: 20,
                                      color: primaryColor,
                                    ),
                                    const SizedBox(width: 12),
                                    const Text('Buka'),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'share',
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.share,
                                      size: 20,
                                      color: primaryColor,
                                    ),
                                    const SizedBox(width: 12),
                                    const Text('Bagikan'),
                                  ],
                                ),
                              ),
                            ],
                            const PopupMenuItem(
                              value: 'info',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    size: 20,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(width: 12),
                                  Text('Info'),
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete,
                                    size: 20,
                                    color: Colors.red,
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    'Hapus',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  children: [
                    _buildMetaChip(
                      Icons.storage,
                      GeneratedFileHelper.getFormattedSize(file),
                      isDark,
                    ),
                    _buildMetaChip(
                      Icons.access_time,
                      GeneratedFileHelper.getFormattedDate(file),
                      isDark,
                    ),
                  ],
                ),

                if (!fileExists) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.orange.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.warning_amber_rounded,
                          size: 18,
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'File tidak ditemukan di penyimpanan',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Colors.orange[800],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMetaChip(IconData icon, String label, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color:
            isDark
                ? AppColors.darkPrimary.withValues(alpha: 0.1)
                : primaryColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: primaryColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: primaryColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: isDark ? Colors.grey[300] : Colors.grey[800],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    GeneratedFileEntity file,
    GeneratedFilesViewModel vm,
  ) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: isDark ? theme.colorScheme.surface : Colors.white,
            title: Row(
              children: [
                const Icon(Icons.delete_outline, color: Colors.red),
                const SizedBox(width: 12),
                Text(
                  'Hapus Dokumen',
                  style: AppTextStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            content: Text(
              'Apakah Anda yakin ingin menghapus "${file.fileName}"? Tindakan ini tidak dapat dibatalkan.',
              style: AppTextStyles.bodySmall,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Batal',
                  style: TextStyle(
                    color: isDark ? Colors.grey[400] : Colors.grey[700],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  vm.deleteFile(file);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Hapus'),
              ),
            ],
          ),
    );
  }

  void _showFileInfo(BuildContext context, GeneratedFileEntity file) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: theme.colorScheme.surface,
            title: Row(
              children: [
                Icon(Icons.info_outline, color: primaryColor),
                const SizedBox(width: 12),
                Text(
                  'Informasi Dokumen',
                  style: AppTextStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('Nama File', file.fileName),
                  const Divider(height: 24),
                  _buildInfoRow(
                    'Tipe Dokumen',
                    FormatUtils.formatTypeName(fileType),
                  ),
                  const Divider(height: 24),
                  _buildInfoRow('Lembaga', file.lembaga),
                  if (file.namaLembaga != null) ...[
                    const Divider(height: 24),
                    _buildInfoRow('Nama Desa/Sekolah', file.namaLembaga!),
                  ],
                  if (file.nomorSurat != null) ...[
                    const Divider(height: 24),
                    _buildInfoRow('Nomor Surat', file.nomorSurat!),
                  ],
                  const Divider(height: 24),
                  _buildInfoRow(
                    'Ukuran File',
                    GeneratedFileHelper.getFormattedSize(file),
                  ),
                  const Divider(height: 24),
                  _buildInfoRow(
                    'Tanggal Dibuat',
                    DateFormat(
                      'dd MMMM yyyy, HH:mm',
                      'id_ID',
                    ).format(file.createdAt),
                  ),
                  const Divider(height: 24),
                  _buildInfoRow('Lokasi', file.filePath, isPath: true),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(foregroundColor: primaryColor),
                child: const Text('Tutup'),
              ),
            ],
          ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isPath = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.labelMedium.copyWith(
            color: AppColors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        isPath
            ? SelectableText(
              value,
              style: AppTextStyles.bodySmall.copyWith(fontFamily: 'monospace'),
            )
            : Text(value, style: AppTextStyles.bodyMedium),
      ],
    );
  }
}
