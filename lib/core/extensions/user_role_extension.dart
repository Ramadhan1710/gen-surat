import 'package:gen_surat/core/enums/document_type.dart';
import 'package:gen_surat/core/enums/user_role.dart';

extension UserRoleExtension on UserRole {
  String get label {
    switch (this) {
      case UserRole.admin:
        return 'Admin';
      case UserRole.pengurus:
        return 'Pengurus';
      case UserRole.anggota:
        return 'Anggota';
      case UserRole.ranting:
        return 'Ranting';
      case UserRole.sekretaris:
        return 'Sekretaris';
    }
  }

  String get route {
    switch (this) {
      case UserRole.admin:
        return '/adminHome';
      case UserRole.pengurus:
        return '/pengurusHome';
      case UserRole.anggota:
        return '/anggotaHome';
      case UserRole.ranting:
        return '/rantingHome';
      case UserRole.sekretaris:
        return '/sekretarisHome';
    }
  }

  List<DocumentType> get accessibleDocumentTypes {
    switch (this) {
      case UserRole.admin:
      case UserRole.pengurus:
      case UserRole.anggota:
        return DocumentType.values;
      case UserRole.ranting:
        return [DocumentType.spIpnu, DocumentType.spIppnu];
      case UserRole.sekretaris:
        return [
          DocumentType.join,
          DocumentType.event,
          DocumentType.ipnu,
          DocumentType.ippnu,
          DocumentType.spIpnu,
          DocumentType.spIppnu,
        ];
    }
  }
}
