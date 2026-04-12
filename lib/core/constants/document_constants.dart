import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:gen_surat/presentation/pages/document_menu/models/document_item.dart';
import 'package:gen_surat/presentation/routes/route_names.dart';

class DocumentConstants {
  static List<DocumentItem> get getJoinDocuments => [
    DocumentItem(
      title: 'Surat Permohonan Pemateri',
      description: 'Pembuatan surat permohonan pemateri',
      icon: Icons.record_voice_over,
      route: RouteNames.suratPermohonanPemateri,
      isAvailable: true,
      gradient: AppColors.primaryGradient,
    ),
    DocumentItem(
      title: 'Surat Permohonan Peminjaman Alat',
      description: 'Pembuatan surat peminjaman alat',
      icon: Icons.build,
      route: RouteNames.suratPermohonanPeminjamanAlat,
      isAvailable: true,
      gradient: AppColors.primaryGradient,
    ),
    DocumentItem(
      title: 'Surat Permohonan Izin Tempat',
      description: 'Pembuatan surat izin tempat',
      icon: Icons.location_on,
      route: RouteNames.suratPermohonanIzinTempatBersama,
      isAvailable: true,
      gradient: AppColors.primaryGradient,
    ),
    DocumentItem(
      title: 'Surat Pemberitahuan',
      description: 'Pembuatan surat pemberitahuan',
      icon: Icons.notifications,
      route: RouteNames.suratPemberitahuanBersama,
      isAvailable: true,
      gradient: AppColors.primaryGradient,
    ),
    DocumentItem(
      title: 'Surat Undangan',
      description: 'Pembuatan surat undangan',
      icon: Icons.mail,
      route: RouteNames.suratUndanganBersama,
      isAvailable: true,
      gradient: AppColors.primaryGradient,
    ),
    DocumentItem(
      title: 'Surat Dispensasi',
      description: 'Pembuatan surat dispensasi',
      icon: Icons.description,
      route: RouteNames.suratDispensasi,
      isAvailable: true,
      gradient: AppColors.primaryGradient,
    ),
    DocumentItem(
      title: 'Surat Permohonan Konsumsi',
      description: 'Pembuatan surat permohonan konsumsi',
      icon: Icons.restaurant,
      route: RouteNames.suratPermohonanKonsumsiBersama,
      isAvailable: true,
      gradient: AppColors.primaryGradient,
    ),
  ];

  static List<DocumentItem> get getEventDocuments => [];

  static List<DocumentItem> get getDocumentsIpnu => [];

  static List<DocumentItem> get getDocumentsIppnu => [];

  static List<DocumentItem> get getDocumentsSpIpnu => [
    DocumentItem(
      title: 'Surat Permohonan Pengesahan',
      description: 'Pembuatan surat permohonan pengesahan',
      icon: Icons.description,
      route: RouteNames.suratPermohonanPengesahanIpnu,
      isAvailable: true,
      gradient: [AppColors.ipnuPrimaryLight, AppColors.ipnuPrimaryDark],
    ),
    DocumentItem(
      title: 'Surat Keputusan',
      description: 'Pembuatan surat keputusan Rapat Anggota',
      icon: Icons.gavel,
      route: RouteNames.suratKeputusanIpnu,
      isAvailable: true,
      gradient: [AppColors.ipnuPrimaryLight, AppColors.ipnuPrimaryDark],
    ),
    DocumentItem(
      title: 'Berita Acara Pemilihan Ketua',
      description: 'Pembuatan dokumen Berita acara pemilihan ketua',
      icon: Icons.event,
      route: RouteNames.beritaAcaraPemilihanKetuaIpnu,
      isAvailable: true,
      gradient: [AppColors.ipnuPrimaryLight, AppColors.ipnuPrimaryDark],
    ),
    DocumentItem(
      title: 'Susunan Pengurus',
      description: 'Pembuatan Susunan kepengurusan IPNU',
      icon: Icons.groups,
      route: RouteNames.susunanPengurusIpnu,
      isAvailable: true,
      gradient: [AppColors.ipnuPrimaryLight, AppColors.ipnuPrimaryDark],
    ),
    DocumentItem(
      title: 'Curriculum Vitae',
      description: 'Pembuatan CV untuk Ketua, Sekretaris, dan Bendahara IPNU',
      icon: Icons.person,
      route: RouteNames.curriculumVitaeIpnu,
      isAvailable: true,
      gradient: [AppColors.ipnuPrimaryLight, AppColors.ipnuPrimaryDark],
    ),
    DocumentItem(
      title: 'Kartu Identitas',
      description:
          'Pembuatan dokumen upload kartu identitas Ketua, Sekretaris, dan Bendahara IPNU',
      icon: Icons.credit_card,
      route: RouteNames.kartuIdentitasIpnu,
      isAvailable: true,
      gradient: [AppColors.ipnuPrimaryLight, AppColors.ipnuPrimaryDark],
    ),
    DocumentItem(
      title: 'Sertifikat Kaderisasi',
      description:
          'Pembuatan dokumen upload sertifikat kaderisasi Ketua, Sekretaris, dan Bendahara IPNU',
      icon: Icons.workspace_premium,
      route: RouteNames.sertifikatKaderisasiIpnu,
      isAvailable: true,
      gradient: [AppColors.ipnuPrimaryLight, AppColors.ipnuPrimaryDark],
    ),
    DocumentItem(
      title: 'Berita Acara Rapat Formatur',
      description:
          'Pembuatan dokumen berita acara rapat formatur untuk pembentukan pengurus',
      icon: Icons.note,
      route: RouteNames.beritaAcaraRapatFormaturIpnu,
      isAvailable: true,
      gradient: [AppColors.ipnuPrimaryLight, AppColors.ipnuPrimaryDark],
    ),
  ];

  static List<DocumentItem> get getDocumentsSpIppnu => [
    DocumentItem(
      title: 'Surat Permohonan Pengesahan',
      description: 'Pembuatan surat permohonan pengesahan',
      icon: Icons.description,
      route: RouteNames.suratPermohonanPengesahanIppnu,
      isAvailable: true,
      gradient: [AppColors.ippnuPrimaryLight, AppColors.ippnuPrimaryDark],
    ),
    DocumentItem(
      title: 'Surat Keputusan',
      description: 'Pembuatan surat keputusan Rapat Anggota',
      icon: Icons.gavel,
      route: RouteNames.suratKeputusanIppnu,
      isAvailable: true,
      gradient: [AppColors.ippnuPrimaryLight, AppColors.ippnuPrimaryDark],
    ),
    DocumentItem(
      title: 'Berita Acara Pemilihan Ketua',
      description: 'Pembuatan dokumen Berita acara pemilihan ketua',
      icon: Icons.event,
      route: RouteNames.beritaAcaraPemilihanKetuaIppnu,
      isAvailable: true,
      gradient: [AppColors.ippnuPrimaryLight, AppColors.ippnuPrimaryDark],
    ),
    DocumentItem(
      title: 'Susunan Pengurus',
      description: 'Pembuatan Susunan kepengurusan IPPNU',
      icon: Icons.groups,
      route: RouteNames.susunanPengurusIppnu,
      isAvailable: true,
      gradient: [AppColors.ippnuPrimaryLight, AppColors.ippnuPrimaryDark],
    ),
    DocumentItem(
      title: 'Curriculum Vitae',
      description: 'Pembuatan CV untuk Ketua, Sekretaris, dan Bendahara IPPNU',
      icon: Icons.person,
      route: RouteNames.curriculumVitaeIppnu,
      isAvailable: true,
      gradient: [AppColors.ippnuPrimaryLight, AppColors.ippnuPrimaryDark],
    ),
    DocumentItem(
      title: 'Kartu Identitas',
      description:
          'Pembuatan dokumen upload kartu identitas Ketua, Sekretaris, dan Bendahara IPPNU',
      icon: Icons.credit_card,
      route: RouteNames.kartuIdentitasIppnu,
      isAvailable: true,
      gradient: [AppColors.ippnuPrimaryLight, AppColors.ippnuPrimaryDark],
    ),
    DocumentItem(
      title: 'Sertifikat Kaderisasi',
      description:
          'Pembuatan dokumen upload sertifikat kaderisasi Ketua, Sekretaris, dan Bendahara IPPNU',
      icon: Icons.workspace_premium,
      route: RouteNames.sertifikatKaderisasiIppnu,
      isAvailable: true,
      gradient: [AppColors.ippnuPrimaryLight, AppColors.ippnuPrimaryDark],
    ),
    DocumentItem(
      title: 'Berita Acara Formatur Pembentukan Pengurus Harian',
      description:
          'Pembuatan dokumen berita acara rapat formatur untuk pembentukan pengurus harian oleh tim formatur',
      icon: Icons.assignment_turned_in,
      route: RouteNames.beritaAcaraFormaturPembentukanPengurusHarianIppnu,
      isAvailable: true,
      gradient: [AppColors.ippnuPrimaryLight, AppColors.ippnuPrimaryDark],
    ),
    DocumentItem(
      title: 'Berita Acara Penyusunan Pengurus',
      description:
          'Pembuatan dokumen berita acara hasil penyusunan kepengurusan lengkap oleh pengurus harian',
      icon: Icons.description_outlined,
      route: RouteNames.beritaAcaraPenyusunanPengurusIppnu,
      isAvailable: true,
      gradient: [AppColors.ippnuPrimaryLight, AppColors.ippnuPrimaryDark],
    ),
  ];
}
