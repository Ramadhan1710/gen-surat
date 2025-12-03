import 'package:flutter/material.dart';
import 'package:gen_surat/domain/entities/ipnu/berita_acara_rapat_formatur_entity.dart';

class BeritaAcaraRapatFormaturFormDataManager {
  // Text Controllers
  final jenisLembagaController = TextEditingController();
  final namaLembagaController = TextEditingController();
  final tanggalController = TextEditingController();
  final bulanController = TextEditingController();
  final tahunController = TextEditingController();
  final tempatRapatController = TextEditingController();
  final periodeRaptaController = TextEditingController();
  final namaWilayahController = TextEditingController();
  final tanggalRapatController = TextEditingController();

  // Focus Nodes
  final jenisLembagaFocus = FocusNode();
  final namaLembagaFocus = FocusNode();
  final tanggalFocus = FocusNode();
  final bulanFocus = FocusNode();
  final tahunFocus = FocusNode();
  final tempatRapatFocus = FocusNode();
  final periodeRaptaFocus = FocusNode();
  final namaWilayahFocus = FocusNode();
  final tanggalRapatFocus = FocusNode();

  // Tim Formatur List
  final List<TimFormaturData> timFormaturList = [];

  BeritaAcaraRapatFormaturEntity buildEntity() {
    return BeritaAcaraRapatFormaturEntity(
      jenisLembaga: jenisLembagaController.text.trim(),
      namaLembaga: namaLembagaController.text.trim(),
      tanggal: tanggalController.text.trim(),
      bulan: bulanController.text.trim(),
      tahun: tahunController.text.trim(),
      tempatRapat: tempatRapatController.text.trim(),
      periodeRapta: periodeRaptaController.text.trim(),
      namaWilayah: namaWilayahController.text.trim(),
      tanggalRapat: tanggalRapatController.text.trim(),
      timFormatur:
          timFormaturList
              .map(
                (data) => TimFormaturEntity(
                  nama: data.namaController.text.trim(),
                  jabatan: data.jabatanController.text.trim(),
                  ttdPath: data.ttdPath,
                ),
              )
              .toList(),
    );
  }

  void addTimFormatur() {
    final index = timFormaturList.length;
    String? defaultJabatan;

    if (index == 0) {
      defaultJabatan = 'Ketua Terpilih';
    } else if (index == 1) {
      defaultJabatan = 'Ketua Demisioner';
    }

    timFormaturList.add(TimFormaturData(defaultJabatan: defaultJabatan));
  }

  void removeTimFormatur(int index) {
    if (index >= 0 && index < timFormaturList.length) {
      timFormaturList[index].dispose();
      timFormaturList.removeAt(index);
    }
  }

  void resetForm() {
    jenisLembagaController.clear();
    namaLembagaController.clear();
    tanggalController.clear();
    bulanController.clear();
    tahunController.clear();
    tempatRapatController.clear();
    periodeRaptaController.clear();
    namaWilayahController.clear();
    tanggalRapatController.clear();

    for (var data in timFormaturList) {
      data.dispose();
    }
    timFormaturList.clear();
  }

  void dispose() {
    // Dispose controllers
    jenisLembagaController.dispose();
    namaLembagaController.dispose();
    tanggalController.dispose();
    bulanController.dispose();
    tahunController.dispose();
    tempatRapatController.dispose();
    periodeRaptaController.dispose();
    namaWilayahController.dispose();
    tanggalRapatController.dispose();

    // Dispose focus nodes
    jenisLembagaFocus.dispose();
    namaLembagaFocus.dispose();
    tanggalFocus.dispose();
    bulanFocus.dispose();
    tahunFocus.dispose();
    tempatRapatFocus.dispose();
    periodeRaptaFocus.dispose();
    namaWilayahFocus.dispose();
    tanggalRapatFocus.dispose();

    for (var data in timFormaturList) {
      data.dispose();
    }
    timFormaturList.clear();
  }

  void setTtdTimFormatur(int index, String? path) {
    if (index < timFormaturList.length) {
      timFormaturList[index].ttdPath = path?.isEmpty == true ? null : path;
    }
  }
}

class TimFormaturData {
  final namaController = TextEditingController();
  final jabatanController = TextEditingController();

  final namaFocus = FocusNode();
  final jabatanFocus = FocusNode();
  String? ttdPath;

  TimFormaturData({String? defaultJabatan}) {
    if (defaultJabatan != null) {
      jabatanController.text = defaultJabatan;
    }
  }

  void dispose() {
    namaController.dispose();
    jabatanController.dispose();

    namaFocus.dispose();
    jabatanFocus.dispose();
  }
}
