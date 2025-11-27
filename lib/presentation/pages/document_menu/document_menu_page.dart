import 'package:flutter/material.dart';
import 'package:gen_surat/core/constants/document_constants.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';
import 'package:gen_surat/presentation/pages/document_menu/models/document_item.dart';
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
                      ? AppColors.ipnuPrimary.withValues(alpha: 0.7)
                      : Colors.white,
              labelStyle: AppTextStyles.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
                color:
                    isDark
                        ? AppColors.ipnuPrimary.withValues(alpha: 0.7)
                        : Colors.white,
              ),
              tabs: const [Tab(text: 'IPNU'), Tab(text: 'IPPNU')],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          DocumentTypeList(
            lembaga: 'IPNU',
            color: AppColors.ipnuPrimary,
            documents: DocumentConstants.getDocumentsIpnu,
          ),

          DocumentTypeList(
            lembaga: 'IPPNU',
            color: AppColors.ippnuPrimary,
            documents: DocumentConstants.getDocumentsIppnu,
          ),
        ],
      ),
    );
  }
}
