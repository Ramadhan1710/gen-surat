import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gen_surat/data/models/ipnu/curriculum_vitae_model.dart';

class CurriculumVitaeFormDataManager {
  // Form Controllers - Informasi Lembaga
  final jenisLembagaController = TextEditingController();
  final namaLembagaController = TextEditingController();
  final periodeKepengurusanController = TextEditingController();

  // Focus nodes - Informasi Lembaga
  final jenisLembagaFocus = FocusNode();
  final namaLembagaFocus = FocusNode();
  final periodeKepengurusanFocus = FocusNode();

  // Form Controllers - Data Ketua
  final namaKetuaController = TextEditingController();
  final ttlKetuaController = TextEditingController();
  final niaKetuaController = TextEditingController();
  final alamatKetuaController = TextEditingController();
  final mottoKetuaController = TextEditingController();
  final nomorHpKetuaController = TextEditingController();
  final emailKetuaController = TextEditingController();
  final noOrganizationKetuaController = TextEditingController();
  String? fotoKetuaPath;
  bool hasNoOrganizationKetua = false;

  // Focus nodes - Data Ketua
  final namaKetuaFocus = FocusNode();
  final ttlKetuaFocus = FocusNode();
  final niaKetuaFocus = FocusNode();
  final alamatKetuaFocus = FocusNode();
  final mottoKetuaFocus = FocusNode();
  final nomorHpKetuaFocus = FocusNode();
  final emailKetuaFocus = FocusNode();

  // Form Controllers - Data Sekretaris
  final namaSekretarisController = TextEditingController();
  final ttlSekretarisController = TextEditingController();
  final niaSekretarisController = TextEditingController();
  final alamatSekretarisController = TextEditingController();
  final mottoSekretarisController = TextEditingController();
  final nomorHpSekretarisController = TextEditingController();
  final emailSekretarisController = TextEditingController();
  final noOrganizationSekretarisController = TextEditingController();
  String? fotoSekretarisPath;
  bool hasNoOrganizationSekretaris = false;

  // Focus nodes - Data Sekretaris
  final namaSekretarisFocus = FocusNode();
  final ttlSekretarisFocus = FocusNode();
  final niaSekretarisFocus = FocusNode();
  final alamatSekretarisFocus = FocusNode();
  final mottoSekretarisFocus = FocusNode();
  final nomorHpSekretarisFocus = FocusNode();
  final emailSekretarisFocus = FocusNode();

  // Form Controllers - Data Bendahara
  final namaBendaharaController = TextEditingController();
  final ttlBendaharaController = TextEditingController();
  final niaBendaharaController = TextEditingController();
  final alamatBendaharaController = TextEditingController();
  final mottoBendaharaController = TextEditingController();
  final nomorHpBendaharaController = TextEditingController();
  final emailBendaharaController = TextEditingController();
  String? fotoBendaharaPath;
  bool hasNoOrganizationBendahara = false;

  // Focus nodes - Data Bendahara
  final namaBendaharaFocus = FocusNode();
  final ttlBendaharaFocus = FocusNode();
  final niaBendaharaFocus = FocusNode();
  final alamatBendaharaFocus = FocusNode();
  final mottoBendaharaFocus = FocusNode();
  final nomorHpBendaharaFocus = FocusNode();
  final emailBendaharaFocus = FocusNode();

  // Dynamic Lists
  final List<Map<String, TextEditingController>> organisasiKetuaList = [];
  final List<Map<String, TextEditingController>> pendidikanKetuaList = [];
  final List<Map<String, TextEditingController>> organisasiSekretarisList = [];
  final List<Map<String, TextEditingController>> pendidikanSekretarisList = [];
  final List<Map<String, TextEditingController>> organisasiBendaharaList = [];
  final List<Map<String, TextEditingController>> pendidikanBendaharaList = [];

  // Getters
  String get jenisLembaga => jenisLembagaController.text.trim();
  String get namaLembaga => namaLembagaController.text.trim();
  String get periodeKepengurusan => periodeKepengurusanController.text.trim();

  // ========== Organisasi Ketua Management ==========
  void addOrganisasiKetua() {
    organisasiKetuaList.add({'nama': TextEditingController()});
  }

  void removeOrganisasiKetua(int index) {
    if (index >= 0 && index < organisasiKetuaList.length) {
      organisasiKetuaList[index]['nama']?.dispose();
      organisasiKetuaList.removeAt(index);
    }
  }

  // ========== Pendidikan Ketua Management ==========
  void addPendidikanKetua() {
    pendidikanKetuaList.add({
      'tingkat': TextEditingController(),
      'nama': TextEditingController(),
    });
  }

  void removePendidikanKetua(int index) {
    if (index >= 0 && index < pendidikanKetuaList.length) {
      pendidikanKetuaList[index]['tingkat']?.dispose();
      pendidikanKetuaList[index]['nama']?.dispose();
      pendidikanKetuaList.removeAt(index);
    }
  }

  // ========== Organisasi Sekretaris Management ==========
  void addOrganisasiSekretaris() {
    organisasiSekretarisList.add({'nama': TextEditingController()});
  }

  void removeOrganisasiSekretaris(int index) {
    if (index >= 0 && index < organisasiSekretarisList.length) {
      organisasiSekretarisList[index]['nama']?.dispose();
      organisasiSekretarisList.removeAt(index);
    }
  }

  // ========== Pendidikan Sekretaris Management ==========
  void addPendidikanSekretaris() {
    pendidikanSekretarisList.add({
      'tingkat': TextEditingController(),
      'nama': TextEditingController(),
    });
  }

  void removePendidikanSekretaris(int index) {
    if (index >= 0 && index < pendidikanSekretarisList.length) {
      pendidikanSekretarisList[index]['tingkat']?.dispose();
      pendidikanSekretarisList[index]['nama']?.dispose();
      pendidikanSekretarisList.removeAt(index);
    }
  }

  // ========== Organisasi Bendahara Management ==========
  void addOrganisasiBendahara() {
    organisasiBendaharaList.add({'nama': TextEditingController()});
  }

  void removeOrganisasiBendahara(int index) {
    if (index >= 0 && index < organisasiBendaharaList.length) {
      organisasiBendaharaList[index]['nama']?.dispose();
      organisasiBendaharaList.removeAt(index);
    }
  }

  // ========== Pendidikan Bendahara Management ==========
  void addPendidikanBendahara() {
    pendidikanBendaharaList.add({
      'tingkat': TextEditingController(),
      'nama': TextEditingController(),
    });
  }

  void removePendidikanBendahara(int index) {
    if (index >= 0 && index < pendidikanBendaharaList.length) {
      pendidikanBendaharaList[index]['tingkat']?.dispose();
      pendidikanBendaharaList[index]['nama']?.dispose();
      pendidikanBendaharaList.removeAt(index);
    }
  }

  // ========== Build Model ==========
  CurriculumVitaeModel buildModel() {
    log(
      'Building CurriculumVitaeModel with: noOrganizationKetua=${noOrganizationKetuaController.text.trim()}',
    );
    return CurriculumVitaeModel(
      jenisLembaga: jenisLembaga,
      namaLembaga: namaLembaga,
      periodeKepengurusan: periodeKepengurusan,
      namaKetua: namaKetuaController.text.trim(),
      ttlKetua: ttlKetuaController.text.trim(),
      niaKetua: niaKetuaController.text.trim(),
      alamatKetua: alamatKetuaController.text.trim(),
      mottoKetua: mottoKetuaController.text.trim(),
      nomorHpKetua: nomorHpKetuaController.text.trim(),
      emailKetua: emailKetuaController.text.trim(),
      organisasiKetua:
          organisasiKetuaList
              .map((org) => OrganisasiModel(nama: org['nama']!.text.trim()))
              .toList(),
      pendidikanKetua:
          pendidikanKetuaList
              .map(
                (pend) => PendidikanModel(
                  tingkatPendidikan: pend['tingkat']!.text.trim(),
                  namaPendidikan: pend['nama']!.text.trim(),
                ),
              )
              .toList(),
      fotoKetuaPath: fotoKetuaPath,
      namaSekretaris: namaSekretarisController.text.trim(),
      ttlSekretaris: ttlSekretarisController.text.trim(),
      niaSekretaris: niaSekretarisController.text.trim(),
      alamatSekretaris: alamatSekretarisController.text.trim(),
      mottoSekretaris: mottoSekretarisController.text.trim(),
      nomorHpSekretaris: nomorHpSekretarisController.text.trim(),
      emailSekretaris: emailSekretarisController.text.trim(),
      organisasiSekretaris:
          organisasiSekretarisList
              .map((org) => OrganisasiModel(nama: org['nama']!.text.trim()))
              .toList(),
      pendidikanSekretaris:
          pendidikanSekretarisList
              .map(
                (pend) => PendidikanModel(
                  tingkatPendidikan: pend['tingkat']!.text.trim(),
                  namaPendidikan: pend['nama']!.text.trim(),
                ),
              )
              .toList(),
      fotoSekretarisPath: fotoSekretarisPath,
      namaBendahara: namaBendaharaController.text.trim(),
      ttlBendahara: ttlBendaharaController.text.trim(),
      niaBendahara: niaBendaharaController.text.trim(),
      alamatBendahara: alamatBendaharaController.text.trim(),
      mottoBendahara: mottoBendaharaController.text.trim(),
      nomorHpBendahara: nomorHpBendaharaController.text.trim(),
      emailBendahara: emailBendaharaController.text.trim(),
      organisasiBendahara:
          organisasiBendaharaList
              .map((org) => OrganisasiModel(nama: org['nama']!.text.trim()))
              .toList(),
      pendidikanBendahara:
          pendidikanBendaharaList
              .map(
                (pend) => PendidikanModel(
                  tingkatPendidikan: pend['tingkat']!.text.trim(),
                  namaPendidikan: pend['nama']!.text.trim(),
                ),
              )
              .toList(),
      fotoBendaharaPath: fotoBendaharaPath,
    );
  }

  // ========== Reset Form ==========
  void resetForm() {
    // Reset lembaga
    jenisLembagaController.clear();
    namaLembagaController.clear();
    periodeKepengurusanController.clear();

    // Reset ketua
    namaKetuaController.clear();
    ttlKetuaController.clear();
    niaKetuaController.clear();
    alamatKetuaController.clear();
    mottoKetuaController.clear();
    nomorHpKetuaController.clear();
    emailKetuaController.clear();
    noOrganizationKetuaController.clear();
    fotoKetuaPath = null;
    hasNoOrganizationKetua = false;

    // Clear organisasi & pendidikan ketua
    for (var org in organisasiKetuaList) {
      org['nama']?.dispose();
    }
    organisasiKetuaList.clear();

    for (var pend in pendidikanKetuaList) {
      pend['tingkat']?.dispose();
      pend['nama']?.dispose();
    }
    pendidikanKetuaList.clear();

    // Reset sekretaris
    namaSekretarisController.clear();
    ttlSekretarisController.clear();
    niaSekretarisController.clear();
    alamatSekretarisController.clear();
    mottoSekretarisController.clear();
    nomorHpSekretarisController.clear();
    emailSekretarisController.clear();
    noOrganizationSekretarisController.clear();
    fotoSekretarisPath = null;
    hasNoOrganizationSekretaris = false;

    // Clear organisasi & pendidikan sekretaris
    for (var org in organisasiSekretarisList) {
      org['nama']?.dispose();
    }
    organisasiSekretarisList.clear();

    for (var pend in pendidikanSekretarisList) {
      pend['tingkat']?.dispose();
      pend['nama']?.dispose();
    }
    pendidikanSekretarisList.clear();

    // Reset bendahara
    namaBendaharaController.clear();
    ttlBendaharaController.clear();
    niaBendaharaController.clear();
    alamatBendaharaController.clear();
    mottoBendaharaController.clear();
    nomorHpBendaharaController.clear();
    emailBendaharaController.clear();
    fotoBendaharaPath = null;
    hasNoOrganizationBendahara = false;

    // Clear organisasi & pendidikan bendahara
    for (var org in organisasiBendaharaList) {
      org['nama']?.dispose();
    }
    organisasiBendaharaList.clear();

    for (var pend in pendidikanBendaharaList) {
      pend['tingkat']?.dispose();
      pend['nama']?.dispose();
    }
    pendidikanBendaharaList.clear();
  }

  // ========== Dispose ==========
  void dispose() {
    // Dispose lembaga controllers
    jenisLembagaController.dispose();
    namaLembagaController.dispose();
    periodeKepengurusanController.dispose();

    // Dispose lembaga focus nodes
    jenisLembagaFocus.dispose();
    namaLembagaFocus.dispose();
    periodeKepengurusanFocus.dispose();

    // Dispose ketua controllers
    namaKetuaController.dispose();
    ttlKetuaController.dispose();
    niaKetuaController.dispose();
    alamatKetuaController.dispose();
    mottoKetuaController.dispose();
    nomorHpKetuaController.dispose();
    emailKetuaController.dispose();
    noOrganizationKetuaController.dispose();

    // Dispose ketua focus nodes
    namaKetuaFocus.dispose();
    ttlKetuaFocus.dispose();
    niaKetuaFocus.dispose();
    alamatKetuaFocus.dispose();
    mottoKetuaFocus.dispose();
    nomorHpKetuaFocus.dispose();
    emailKetuaFocus.dispose();

    // Dispose organisasi & pendidikan ketua
    for (var org in organisasiKetuaList) {
      org['nama']?.dispose();
    }
    for (var pend in pendidikanKetuaList) {
      pend['tingkat']?.dispose();
      pend['nama']?.dispose();
    }

    // Dispose sekretaris controllers
    namaSekretarisController.dispose();
    ttlSekretarisController.dispose();
    niaSekretarisController.dispose();
    alamatSekretarisController.dispose();
    mottoSekretarisController.dispose();
    nomorHpSekretarisController.dispose();
    emailSekretarisController.dispose();
    noOrganizationSekretarisController.dispose();

    // Dispose sekretaris focus nodes
    namaSekretarisFocus.dispose();
    ttlSekretarisFocus.dispose();
    niaSekretarisFocus.dispose();
    alamatSekretarisFocus.dispose();
    mottoSekretarisFocus.dispose();
    nomorHpSekretarisFocus.dispose();
    emailSekretarisFocus.dispose();

    // Dispose organisasi & pendidikan sekretaris
    for (var org in organisasiSekretarisList) {
      org['nama']?.dispose();
    }
    for (var pend in pendidikanSekretarisList) {
      pend['tingkat']?.dispose();
      pend['nama']?.dispose();
    }

    // Dispose bendahara controllers
    namaBendaharaController.dispose();
    ttlBendaharaController.dispose();
    niaBendaharaController.dispose();
    alamatBendaharaController.dispose();
    mottoBendaharaController.dispose();
    nomorHpBendaharaController.dispose();
    emailBendaharaController.dispose();

    // Dispose bendahara focus nodes
    namaBendaharaFocus.dispose();
    ttlBendaharaFocus.dispose();
    niaBendaharaFocus.dispose();
    alamatBendaharaFocus.dispose();
    mottoBendaharaFocus.dispose();
    nomorHpBendaharaFocus.dispose();
    emailBendaharaFocus.dispose();

    // Dispose organisasi & pendidikan bendahara
    for (var org in organisasiBendaharaList) {
      org['nama']?.dispose();
    }
    for (var pend in pendidikanBendaharaList) {
      pend['tingkat']?.dispose();
      pend['nama']?.dispose();
    }
  }
}
