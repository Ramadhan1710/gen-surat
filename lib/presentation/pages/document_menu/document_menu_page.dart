import 'package:flutter/material.dart';
import 'package:gen_surat/core/constants/document_constants.dart';
import 'package:gen_surat/core/constants/image_constants.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';
import 'package:gen_surat/presentation/pages/document_menu/widgets/document_type_list.dart';

class DocumentMenuPage extends StatefulWidget {
  const DocumentMenuPage({super.key});

  @override
  State<DocumentMenuPage> createState() => _DocumentMenuPageState();
}

class _DocumentMenuPageState extends State<DocumentMenuPage>
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Jenis Administrasi'),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            decoration: BoxDecoration(
              color:
                  isDark
                      ? theme.colorScheme.surface
                      : theme.colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
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
                      ? theme.colorScheme.primary.withValues(alpha: 0.7)
                      : Colors.white,
              labelStyle: AppTextStyles.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
                color:
                    isDark
                        ? theme.colorScheme.primary.withValues(alpha: 0.7)
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
        children: [
          DocumentTypeList(
            lembaga: 'IPNU',
            logoPath: ImageConstants.logoIpnu,
            color: Theme.of(context).colorScheme.primary,
            documents: DocumentConstants.getDocumentsIpnu,
          ),

          DocumentTypeList(
            lembaga: 'IPPNU',
            logoPath: ImageConstants.logoIppnu,
            color: Theme.of(context).colorScheme.primary,
            documents: DocumentConstants.getDocumentsIppnu,
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
