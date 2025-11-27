import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';
import 'package:gen_surat/core/utils/format_utils.dart';
import 'package:gen_surat/presentation/pages/document_file/widgets/file_card.dart';
import 'package:gen_surat/presentation/pages/document_file/widgets/stats_card.dart';
import 'package:gen_surat/presentation/viewmodels/generated_files_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/state/empty_state.dart';
import 'package:get/get.dart';

class DocumentFilesPage extends StatelessWidget {
  final String lembaga;
  final String fileType;
  final Color primaryColor;

  const DocumentFilesPage({
    super.key,
    required this.lembaga,
    required this.fileType,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<GeneratedFilesViewModel>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              FormatUtils.formatTypeName(fileType),
              style: AppTextStyles.titleMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              lembaga,
              style: AppTextStyles.bodySmall.copyWith(
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
          ],
        ),
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, primaryColor.withValues(alpha: 0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: vm.refreshFiles,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark ? [
              theme.colorScheme.surface,
              theme.scaffoldBackgroundColor,
            ] : [
              primaryColor.withValues(alpha: 0.03),
              Colors.white,
            ],
          ),
        ),
        child: Obx(() {
          if (vm.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }

          final files =
              vm.allFiles
                  .where((f) => f.lembaga == lembaga && f.fileType == fileType)
                  .toList();

          files.sort((a, b) => b.createdAt.compareTo(a.createdAt));

          if (files.isEmpty) {
            return EmptyState(
              title: 'Belum Ada Dokumen',
              message:
                  'Belum ada dokumen ${FormatUtils.formatTypeName(fileType)} yang dibuat',
              primaryColor: primaryColor,
            );
          }

          return RefreshIndicator(
            onRefresh: () async => vm.refreshFiles(),
            color: primaryColor,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                StatsCard(
                  files: files,
                  fileType: fileType,
                ),
                const SizedBox(height: 20),

                ...files.map(
                  (file) => FileCard(
                    file: file,
                    vm: vm,
                    fileType: fileType,
                    primaryColor: primaryColor,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
