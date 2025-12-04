import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gen_surat/domain/entities/ippnu/berita_acara_penyusunan_pengurus_ippnu_entity.dart';

class BeritaAcaraPenyusunanPengurusIppnuFormDataManager {
  // Controllers for form fields
  final jenisLembagaController = TextEditingController();
  final namaLembagaController = TextEditingController();
  final periodeKepengurusanController = TextEditingController();
  final tanggalPenyusunanController = TextEditingController();
  final tempatPenyusunanController = TextEditingController();
  final namaWilayahController = TextEditingController();
  final hariPenyusunanController = TextEditingController();
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
  final tanggalPenyusunanFocus = FocusNode();
  final tempatPenyusunanFocus = FocusNode();
  final namaWilayahFocus = FocusNode();
  final hariPenyusunanFocus = FocusNode();
  final tanggalHijriahFocus = FocusNode();
  final tanggalMasehiFocus = FocusNode();
  final namaKetuaFocus = FocusNode();
  final namaSekretarisFocus = FocusNode();
  final namaBendaharaFocus = FocusNode();
  final namaWakilBendFocus = FocusNode();

  // Array Lists
  final List<PengurusHarianData> _pengurusHarianList = [];
  final List<PelindungData> _pelindungList = [];
  final List<PembinaData> _pembinaList = [];
  final List<WakilKetuaData> _wakilKetuaList = [];
  final List<WakilSekretarisData> _wakilSekretarisList = [];
  final List<DepartemenData> _departemenList = [];
  final List<LembagaData> _lembagaList = [];

  // Getters
  String get jenisLembaga => jenisLembagaController.text.trim();
  String get namaLembaga => namaLembagaController.text.trim();
  String get periodeKepengurusan => periodeKepengurusanController.text.trim();
  String get tanggalPenyusunan => tanggalPenyusunanController.text.trim();
  String get tempatPenyusunan => tempatPenyusunanController.text.trim();
  String get namaWilayah => namaWilayahController.text.trim();
  String get hariPenyusunan => hariPenyusunanController.text.trim();
  String get tanggalHijriah => tanggalHijriahController.text.trim();
  String get tanggalMasehi => tanggalMasehiController.text.trim();
  String get namaKetua => namaKetuaController.text.trim();
  String get namaSekretaris => namaSekretarisController.text.trim();
  String get namaBendahara => namaBendaharaController.text.trim();
  String get namaWakilBend => namaWakilBendController.text.trim();

  List<PengurusHarianData> get pengurusHarian => _pengurusHarianList;
  int get pengurusHarianCount => _pengurusHarianList.length;

  List<PelindungData> get pelindung => _pelindungList;
  int get pelindungCount => _pelindungList.length;

  List<PembinaData> get pembina => _pembinaList;
  int get pembinaCount => _pembinaList.length;

  List<WakilKetuaData> get wakilKetua => _wakilKetuaList;
  int get wakilKetuaCount => _wakilKetuaList.length;

  List<WakilSekretarisData> get wakilSekretaris => _wakilSekretarisList;
  int get wakilSekretarisCount => _wakilSekretarisList.length;

  List<DepartemenData> get departemen => _departemenList;
  int get departemenCount => _departemenList.length;

  List<LembagaData> get lembaga => _lembagaList;
  int get lembagaCount => _lembagaList.length;

  // ========== Pengurus Harian Management ==========

  void addPengurusHarian({
    String jabatan = '',
    String nama = '',
    File? ttd,
  }) {
    _pengurusHarianList.add(
      PengurusHarianData(
        jabatanController: TextEditingController(text: jabatan),
        namaController: TextEditingController(text: nama),
        ttd: ttd,
      ),
    );
  }

  void removePengurusHarian(int index) {
    if (index >= 0 && index < _pengurusHarianList.length) {
      _pengurusHarianList[index].dispose();
      _pengurusHarianList.removeAt(index);
    }
  }

  void clearPengurusHarian() {
    for (var item in _pengurusHarianList) {
      item.dispose();
    }
    _pengurusHarianList.clear();
  }

  // ========== Pelindung Management ==========

  void addPelindung({String nama = ''}) {
    _pelindungList.add(
      PelindungData(
        namaController: TextEditingController(text: nama),
      ),
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

  // ========== Departemen Management ==========

  void addDepartemen({
    String namaDepartemen = '',
    String koordinator = '',
  }) {
    _departemenList.add(
      DepartemenData(
        namaDepartemenController: TextEditingController(text: namaDepartemen),
        koordinatorController: TextEditingController(text: koordinator),
      ),
    );
  }

  void removeDepartemen(int index) {
    if (index >= 0 && index < _departemenList.length) {
      _departemenList[index].dispose();
      _departemenList.removeAt(index);
    }
  }

  void clearDepartemen() {
    for (var item in _departemenList) {
      item.dispose();
    }
    _departemenList.clear();
  }

  // ========== Lembaga Management ==========

  void addLembaga({
    String nama = '',
    String direktur = '',
    String sekretaris = '',
  }) {
    _lembagaList.add(
      LembagaData(
        namaController: TextEditingController(text: nama),
        direkturController: TextEditingController(text: direktur),
        sekretarisController: TextEditingController(text: sekretaris),
      ),
    );
  }

  void removeLembaga(int index) {
    if (index >= 0 && index < _lembagaList.length) {
      _lembagaList[index].dispose();
      _lembagaList.removeAt(index);
    }
  }

  void clearLembaga() {
    for (var item in _lembagaList) {
      item.dispose();
    }
    _lembagaList.clear();
  }

  // ========== Clear & Dispose ==========

  void clear() {
    jenisLembagaController.clear();
    namaLembagaController.clear();
    periodeKepengurusanController.clear();
    tanggalPenyusunanController.clear();
    tempatPenyusunanController.clear();
    namaWilayahController.clear();
    hariPenyusunanController.clear();
    tanggalHijriahController.clear();
    tanggalMasehiController.clear();
    namaKetuaController.clear();
    namaSekretarisController.clear();
    namaBendaharaController.clear();
    namaWakilBendController.clear();

    clearPengurusHarian();
    clearPelindung();
    clearPembina();
    clearWakilKetua();
    clearWakilSekretaris();
    clearDepartemen();
    clearLembaga();
  }

  void dispose() {
    jenisLembagaController.dispose();
    namaLembagaController.dispose();
    periodeKepengurusanController.dispose();
    tanggalPenyusunanController.dispose();
    tempatPenyusunanController.dispose();
    namaWilayahController.dispose();
    hariPenyusunanController.dispose();
    tanggalHijriahController.dispose();
    tanggalMasehiController.dispose();
    namaKetuaController.dispose();
    namaSekretarisController.dispose();
    namaBendaharaController.dispose();
    namaWakilBendController.dispose();

    jenisLembagaFocus.dispose();
    namaLembagaFocus.dispose();
    periodeKepengurusanFocus.dispose();
    tanggalPenyusunanFocus.dispose();
    tempatPenyusunanFocus.dispose();
    namaWilayahFocus.dispose();
    hariPenyusunanFocus.dispose();
    tanggalHijriahFocus.dispose();
    tanggalMasehiFocus.dispose();
    namaKetuaFocus.dispose();
    namaSekretarisFocus.dispose();
    namaBendaharaFocus.dispose();
    namaWakilBendFocus.dispose();

    clearPengurusHarian();
    clearPelindung();
    clearPembina();
    clearWakilKetua();
    clearWakilSekretaris();
    clearDepartemen();
    clearLembaga();
  }

  // ========== To Entity ==========

  BeritaAcaraPenyusunanPengurusIppnuEntity toEntity() {
    return BeritaAcaraPenyusunanPengurusIppnuEntity(
      jenisLembaga: jenisLembaga,
      namaLembaga: namaLembaga,
      periodeKepengurusan: periodeKepengurusan,
      tanggalPenyusunan: tanggalPenyusunan,
      tempatPenyusunan: tempatPenyusunan,
      namaWilayah: namaWilayah,
      hariPenyusunan: hariPenyusunan,
      tanggalHijriah: tanggalHijriah,
      tanggalMasehi: tanggalMasehi,
      pengurusHarian:
          _pengurusHarianList
              .map(
                (item) => PengurusHarianEntity(
                  jabatan: item.jabatanController.text.trim(),
                  nama: item.namaController.text.trim(),
                  ttdPath: item.ttd?.path,
                ),
              )
              .toList(),
      pelindung:
          _pelindungList
              .map(
                (item) => PelindungEntity(
                  nama: item.namaController.text.trim(),
                ),
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
          _wakilSekretarisList.isEmpty
              ? null
              : _wakilSekretarisList
                  .map(
                    (item) => WakilSekretarisEntity(
                      title: item.titleController.text.trim(),
                      nama: item.namaController.text.trim(),
                    ),
                  )
                  .toList(),
      namaBendahara: namaBendahara,
      namaWakilBend: namaWakilBend.isEmpty ? null : namaWakilBend,
      departemen:
          _departemenList
              .map(
                (item) => DepartemenEntity(
                  namaDepartemen: item.namaDepartemenController.text.trim(),
                  koordinator: item.koordinatorController.text.trim(),
                  anggota:
                      item.anggota
                          .map(
                            (anggota) => AnggotaDepartemenEntity(
                              nama: anggota.namaController.text.trim(),
                            ),
                          )
                          .toList(),
                ),
              )
              .toList(),
      lembaga:
          _lembagaList
              .map(
                (item) => LembagaEntity(
                  nama: item.namaController.text.trim(),
                  direktur: item.direkturController.text.trim(),
                  sekretaris: item.sekretarisController.text.trim(),
                  anggota:
                      item.anggota
                          .map(
                            (anggota) => AnggotaLembagaEntity(
                              nama: anggota.namaController.text.trim(),
                            ),
                          )
                          .toList(),
                ),
              )
              .toList(),
    );
  }
}

// ========== Data Classes ==========

class PengurusHarianData {
  final TextEditingController jabatanController;
  final TextEditingController namaController;
  File? ttd;

  PengurusHarianData({
    required this.jabatanController,
    required this.namaController,
    this.ttd,
  });

  void dispose() {
    jabatanController.dispose();
    namaController.dispose();
  }

  String get jabatan => jabatanController.text.trim();
  String get nama => namaController.text.trim();

  bool get isValid => jabatan.isNotEmpty && nama.isNotEmpty;
}

class PelindungData {
  final TextEditingController namaController;

  PelindungData({
    required this.namaController,
  });

  void dispose() {
    namaController.dispose();
  }

  String get nama => namaController.text.trim();

  bool get isValid => nama.isNotEmpty;
}

class PembinaData {
  int no;
  final TextEditingController namaController;

  PembinaData({
    required this.no,
    required this.namaController,
  });

  void dispose() {
    namaController.dispose();
  }

  String get nama => namaController.text.trim();

  bool get isValid => nama.isNotEmpty;
}

class WakilKetuaData {
  final TextEditingController titleController;
  final TextEditingController namaController;

  WakilKetuaData({
    required this.titleController,
    required this.namaController,
  });

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

class DepartemenData {
  final TextEditingController namaDepartemenController;
  final TextEditingController koordinatorController;
  final List<AnggotaDepartemenData> anggota = [];

  DepartemenData({
    required this.namaDepartemenController,
    required this.koordinatorController,
  });

  void addAnggota({String nama = ''}) {
    anggota.add(
      AnggotaDepartemenData(
        namaController: TextEditingController(text: nama),
      ),
    );
  }

  void removeAnggota(int index) {
    if (index >= 0 && index < anggota.length) {
      anggota[index].dispose();
      anggota.removeAt(index);
    }
  }

  void dispose() {
    namaDepartemenController.dispose();
    koordinatorController.dispose();
    for (var item in anggota) {
      item.dispose();
    }
    anggota.clear();
  }

  String get namaDepartemen => namaDepartemenController.text.trim();
  String get koordinator => koordinatorController.text.trim();

  bool get isValid =>
      namaDepartemen.isNotEmpty &&
      koordinator.isNotEmpty &&
      anggota.isNotEmpty &&
      anggota.every((a) => a.isValid);
}

class AnggotaDepartemenData {
  final TextEditingController namaController;

  AnggotaDepartemenData({
    required this.namaController,
  });

  void dispose() {
    namaController.dispose();
  }

  String get nama => namaController.text.trim();

  bool get isValid => nama.isNotEmpty;
}

class LembagaData {
  final TextEditingController namaController;
  final TextEditingController direkturController;
  final TextEditingController sekretarisController;
  final List<AnggotaLembagaData> anggota = [];

  LembagaData({
    required this.namaController,
    required this.direkturController,
    required this.sekretarisController,
  });

  void addAnggota({String nama = ''}) {
    anggota.add(
      AnggotaLembagaData(
        namaController: TextEditingController(text: nama),
      ),
    );
  }

  void removeAnggota(int index) {
    if (index >= 0 && index < anggota.length) {
      anggota[index].dispose();
      anggota.removeAt(index);
    }
  }

  void dispose() {
    namaController.dispose();
    direkturController.dispose();
    sekretarisController.dispose();
    for (var item in anggota) {
      item.dispose();
    }
    anggota.clear();
  }

  String get nama => namaController.text.trim();
  String get direktur => direkturController.text.trim();
  String get sekretaris => sekretarisController.text.trim();

  bool get isValid =>
      nama.isNotEmpty &&
      direktur.isNotEmpty &&
      sekretaris.isNotEmpty &&
      anggota.isNotEmpty &&
      anggota.every((a) => a.isValid);
}

class AnggotaLembagaData {
  final TextEditingController namaController;

  AnggotaLembagaData({
    required this.namaController,
  });

  void dispose() {
    namaController.dispose();
  }

  String get nama => namaController.text.trim();

  bool get isValid => nama.isNotEmpty;
}
