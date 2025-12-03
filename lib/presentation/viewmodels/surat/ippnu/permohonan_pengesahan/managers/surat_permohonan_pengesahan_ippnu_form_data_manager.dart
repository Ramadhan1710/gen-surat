import 'package:flutter/material.dart';

import '../../../../../../domain/entities/ippnu/surat_permohonan_pengesahan_ippnu_entity.dart';

class SuratPermohonanPengesahanIppnuFormDataManager {
  // Controllers
  final jenisLembagaController = TextEditingController();
  final namaLembagaController = TextEditingController();
  final teleponLembagaController = TextEditingController();
  final alamatLembagaController = TextEditingController();
  final emailLembagaController = TextEditingController();
  final nomorSuratController = TextEditingController();
  final tanggalRaptaController = TextEditingController();
  final nomorRaptaController = TextEditingController();
  final tempatRaptaController = TextEditingController();
  final tanggalKeputusanController = TextEditingController();
  final tanggalHijriahController = TextEditingController();
  final tanggalMasehiController = TextEditingController();
  final periodeKepengurusanController = TextEditingController();
  final namaKetuaTerpilihController = TextEditingController();
  final namaSekretarisTerpilihController = TextEditingController();
  final namaLembagaIndukController = TextEditingController();
  final tingkatLembagaController = TextEditingController();

  // Focus nodes
  final jenisLembagaFocus = FocusNode();
  final namaLembagaFocus = FocusNode();
  final teleponLembagaFocus = FocusNode();
  final alamatLembagaFocus = FocusNode();
  final emailLembagaFocus = FocusNode();
  final tanggalRaptaFocus = FocusNode();
  final nomorRaptaFocus = FocusNode();
  final tempatRaptaFocus = FocusNode();
  final tanggalKeputusanFocus = FocusNode();
  final tanggalHijriahFocus = FocusNode();
  final tanggalMasehiFocus = FocusNode();
  final periodeKepengurusanFocus = FocusNode();
  final namaKetuaTerpilihFocus = FocusNode();
  final namaSekretarisTerpilihFocus = FocusNode();
  final namaLembagaIndukFocus = FocusNode();
  final tingkatLembagaFocus = FocusNode();

  // Typed getters for clean access
  String get jenisLembaga => jenisLembagaController.text.trim();
  String get namaLembaga => namaLembagaController.text.trim();
  String get telepon => teleponLembagaController.text.trim();
  String get alamat => alamatLembagaController.text.trim();
  String get email => emailLembagaController.text.trim();
  String get nomorSurat => nomorSuratController.text.trim();
  String get tanggalRapta => tanggalRaptaController.text.trim();
  String get nomorRapta => nomorRaptaController.text.trim();
  String get tempatRapta => tempatRaptaController.text.trim();
  String get tanggalKeputusan => tanggalKeputusanController.text.trim();
  String get tanggalHijriah => tanggalHijriahController.text.trim();
  String get tanggalMasehi => tanggalMasehiController.text.trim();
  String get periodeKepengurusan => periodeKepengurusanController.text.trim();
  String get namaKetua => namaKetuaTerpilihController.text.trim();
  String get namaSekretaris => namaSekretarisTerpilihController.text.trim();
  String get namaLembagaInduk => namaLembagaIndukController.text.trim();
  String get tingkatLembaga => tingkatLembagaController.text.trim();

  void clear() {
    jenisLembagaController.clear();
    namaLembagaController.clear();
    teleponLembagaController.clear();
    alamatLembagaController.clear();
    emailLembagaController.clear();
    nomorSuratController.clear();
    tanggalRaptaController.clear();
    nomorRaptaController.clear();
    tempatRaptaController.clear();
    tanggalKeputusanController.clear();
    tanggalHijriahController.clear();
    tanggalMasehiController.clear();
    periodeKepengurusanController.clear();
    namaKetuaTerpilihController.clear();
    namaSekretarisTerpilihController.clear();
    namaLembagaIndukController.clear();
    tingkatLembagaController.clear();
  }

  void dispose() {
    jenisLembagaController.dispose();
    namaLembagaController.dispose();
    teleponLembagaController.dispose();
    alamatLembagaController.dispose();
    emailLembagaController.dispose();
    nomorSuratController.dispose();
    tanggalRaptaController.dispose();
    nomorRaptaController.dispose();
    tempatRaptaController.dispose();
    tanggalKeputusanController.dispose();
    tanggalHijriahController.dispose();
    tanggalMasehiController.dispose();
    periodeKepengurusanController.dispose();
    namaKetuaTerpilihController.dispose();
    namaSekretarisTerpilihController.dispose();
    namaLembagaIndukController.dispose();
    tingkatLembagaController.dispose();

    jenisLembagaFocus.dispose();
    namaLembagaFocus.dispose();
    teleponLembagaFocus.dispose();
    alamatLembagaFocus.dispose();
    emailLembagaFocus.dispose();
    tanggalRaptaFocus.dispose();
    nomorRaptaFocus.dispose();
    tempatRaptaFocus.dispose();
    tanggalKeputusanFocus.dispose();
    tanggalHijriahFocus.dispose();
    tanggalMasehiFocus.dispose();
    periodeKepengurusanFocus.dispose();
    namaKetuaTerpilihFocus.dispose();
    namaSekretarisTerpilihFocus.dispose();
    namaLembagaIndukFocus.dispose();
    tingkatLembagaFocus.dispose();
  }

  SuratPermohonanPengesahanIppnuEntity toEntity({
    required String ttdKetuaPath,
    required String ttdSekretarisPath,
  }) {
    return SuratPermohonanPengesahanIppnuEntity(
      jenisLembaga: jenisLembaga,
      namaLembaga: namaLembaga,
      teleponLembaga: telepon,
      alamatLembaga: alamat,
      emailLembaga: email,
      nomorSurat: nomorSurat,
      tanggalRapta: tanggalRapta,
      nomorRapta: nomorRapta,
      tempatRapta: tempatRapta,
      tanggalKeputusan: tanggalKeputusan,
      tanggalHijriah: tanggalHijriah,
      tanggalMasehi: tanggalMasehi,
      periodeKepengurusan: periodeKepengurusan,
      namaKetuaTerpilih: namaKetua,
      namaSekretarisTerpilih: namaSekretaris,
      namaLembagaInduk: namaLembagaInduk,
      tingkatLembaga: tingkatLembaga,
      ttdKetuaPath: ttdKetuaPath,
      ttdSekretarisPath: ttdSekretarisPath,
    );
  }
}
