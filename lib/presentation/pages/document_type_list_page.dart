import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';
import 'package:gen_surat/presentation/pages/document_file/document_files_page.dart';
import 'package:gen_surat/presentation/viewmodels/generated_files_viewmodel.dart';
import 'package:get/get.dart';

class DocumentTypeListPage extends StatelessWidget {
  final String lembaga;
  final Color primaryColor;

  const DocumentTypeListPage({
    super.key,
    required this.lembaga,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<GeneratedFilesViewModel>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor.withValues(alpha: isDark ? 0.05 : 0.03),
              isDark ? Colors.black : Colors.white,
            ],
          ),
        ),
        child: Obx(() {
          if (vm.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }

          final lembagaFiles =
              vm.allFiles.where((f) => f.lembaga == lembaga).toList();

          if (lembagaFiles.isEmpty) {
            return _buildEmptyState(context);
          }

          final Map<String, int> typeCount = {};
          for (var file in lembagaFiles) {
            typeCount[file.fileType] = (typeCount[file.fileType] ?? 0) + 1;
          }

          final sortedTypes = typeCount.keys.toList()..sort();

          return RefreshIndicator(
            onRefresh: () async => vm.refreshFiles(),
            color: primaryColor,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildHeaderCard(
                  context,
                  lembagaFiles.length,
                  typeCount.length,
                ),
                const SizedBox(height: 20),

                ...sortedTypes.map((type) {
                  return _buildTypeCard(
                    context,
                    type,
                    typeCount[type]!,
                    _getColorForType(sortedTypes.indexOf(type)),
                  );
                }),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildHeaderCard(
    BuildContext context,
    int totalFiles,
    int totalTypes,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final logoPath =
        lembaga == 'IPNU'
            ? 'assets/images/logo_ipnu.png'
            : 'assets/images/logo_ippnu.png';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryColor.withValues(alpha: isDark ? 0.2 : 0.1),
            primaryColor.withValues(alpha: isDark ? 0.1 : 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Image.asset(
            logoPath,
            width: 80,
            height: 80,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                lembaga == 'IPNU' ? Icons.group : Icons.group_outlined,
                size: 60,
                color: primaryColor,
              );
            },
          ),
          const SizedBox(height: 12),
          Text(
            lembaga,
            style: AppTextStyles.headlineMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatColumn(
                Icons.description_outlined,
                totalFiles.toString(),
                'Dokumen',
              ),
              Container(
                width: 1,
                height: 50,
                color: primaryColor.withValues(alpha: 0.3),
              ),
              _buildStatColumn(
                Icons.folder_outlined,
                totalTypes.toString(),
                'Jenis',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: primaryColor, size: 32),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppTextStyles.headlineSmall.copyWith(
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: primaryColor.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildTypeCard(
    BuildContext context,
    String fileType,
    int count,
    Color cardColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () {
            Get.to(
              () => DocumentFilesPage(
                lembaga: lembaga,
                fileType: fileType,
                primaryColor: primaryColor,
              ),
              transition: Transition.rightToLeft,
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [cardColor, cardColor.withValues(alpha: 0.8)],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -20,
                  top: -20,
                  child: Icon(
                    _getIconForFileType(fileType),
                    size: 120,
                    color: AppColors.lightPrimaryVariant.withValues(alpha: 0.1),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.ipnuSecondary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          _getIconForFileType(fileType),
                          size: 36,
                          color: AppColors.lightPrimaryVariant,
                        ),
                      ),
                      const SizedBox(width: 20),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _formatTypeName(fileType),
                              style: AppTextStyles.titleMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '$count ${count == 1 ? 'dokumen' : 'dokumen'}',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: Colors.white.withValues(alpha: 0.9),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.3),
                            ),
                            child: Text(
                              count.toString(),
                              style: AppTextStyles.titleSmall.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white.withValues(alpha: 0.8),
                            size: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_open_outlined,
            size: 100,
            color: primaryColor.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 24),
          Text(
            'Belum Ada Dokumen',
            style: AppTextStyles.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Buat dokumen $lembaga untuk melihat daftar tipe surat di sini',
              style: AppTextStyles.bodyMedium.copyWith(
                color: primaryColor.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForFileType(String fileType) {
    if (fileType.contains('pengesahan')) return Icons.verified_outlined;
    if (fileType.contains('keterangan')) return Icons.assignment_outlined;
    if (fileType.contains('tugas')) return Icons.work_outline;
    if (fileType.contains('proposal')) return Icons.event_note_outlined;
    return Icons.description_outlined;
  }

  String _formatTypeName(String type) {
    return type
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  Color _getColorForType(int index) {
    final colors = [
      AppColors.documentEmerald,
      AppColors.documentTeal,
      AppColors.documentGreen,
      AppColors.documentLime,
      AppColors.documentAmber,
      AppColors.documentOrange,
      AppColors.documentCyan,
    ];
    return colors[index % colors.length];
  }
}
