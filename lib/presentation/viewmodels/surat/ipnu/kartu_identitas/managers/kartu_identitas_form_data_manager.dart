import 'package:flutter/material.dart';
import 'package:gen_surat/domain/entities/ipnu/kartu_identitas_ipnu_entity.dart';

class KartuIdentitasIpnuFormDataManager {
  // Text Controllers
  final jenisLembagaController = TextEditingController();
  final namaLembagaController = TextEditingController();
  final periodeKepengurusanController = TextEditingController();

  // Focus Nodes
  final jenisLembagaFocus = FocusNode();
  final namaLembagaFocus = FocusNode();
  final periodeKepengurusanFocus = FocusNode();

  // File paths
  String? kartuIdentitasKetuaPath;
  String? kartuIdentitasSekretarisPath;
  String? kartuIdentitasBendaharaPath;

  KartuIdentitasIpnuEntity buildEntity() {
    return KartuIdentitasIpnuEntity(
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
