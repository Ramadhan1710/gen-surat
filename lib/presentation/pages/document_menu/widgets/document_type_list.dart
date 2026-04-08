import 'package:flutter/material.dart';
import 'package:gen_surat/presentation/pages/document_menu/models/document_item.dart';
import 'package:gen_surat/presentation/pages/document_menu/widgets/document_type_card.dart';

class DocumentTypeList extends StatelessWidget {
  final String lembaga;
  final Color color;
  final List<DocumentItem> documents;

  const DocumentTypeList({
    super.key,
    required this.lembaga,
    required this.color,
    required this.documents,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Jenis Dokumen'),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:
                isDark
                    ? [theme.colorScheme.surface, theme.colorScheme.surface]
                    : [
                      color.withValues(alpha: 0.05),
                      theme.scaffoldBackgroundColor,
                    ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          children: [
            ...documents.map((doc) => DocumentTypeCard(documentItem: doc)),
          ],
        ),
      ),
    );
  }
}
