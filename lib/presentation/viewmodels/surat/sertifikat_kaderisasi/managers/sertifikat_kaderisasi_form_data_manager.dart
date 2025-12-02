import 'package:flutter/material.dart';
import 'package:gen_surat/domain/entities/ipnu/sertifikat_kaderisasi_entity.dart';

class SertifikatKaderisasiFormDataManager {
  final formKey = GlobalKey<FormState>();

  // Text Controllers
  final jenisLembagaController = TextEditingController();
  final namaLembagaController = TextEditingController();
  final periodeKepengurusanController = TextEditingController();

  // File paths
  String? sertifikatKaderisasiKetuaPath;
  String? sertifikatKaderisasiSekretarisPath;
  String? sertifikatKaderisasiBendaharaPath;

  SertifikatKaderisasiEntity buildEntity() {
    return SertifikatKaderisasiEntity(
      jenisLembaga: jenisLembagaController.text.trim(),
      namaLembaga: namaLembagaController.text.trim(),
      periodeKepengurusan: periodeKepengurusanController.text.trim(),
      sertifikatKaderisasiKetuaPath: sertifikatKaderisasiKetuaPath,
      sertifikatKaderisasiSekretarisPath: sertifikatKaderisasiSekretarisPath,
      sertifikatKaderisasiBendaharaPath: sertifikatKaderisasiBendaharaPath,
    );
  }

  void resetForm() {
    jenisLembagaController.clear();
    namaLembagaController.clear();
    periodeKepengurusanController.clear();
    sertifikatKaderisasiKetuaPath = null;
    sertifikatKaderisasiSekretarisPath = null;
    sertifikatKaderisasiBendaharaPath = null;
    formKey.currentState?.reset();
  }

  void dispose() {
    jenisLembagaController.dispose();
    namaLembagaController.dispose();
    periodeKepengurusanController.dispose();
  }
}
