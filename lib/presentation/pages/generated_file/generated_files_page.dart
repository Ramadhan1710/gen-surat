import 'package:flutter/material.dart';
import 'package:gen_surat/core/constants/image_constants.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';
import 'package:gen_surat/presentation/pages/document_type/document_type_list_page.dart';
import 'package:gen_surat/presentation/viewmodels/generated_files_viewmodel.dart';
import 'package:get/get.dart';

class GeneratedFilesPage extends StatefulWidget {
  const GeneratedFilesPage({super.key});

  @override
  State<GeneratedFilesPage> createState() => _GeneratedFilesPageState();
}

class _GeneratedFilesPageState extends State<GeneratedFilesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() { 
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<GeneratedFilesViewModel>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('File Tersimpan'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: vm.refreshFiles,
            tooltip: 'Refresh',
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            decoration: BoxDecoration(
              color:
                  isDark
                      ? AppColors.ipnuPrimary.withValues(alpha: 0.1)
                      : AppColors.ipnuPrimary,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.ipnuSecondary,
                    AppColors.ipnuSecondary.withValues(alpha: 0.7),
                  ],
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              dividerHeight: 0,
              labelColor: Colors.white,
              unselectedLabelColor:
                  isDark
                      ? AppColors.ipnuPrimary.withValues(alpha: 0.7)
                      : Colors.white,
              labelStyle: AppTextStyles.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
                color:
                    isDark
                        ? AppColors.ipnuPrimary.withValues(alpha: 0.7)
                        : Colors.white,
              ),
              tabs: [
                _buildTab(label: 'IPNU', logoPath: ImageConstants.logoIpnu),
                _buildTab(label: 'IPPNU', logoPath: ImageConstants.logoIppnu),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          DocumentTypeListPage(
            lembaga: 'IPNU',
            primaryColor: AppColors.ipnuPrimary,
          ),
          DocumentTypeListPage(
            lembaga: 'IPPNU',
            primaryColor: AppColors.ippnuPrimary,
          ),
        ],
      ),
    );
  }

  Widget _buildTab({required String label, required String logoPath}) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            logoPath,
            width: 24,
            height: 24,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.account_balance, size: 24);
            },
          ),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}
