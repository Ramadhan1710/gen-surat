import 'package:flutter/material.dart';
import 'package:gen_surat/domain/entities/bersama/surat_dispensasi_bersama_entity.dart';
  
class SuratDispensasiBersamaFormDataManager {
  final nomorSuratController = TextEditingController();
  final lampiranController = TextEditingController();
  final tujuanSuratController = TextEditingController();
  final namaKegiatanController = TextEditingController();
  final hariTanggalController = TextEditingController();
  final waktuController = TextEditingController();
  final tempatController = TextEditingController();
  final namaController = TextEditingController();
  final kelasSekolahController = TextEditingController();
  final tanggalHijriahController = TextEditingController();
  final tanggalMasehiController = TextEditingController();

  // focus nodes
  final nomorSuratFocus = FocusNode();
  final lampiranFocus = FocusNode();
  final tujuanSuratFocus = FocusNode();
  final namaKegiatanFocus = FocusNode();
  final hariTanggalFocus = FocusNode();
  final waktuFocus = FocusNode();
  final tempatFocus = FocusNode();
  final namaFocus = FocusNode();
  final kelasSekolahFocus = FocusNode();
  final tanggalHijriahFocus = FocusNode();
  final tanggalMasehiFocus = FocusNode();

  String get nomorSurat => nomorSuratController.text.trim();
  String get lampiran => lampiranController.text.trim();
  String get tujuanSurat => tujuanSuratController.text.trim();
  String get namaKegiatan => namaKegiatanController.text.trim();
  String get hariTanggal => hariTanggalController.text.trim();
  String get waktu => waktuController.text.trim();
  String get tempat => tempatController.text.trim();
  String get nama => namaController.text.trim();
  String get kelasSekolah => kelasSekolahController.text.trim();
  String get tanggalHijriah => tanggalHijriahController.text.trim();
  String get tanggalMasehi => tanggalMasehiController.text.trim();

  SuratDispensasiBersamaEntity toEntity() {
    return SuratDispensasiBersamaEntity(
      nomorSurat: nomorSuratController.text.trim(),
      lampiran: lampiranController.text.trim(),
      tujuanSurat: tujuanSuratController.text.trim(),
      namaKegiatan: namaKegiatanController.text.trim(),
      hariTanggal: hariTanggalController.text.trim(),
      waktu: waktuController.text.trim(),
      tempat: tempatController.text.trim(),
      nama: namaController.text.trim(),
      kelasSekolah: kelasSekolahController.text.trim(),
      tanggalHijriah: tanggalHijriahController.text.trim(),
      tanggalMasehi: tanggalMasehiController.text.trim(),
    );
  }

  void resetForm(){
    nomorSuratController.clear();
    lampiranController.clear();
    tujuanSuratController.clear();
    namaKegiatanController.clear();
    hariTanggalController.clear();
    waktuController.clear();
    tempatController.clear();
    namaController.clear();
    kelasSekolahController.clear();
    tanggalHijriahController.clear();
    tanggalMasehiController.clear();
  }

  void dispose(){
    nomorSuratController.dispose();
    lampiranController.dispose();
    tujuanSuratController.dispose();
    namaKegiatanController.dispose();
    hariTanggalController.dispose();
    waktuController.dispose();
    tempatController.dispose();
    namaController.dispose();
    kelasSekolahController.dispose();
    tanggalHijriahController.dispose();
    tanggalMasehiController.dispose();
  } 
}