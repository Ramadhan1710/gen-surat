import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:gen_surat/presentation/pages/document_menu/models/document_item.dart';
import 'package:gen_surat/presentation/routes/route_names.dart';

class DocumentConstants {
  static List<DocumentItem> get getDocumentsIpnu => [
    DocumentItem(
      title: 'Surat Permohonan Pengesahan',
      description: 'Pengajuan surat pengesahan untuk kepengurusan IPNU',
      icon: Icons.description,
      route: RouteNames.suratPermohonanPengesahanIpnu,
      isAvailable: true,
      gradient: [AppColors.ipnuPrimaryLight, AppColors.ipnuPrimaryDark],
    ),
    DocumentItem(
      title: 'Surat Keputusan',
      description: 'Pembuatan surat keputusan untuk kepengurusan IPNU',
      icon: Icons.gavel,
      route: RouteNames.suratKeputusanIpnu,
      isAvailable: true,
      gradient: [AppColors.ipnuAccentLight, AppColors.ipnuAccent],
    ),
    DocumentItem(
      title: 'Surat Keterangan',
      description: 'Surat keterangan untuk keperluan administrasi',
      icon: Icons.assignment,
      route: RouteNames.suratKeteranganIpnu,
      isAvailable: false,
      gradient: [AppColors.ipnuSecondaryLight, AppColors.ipnuSecondary],
    ),
    DocumentItem(
      title: 'Surat Tugas',
      description: 'Pembuatan surat tugas kegiatan IPNU',
      icon: Icons.work,
      route: RouteNames.suratTugasIpnu,
      isAvailable: false,
      gradient: [AppColors.ipnuAccentLight, AppColors.ipnuAccent],
    ),
    DocumentItem(
      title: 'Proposal Kegiatan',
      description: 'Template proposal untuk kegiatan IPNU',
      icon: Icons.event_note,
      route: RouteNames.proposalIpnu,
      isAvailable: false,
      gradient: [AppColors.documentTeal, AppColors.documentCyan],
    ),
  ];

  static List<DocumentItem> get getDocumentsIppnu => [
    DocumentItem(
      title: 'Surat Permohonan Pengesahan',
      description: 'Pengajuan surat pengesahan untuk kepengurusan IPPNU',
      icon: Icons.description,
      route: RouteNames.suratPermohonanPengesahanIppnu,
      isAvailable: false,
      gradient: [AppColors.ippnuPrimaryLight, AppColors.ippnuPrimaryDark],
    ),
    DocumentItem(
      title: 'Surat Keterangan',
      description: 'Surat keterangan untuk keperluan administrasi',
      icon: Icons.assignment,
      route: RouteNames.suratKeteranganIppnu,
      isAvailable: false,
      gradient: [AppColors.ippnuSecondaryLight, AppColors.ippnuSecondary],
    ),
    DocumentItem(
      title: 'Surat Tugas',
      description: 'Pembuatan surat tugas kegiatan IPPNU',
      icon: Icons.work,
      route: RouteNames.suratTugasIppnu,
      isAvailable: false,
      gradient: [AppColors.ippnuAccentLight, AppColors.ippnuAccent],
    ),
    DocumentItem(
      title: 'Proposal Kegiatan',
      description: 'Template proposal untuk kegiatan IPPNU',
      icon: Icons.event_note,
      route: RouteNames.proposalIppnu,
      isAvailable: false,
      gradient: [AppColors.documentGreen, AppColors.documentLime],
    ),
  ];
}
