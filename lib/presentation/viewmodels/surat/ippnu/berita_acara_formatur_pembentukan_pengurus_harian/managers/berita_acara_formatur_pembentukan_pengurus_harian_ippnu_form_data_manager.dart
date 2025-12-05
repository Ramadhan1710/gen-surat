import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gen_surat/domain/entities/ippnu/berita_acara_formatur_pembentukan_pengurus_harian_ippnu_entity.dart';

class BeritaAcaraFormaturPembentukanPengurusHarianIppnuFormDataManager {
  // Controllers for form fields
  final jenisLembagaController = TextEditingController();
  final namaLembagaController = TextEditingController();
  final periodeKepengurusanController = TextEditingController();
  final tingkatLembagaController = TextEditingController();
  final tanggalPenyusunanController = TextEditingController();
  final tempatPenyusunanController = TextEditingController();
  final namaWilayahController = TextEditingController();
  final tanggalHijriahController = TextEditingController();
  final tanggalMasehiController = TextEditingController();
  final namaKetuaController = TextEditingController();
  final namaSekretarisController = TextEditingController();
  final namaBendaharaController = TextEditingController();
  final namaWakilBendController = TextEditingController();

  // Focus nodes
  final jenisLembagaFocus = FocusNode();
  final namaLembagaFocus = FocusNode();
  final periodeKepengurusanFocus = FocusNode();
  final tingkatLembagaFocus = FocusNode();
  final tanggalPenyusunanFocus = FocusNode();
  final tempatPenyusunanFocus = FocusNode();
  final namaWilayahFocus = FocusNode();
  final tanggalHijriahFocus = FocusNode();
  final tanggalMasehiFocus = FocusNode();
  final namaKetuaFocus = FocusNode();
  final namaSekretarisFocus = FocusNode();
  final namaBendaharaFocus = FocusNode();
  final namaWakilBendFocus = FocusNode();

  // Array Lists
  final List<FormaturData> _formaturList = [];
  final List<PelindungData> _pelindungList = [];
  final List<PembinaData> _pembinaList = [];
  final List<WakilKetuaData> _wakilKetuaList = [];
  final List<WakilSekretarisData> _wakilSekretarisList = [];

  // Getters
  String get jenisLembaga => jenisLembagaController.text.trim();
  String get namaLembaga => namaLembagaController.text.trim();
  String get periodeKepengurusan => periodeKepengurusanController.text.trim();
  String get tingkatLembaga => tingkatLembagaController.text.trim();
  String get tanggalPenyusunan => tanggalPenyusunanController.text.trim();
  String get tempatPenyusunan => tempatPenyusunanController.text.trim();
  String get namaWilayah => namaWilayahController.text.trim();
  String get tanggalHijriah => tanggalHijriahController.text.trim();
  String get tanggalMasehi => tanggalMasehiController.text.trim();
  String get namaKetua => namaKetuaController.text.trim();
  String get namaSekretaris => namaSekretarisController.text.trim();
  String get namaBendahara => namaBendaharaController.text.trim();
  String get namaWakilBend => namaWakilBendController.text.trim();

  List<FormaturData> get formatur => _formaturList;
  int get formaturCount => _formaturList.length;

  List<PelindungData> get pelindung => _pelindungList;
  int get pelindungCount => _pelindungList.length;

  List<PembinaData> get pembina => _pembinaList;
  int get pembinaCount => _pembinaList.length;

  List<WakilKetuaData> get wakilKetua => _wakilKetuaList;
  int get wakilKetuaCount => _wakilKetuaList.length;

  List<WakilSekretarisData> get wakilSekretaris => _wakilSekretarisList;
  int get wakilSekretarisCount => _wakilSekretarisList.length;

  // ========== Formatur Management ==========

  void addFormatur({String nama = '', String jabatan = '', File? ttd}) {
    final index = _formaturList.length;
    String? defaultJabatan;

    if (index == 0) {
      defaultJabatan = 'Ketua Terpilih/Ketua Tim Formatur';
    } else if (index == 1) {
      defaultJabatan = 'Ketua Demisioner';
    }

    _formaturList.add(
      FormaturData(
        no: _formaturList.length + 1,
        namaController: TextEditingController(text: nama),
        jabatanController: TextEditingController(
          text: defaultJabatan ?? jabatan,
        ),
        ttd: ttd,
        defaultJabatan: defaultJabatan,
      ),
    );
  }

  void removeFormatur(int index) {
    if (index >= 0 && index < _formaturList.length) {
      _formaturList[index].dispose();
      _formaturList.removeAt(index);
      _updateFormaturNumbering();
    }
  }

  void _updateFormaturNumbering() {
    for (int i = 0; i < _formaturList.length; i++) {
      _formaturList[i].no = i + 1;
    }
  }

  void clearFormatur() {
    for (var item in _formaturList) {
      item.dispose();
    }
    _formaturList.clear();
  }

  // ========== Pelindung Management ==========

  void addPelindung({String nama = ''}) {
    _pelindungList.add(
      PelindungData(namaController: TextEditingController(text: nama)),
    );
  }

  void removePelindung(int index) {
    if (index >= 0 && index < _pelindungList.length) {
      _pelindungList[index].dispose();
      _pelindungList.removeAt(index);
    }
  }

  void clearPelindung() {
    for (var item in _pelindungList) {
      item.dispose();
    }
    _pelindungList.clear();
  }

  // ========== Pembina Management ==========

  void addPembina({String nama = ''}) {
    _pembinaList.add(
      PembinaData(
        no: _pembinaList.length + 1,
        namaController: TextEditingController(text: nama),
      ),
    );
  }

  void removePembina(int index) {
    if (index >= 0 && index < _pembinaList.length) {
      _pembinaList[index].dispose();
      _pembinaList.removeAt(index);
      _updatePembinaNumbering();
    }
  }

  void _updatePembinaNumbering() {
    for (int i = 0; i < _pembinaList.length; i++) {
      _pembinaList[i].no = i + 1;
    }
  }

  void clearPembina() {
    for (var item in _pembinaList) {
      item.dispose();
    }
    _pembinaList.clear();
  }

  // ========== Wakil Ketua Management ==========

  void addWakilKetua({String title = '', String nama = ''}) {
    _wakilKetuaList.add(
      WakilKetuaData(
        titleController: TextEditingController(text: title),
        namaController: TextEditingController(text: nama),
      ),
    );
  }

  void removeWakilKetua(int index) {
    if (index >= 0 && index < _wakilKetuaList.length) {
      _wakilKetuaList[index].dispose();
      _wakilKetuaList.removeAt(index);
    }
  }

  void clearWakilKetua() {
    for (var item in _wakilKetuaList) {
      item.dispose();
    }
    _wakilKetuaList.clear();
  }

  // ========== Wakil Sekretaris Management ==========

  void addWakilSekretaris({String title = '', String nama = ''}) {
    _wakilSekretarisList.add(
      WakilSekretarisData(
        titleController: TextEditingController(text: title),
        namaController: TextEditingController(text: nama),
      ),
    );
  }

  void removeWakilSekretaris(int index) {
    if (index >= 0 && index < _wakilSekretarisList.length) {
      _wakilSekretarisList[index].dispose();
      _wakilSekretarisList.removeAt(index);
    }
  }

  void clearWakilSekretaris() {
    for (var item in _wakilSekretarisList) {
      item.dispose();
    }
    _wakilSekretarisList.clear();
  }

  // ========== Clear & Dispose ==========

  void clear() {
    jenisLembagaController.clear();
    namaLembagaController.clear();
    periodeKepengurusanController.clear();
    tingkatLembagaController.clear();
    tanggalPenyusunanController.clear();
    tempatPenyusunanController.clear();
    namaWilayahController.clear();
    tanggalHijriahController.clear();
    tanggalMasehiController.clear();
    namaKetuaController.clear();
    namaSekretarisController.clear();
    namaBendaharaController.clear();
    namaWakilBendController.clear();

    clearFormatur();
    clearPelindung();
    clearPembina();
    clearWakilKetua();
    clearWakilSekretaris();
  }

  void dispose() {
    jenisLembagaController.dispose();
    namaLembagaController.dispose();
    periodeKepengurusanController.dispose();
    tingkatLembagaController.dispose();
    tanggalPenyusunanController.dispose();
    tempatPenyusunanController.dispose();
    namaWilayahController.dispose();
    tanggalHijriahController.dispose();
    tanggalMasehiController.dispose();
    namaKetuaController.dispose();
    namaSekretarisController.dispose();
    namaBendaharaController.dispose();
    namaWakilBendController.dispose();

    clearFormatur();
    clearPelindung();
    clearPembina();
    clearWakilKetua();
    clearWakilSekretaris();
  }

  // ========== To Entity ==========

  BeritaAcaraFormaturPembentukanPengurusHarianIppnuEntity toEntity() {
    return BeritaAcaraFormaturPembentukanPengurusHarianIppnuEntity(
      jenisLembaga: jenisLembaga,
      namaLembaga: namaLembaga,
      periodeKepengurusan: periodeKepengurusan,
      tingkatLembaga: tingkatLembaga,
      tanggalPenyusunan: tanggalPenyusunan,
      tempatPenyusunan: tempatPenyusunan,
      namaWilayah: namaWilayah,
      tanggalHijriah: tanggalHijriah,
      tanggalMasehi: tanggalMasehi,
      formatur:
          _formaturList
              .map(
                (item) => FormaturEntity(
                  no: item.no,
                  nama: item.namaController.text.trim(),
                  jabatan: item.jabatanController.text.trim(),
                  ttdPath: item.ttd?.path ?? '',
                ),
              )
              .toList(),
      pelindung:
          _pelindungList
              .map(
                (item) =>
                    PelindungEntity(nama: item.namaController.text.trim()),
              )
              .toList(),
      pembina:
          _pembinaList
              .map(
                (item) => PembinaEntity(
                  no: item.no,
                  nama: item.namaController.text.trim(),
                ),
              )
              .toList(),
      namaKetua: namaKetua,
      wakilKetua:
          _wakilKetuaList
              .map(
                (item) => WakilKetuaEntity(
                  title: item.titleController.text.trim(),
                  nama: item.namaController.text.trim(),
                ),
              )
              .toList(),
      namaSekretaris: namaSekretaris,
      wakilSekre:
          _wakilSekretarisList
              .map(
                (item) => WakilSekretarisEntity(
                  title: item.titleController.text.trim(),
                  nama: item.namaController.text.trim(),
                ),
              )
              .toList(),
      namaBendahara: namaBendahara,
      namaWakilBend: namaWakilBend,
    );
  }
}

// ========== Data Classes ==========

class FormaturData {
  int no;
  final TextEditingController namaController;
  final TextEditingController jabatanController;
  final String? defaultJabatan;
  File? ttd;

  FormaturData({
    required this.no,
    required this.namaController,
    required this.jabatanController,
    this.ttd,
    this.defaultJabatan,
  });

  void dispose() {
    namaController.dispose();
    jabatanController.dispose();
  }

  String get nama => namaController.text.trim();
  String get jabatan => jabatanController.text.trim();
  bool get isReadOnly => defaultJabatan != null;

  bool get isValid =>
      nama.isNotEmpty && jabatan.isNotEmpty && ttd != null && ttd!.existsSync();
}

class PelindungData {
  final TextEditingController namaController;

  PelindungData({required this.namaController});

  void dispose() {
    namaController.dispose();
  }

  String get nama => namaController.text.trim();

  bool get isValid => nama.isNotEmpty;
}

class PembinaData {
  int no;
  final TextEditingController namaController;

  PembinaData({required this.no, required this.namaController});

  void dispose() {
    namaController.dispose();
  }

  String get nama => namaController.text.trim();

  bool get isValid => nama.isNotEmpty;
}

class WakilKetuaData {
  final TextEditingController titleController;
  final TextEditingController namaController;

  WakilKetuaData({required this.titleController, required this.namaController});

  void dispose() {
    titleController.dispose();
    namaController.dispose();
  }

  String get title => titleController.text.trim();
  String get nama => namaController.text.trim();

  bool get isValid => title.isNotEmpty && nama.isNotEmpty;
}

class WakilSekretarisData {
  final TextEditingController titleController;
  final TextEditingController namaController;

  WakilSekretarisData({
    required this.titleController,
    required this.namaController,
  });

  void dispose() {
    titleController.dispose();
    namaController.dispose();
  }

  String get title => titleController.text.trim();
  String get nama => namaController.text.trim();

  bool get isValid {
    // Both must be empty or both must be filled
    if (title.isEmpty && nama.isEmpty) return true;
    return title.isNotEmpty && nama.isNotEmpty;
  }
}
