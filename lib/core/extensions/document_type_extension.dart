import 'package:flutter/material.dart';
import 'package:gen_surat/core/constants/document_constants.dart';
import 'package:gen_surat/core/enums/document_type.dart';
import 'package:gen_surat/presentation/pages/document_menu/models/document_item.dart';

extension DocumentTypeExtension on DocumentType {
  String get label {
    switch (this) {
      case DocumentType.join:
        return 'Surat Bersama';
      case DocumentType.event:
        return 'Surat Kegiatan';
      case DocumentType.ipnu:
        return 'Surat Khusus IPNU';
      case DocumentType.ippnu:
        return 'Surat Khusus IPPNU';
      case DocumentType.spIpnu:
        return 'Pengajuan SP Ranting IPNU';
      case DocumentType.spIppnu:
        return 'Pengajuan SP Ranting IPPNU';
    }
  }

  List<DocumentItem> get documents {
    switch (this) {
      case DocumentType.join:
        return DocumentConstants.getJoinDocuments;
      case DocumentType.event:
        return DocumentConstants.getEventDocuments;
      case DocumentType.ipnu:
        return DocumentConstants.getDocumentsIpnu;
      case DocumentType.ippnu:
        return DocumentConstants.getDocumentsIppnu;
      case DocumentType.spIpnu:
        return DocumentConstants.getDocumentsSpIpnu;
      case DocumentType.spIppnu:
        return DocumentConstants.getDocumentsSpIppnu;
    }
  }

  Widget icon (BuildContext context) {
    switch (this) {
      case DocumentType.join:
        return Icon(Icons.groups, size: 40, color: Theme.of(context).colorScheme.primary);
      case DocumentType.event:
        return Icon(Icons.event_note, size: 40, color: Theme.of(context).colorScheme.primary);
      case DocumentType.ipnu:
        return Image.asset('assets/images/logo_ipnu.png', width: 24, height: 24);
      case DocumentType.ippnu:
        return Image.asset('assets/images/logo_ippnu.png', width: 24, height: 24);
      case DocumentType.spIpnu:
        return Icon(Icons.description, size: 40, color: Theme.of(context).colorScheme.primary);
      case DocumentType.spIppnu:
        return Icon(Icons.description, size: 40, color: Theme.of(context).colorScheme.primary);
    }
  }
}
