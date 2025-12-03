import 'package:flutter/material.dart';
import 'package:gen_surat/domain/entities/ipnu/sertifikat_kaderisasi_entity.dart';

class SertifikatKaderisasiFormDataManager {
  final formKey = GlobalKey<FormState>();

  // Text Controllers
  final jenisLembagaController = TextEditingController();
  final namaLembagaController = TextEditingController();
  final periodeKepengurusanController = TextEditingController();

  // Focus Nodes
  final jenisLembagaFocus = FocusNode();
  final namaLembagaFocus = FocusNode();
  final periodeKepengurusanFocus = FocusNode();

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
    // Dispose controllers
    jenisLembagaController.dispose();
    namaLembagaController.dispose();
    periodeKepengurusanController.dispose();

    // Dispose focus nodes
    jenisLembagaFocus.dispose();
    namaLembagaFocus.dispose();
    periodeKepengurusanFocus.dispose();
  }
}
