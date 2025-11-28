import 'package:flutter/material.dart';
import 'package:gen_surat/core/utils/format_utils.dart';
import 'package:gen_surat/presentation/pages/document_type/widgets/header_card.dart';
import 'package:gen_surat/presentation/pages/document_type/widgets/type_card.dart';
import 'package:gen_surat/presentation/viewmodels/generated_files_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/state/empty_state.dart';
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:
                isDark
                    ? [theme.colorScheme.surface, theme.colorScheme.surface]
                    : [
                      theme.colorScheme.primary.withValues(alpha: 0.03),
                      theme.colorScheme.surface,
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
            return EmptyState(
              title: 'Belum Ada Dokumen',
              message:
                  'Buat dokumen $lembaga untuk melihat daftar tipe surat di sini',
              primaryColor: primaryColor,
            );
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
                HeaderCard(
                  totalFiles: lembagaFiles.length,
                  totalTypes: typeCount.length,
                  lembaga: lembaga,
                ),

                const SizedBox(height: 20),

                ...sortedTypes.map((type) {
                  return TypeCard(
                    fileType: type,
                    count: typeCount[type]!,
                    lembaga: lembaga,
                    cardColor: FormatUtils.getColorForType(
                      sortedTypes.indexOf(type),
                    ),
                  );
                }),
              ],
            ),
          );
        }),
      ),
    );
  }
}
