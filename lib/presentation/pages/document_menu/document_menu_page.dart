import 'package:flutter/material.dart';
import 'package:gen_surat/core/enums/document_type.dart';
import 'package:gen_surat/core/enums/user_role.dart';
import 'package:gen_surat/core/extensions/document_type_extension.dart';
import 'package:gen_surat/core/extensions/user_role_extension.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';
import 'package:gen_surat/presentation/pages/document_menu/models/document_item.dart';
import 'package:gen_surat/presentation/pages/document_menu/widgets/document_type_list.dart';
import 'package:gen_surat/presentation/viewmodels/auth/auth_viewmodel.dart';
import 'package:get/get.dart';

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

    UserRole role = Get.find<AuthViewModel>().userRoleEnum;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Jenis Administrasi'),
        elevation: 0,
        // bottom: _buildTabBar(isDark, theme),
      ),
      body: _buildMenuGrid(role.accessibleDocumentTypes, isDark),
    );
  }

  // build menu administrasi dengan grid view
  Widget _buildMenuGrid(List<DocumentType> documentTypes, bool isDark) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.7,
      ),
      itemCount: documentTypes.length,
      itemBuilder: (context, index) {
        final docType = documentTypes[index];
        return _buildMenuItem(
          docType.label,
          docType.documents,
          docType.icon(context),
          isDark,
        );
      },
    );
  }

  Widget _buildMenuItem(
    String docType,
    List<DocumentItem> documentItem,
    Widget icon,
    bool isDark,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Get.to(
              () => DocumentTypeList(
                lembaga: docType,
                color: Theme.of(context).colorScheme.primary,
                documents: documentItem,
              ),
            );
          },
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: isDark 
                  ? Theme.of(context).colorScheme.surface
                  : Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(12),
            child: icon,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          docType,
          textAlign: TextAlign.center,
          style: AppTextStyles.labelSmall.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 9,
          ),
        ),
      ],
    );
  }
}
