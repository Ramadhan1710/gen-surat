import 'package:flutter/material.dart';
import 'package:gen_surat/domain/entities/ipnu/kartu_identitas_entity.dart';

class KartuIdentitasFormDataManager {
  final formKey = GlobalKey<FormState>();

  // Text Controllers
  final jenisLembagaController = TextEditingController();
  final namaLembagaController = TextEditingController();
  final periodeKepengurusanController = TextEditingController();

  // File paths
  String? kartuIdentitasKetuaPath;
  String? kartuIdentitasSekretarisPath;
  String? kartuIdentitasBendaharaPath;

  KartuIdentitasEntity buildEntity() {
    return KartuIdentitasEntity(
      jenisLembaga: jenisLembagaController.text.trim(),
      namaLembaga: namaLembagaController.text.trim(),
      periodeKepengurusan: periodeKepengurusanController.text.trim(),
      kartuIdentitasKetuaPath: kartuIdentitasKetuaPath,
      kartuIdentitasSekretarisPath: kartuIdentitasSekretarisPath,
      kartuIdentitasBendaharaPath: kartuIdentitasBendaharaPath,
    );
  }

  void resetForm() {
    jenisLembagaController.clear();
    namaLembagaController.clear();
    periodeKepengurusanController.clear();
    kartuIdentitasKetuaPath = null;
    kartuIdentitasSekretarisPath = null;
    kartuIdentitasBendaharaPath = null;
    formKey.currentState?.reset();
  }

  void dispose() {
    jenisLembagaController.dispose();
    namaLembagaController.dispose();
    periodeKepengurusanController.dispose();
  }
}
