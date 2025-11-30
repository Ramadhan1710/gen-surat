import 'package:flutter/material.dart';

import '../../../../../../domain/entities/ipnu/surat_permohonan_pengesahan_ipnu_entity.dart';

class SuratPermohonanPengesahanIpnuFormDataManager {
  final jenisLembagaController = TextEditingController();
  final namaLembagaController = TextEditingController();
  final nomorTeleponLembagaController = TextEditingController();
  final alamatLembagaController = TextEditingController();
  final emailLembagaController = TextEditingController();
  final nomorSuratController = TextEditingController();
  final tanggalRapatController = TextEditingController();
  final tanggalHijriahController = TextEditingController();
  final tanggalMasehiController = TextEditingController();
  final periodeKepengurusanController = TextEditingController();
  final namaKetuaTerpilihController = TextEditingController();
  final namaSekretarisTerpilihController = TextEditingController();
  final jenisLembagaIndukController = TextEditingController();
  
  // Typed getters for clean access
  String get jenisLembaga => jenisLembagaController.text.trim();
  String get namaLembaga => namaLembagaController.text.trim();
  String get nomorTelepon => nomorTeleponLembagaController.text.trim();
  String get alamat => alamatLembagaController.text.trim();
  String get email => emailLembagaController.text.trim();
  String get nomorSurat => nomorSuratController.text.trim();
  String get tanggalRapat => tanggalRapatController.text.trim();
  String get tanggalHijriah => tanggalHijriahController.text.trim();
  String get tanggalMasehi => tanggalMasehiController.text.trim();
  String get periodeKepengurusan => periodeKepengurusanController.text.trim();
  String get namaKetua => namaKetuaTerpilihController.text.trim();
  String get namaSekretaris => namaSekretarisTerpilihController.text.trim();
  String get jenisLembagaInduk => jenisLembagaIndukController.text.trim();
  
  void clear() {
    jenisLembagaController.clear();
    namaLembagaController.clear();
    nomorTeleponLembagaController.clear();
    alamatLembagaController.clear();
    emailLembagaController.clear();
    nomorSuratController.clear();
    tanggalRapatController.clear();
    tanggalHijriahController.clear();
    tanggalMasehiController.clear();
    periodeKepengurusanController.clear();
    namaKetuaTerpilihController.clear();
    namaSekretarisTerpilihController.clear();
    jenisLembagaIndukController.clear();
  }
  
  void dispose() {
    jenisLembagaController.dispose();
    namaLembagaController.dispose();
    nomorTeleponLembagaController.dispose();
    alamatLembagaController.dispose();
    emailLembagaController.dispose();
    nomorSuratController.dispose();
    tanggalRapatController.dispose();
    tanggalHijriahController.dispose();
    tanggalMasehiController.dispose();
    periodeKepengurusanController.dispose();
    namaKetuaTerpilihController.dispose();
    namaSekretarisTerpilihController.dispose();
    jenisLembagaIndukController.dispose();
  }

  SuratPermohonanPengesahanIpnuEntity toEntity({
    required String ttdKetuaPath,
    required String ttdSekretarisPath,
  }) {
    return SuratPermohonanPengesahanIpnuEntity(
      jenisLembaga: jenisLembaga,
      namaLembaga: namaLembaga,
      nomorTeleponLembaga: nomorTelepon,
      alamatLembaga: alamat,
      emailLembaga: email,
      nomorSurat: nomorSurat,
      tanggalRapat: tanggalRapat,
      tanggalHijriah: tanggalHijriah,
      tanggalMasehi: tanggalMasehi,
      periodeKepengurusan: periodeKepengurusan,
      namaKetuaTerpilih: namaKetua,
      namaSekretarisTerpilih: namaSekretaris,
      jenisLembagaInduk: jenisLembagaInduk,
      ttdKetuaPath: ttdKetuaPath,
      ttdSekretarisPath: ttdSekretarisPath,
    );
  }
}