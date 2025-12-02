import 'package:flutter/material.dart';
import 'package:gen_surat/domain/entities/ipnu/susunan_pengurus_ipnu_entity.dart';
import 'package:get/get.dart';

class  SusunanPengurusIpnuFormDataManager {
  // ========== Informasi Lembaga ==========
  final jenisLembagaController = TextEditingController();
  final _jenisLembagaVersion = 0.obs; // Observable trigger for UI updates
  final namaLembagaController = TextEditingController();
  final alamatLembagaController = TextEditingController();
  final nomorTeleponLembagaController = TextEditingController();
  final emailLembagaController = TextEditingController();
  final periodeKepengurusanController = TextEditingController();

  // Constructor to setup listeners
  SusunanPengurusIpnuFormDataManager() {
    // Listen to jenisLembaga changes to trigger UI updates
    jenisLembagaController.addListener(() {
      _jenisLembagaVersion.value++;
    });
  }

  // ========== Ranting Related (Optional) ==========
  final namaRoisSyuriyahController = TextEditingController();
  final namaKetuaTanfidziyahController = TextEditingController();

  // ========== Komisariat Related (Optional) ==========
  final namaKepalaMadrasahController = TextEditingController();

  // ========== Ketua & Wakil ==========
  final namaKetuaController = TextEditingController();
  final alamatKetuaController = TextEditingController();

  // ========== Sekretaris & Wakil ==========
  final namaSekretarisController = TextEditingController();
  final alamatSekretarisController = TextEditingController();

  // ========== Bendahara & Wakil ==========
  final namaBendaharaController = TextEditingController();
  final alamatBendaharaController = TextEditingController();
  final namaWakilBendController = TextEditingController();
  final alamatWakilBendController = TextEditingController();

  // ========== CBP ==========
  final hasLembagaCBP = false.obs;
  final komandanController = TextEditingController();
  final alamatKomandanController = TextEditingController();
  final wakilKomandanController = TextEditingController();
  final alamatWakilKomandanController = TextEditingController();

  final hasDivisi = false.obs;

  // ========== Array Lists ==========
  final List<PembinaData> _pembinaList = [];
  final List<WakilKetuaData> _wakilKetuaList = [];
  final List<WakilSekretarisData> _wakilSekreList = [];
  final List<DepartemenData> _departemenList = [];
  final List<LembagaData> _lembagaList = [];
  final List<DivisiData> _divisiList = [];

  // ========== Getters - Simple Fields ==========
  String get jenisLembaga => jenisLembagaController.text.trim();
  Rx<int> get jenisLembagaVersion => _jenisLembagaVersion;
  
  // Computed getters based on jenisLembaga
  bool get isRanting => jenisLembaga.toLowerCase().contains('ranting');
  bool get isKomisariat => jenisLembaga.toLowerCase().contains('komisariat');
  
  String get namaLembaga => namaLembagaController.text.trim();
  String get alamatLembaga => alamatLembagaController.text.trim();
  String get nomorTeleponLembaga => nomorTeleponLembagaController.text.trim();
  String get emailLembaga => emailLembagaController.text.trim();
  String get periodeKepengurusan => periodeKepengurusanController.text.trim();

  String get namaRoisSyuriyah => namaRoisSyuriyahController.text.trim();
  String get namaKetuaTanfidziyah => namaKetuaTanfidziyahController.text.trim();
  String get namaKepalaMadrasah => namaKepalaMadrasahController.text.trim();

  String get namaKetua => namaKetuaController.text.trim();
  String get alamatKetua => alamatKetuaController.text.trim();

  String get namaSekretaris => namaSekretarisController.text.trim();
  String get alamatSekretaris => alamatSekretarisController.text.trim();

  String get namaBendahara => namaBendaharaController.text.trim();
  String get alamatBendahara => alamatBendaharaController.text.trim();
  String get namaWakilBend => namaWakilBendController.text.trim();
  String get alamatWakilBend => alamatWakilBendController.text.trim();

  String get komandan => komandanController.text.trim();
  String get alamatKomandan => alamatKomandanController.text.trim();
  String get wakilKomandan => wakilKomandanController.text.trim();
  String get alamatWakilKomandan => alamatWakilKomandanController.text.trim();

  // ========== Getters - Array Lists ==========
  List<PembinaData> get pembina => _pembinaList;
  int get pembinaCount => _pembinaList.length;

  List<WakilKetuaData> get wakilKetua => _wakilKetuaList;
  int get wakilKetuaCount => _wakilKetuaList.length;

  List<WakilSekretarisData> get wakilSekre => _wakilSekreList;
  int get wakilSekreCount => _wakilSekreList.length;

  List<DepartemenData> get departemen => _departemenList;
  int get departemenCount => _departemenList.length;

  List<LembagaData> get lembagaInternal => _lembagaList;
  int get lembagaInternalCount => _lembagaList.length;

  List<DivisiData> get divisi => _divisiList;
  int get divisiCount => _divisiList.length;

  // ========== Pembina Management ==========
  void addPembina({int no = 0, String nama = ''}) {
    _pembinaList.add(
      PembinaData(
        no: no > 0 ? no : _pembinaList.length + 1,
        noController: TextEditingController(
          text: no > 0 ? no.toString() : (_pembinaList.length + 1).toString(),
        ),
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
      _pembinaList[i].noController.text = (i + 1).toString();
    }
  }

  void clearPembina() {
    for (var item in _pembinaList) {
      item.dispose();
    }
    _pembinaList.clear();
  }

  // ========== Wakil Ketua Management ==========
  void addWakilKetua({String title = '', String nama = '', String alamat = ''}) {
    _wakilKetuaList.add(
      WakilKetuaData(
        titleController: TextEditingController(text: title),
        namaController: TextEditingController(text: nama),
        alamatController: TextEditingController(text: alamat),
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
  void addWakilSekretaris({
    String title = '',
    String nama = '',
    String alamat = '',
  }) {
    _wakilSekreList.add(
      WakilSekretarisData(
        titleController: TextEditingController(text: title),
        namaController: TextEditingController(text: nama),
        alamatController: TextEditingController(text: alamat),
      ),
    );
  }

  void removeWakilSekretaris(int index) {
    if (index >= 0 && index < _wakilSekreList.length) {
      _wakilSekreList[index].dispose();
      _wakilSekreList.removeAt(index);
    }
  }

  void clearWakilSekretaris() {
    for (var item in _wakilSekreList) {
      item.dispose();
    }
    _wakilSekreList.clear();
  }

  // ========== Departemen Management ==========
  void addDepartemen({
    String nama = '',
    String koordinator = '',
    String alamatKoordinator = '',
  }) {
    _departemenList.add(
      DepartemenData(
        namaController: TextEditingController(text: nama),
        koordinatorController: TextEditingController(text: koordinator),
        alamatKoordinatorController:
            TextEditingController(text: alamatKoordinator),
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
    String alamatDirektur = '',
    String sekretaris = '',
    String alamatSekretaris = '',
  }) {
    _lembagaList.add(
      LembagaData(
        namaController: TextEditingController(text: nama),
        direkturController: TextEditingController(text: direktur),
        alamatDirekturController: TextEditingController(text: alamatDirektur),
        sekretarisController: TextEditingController(text: sekretaris),
        alamatSekretarisController:
            TextEditingController(text: alamatSekretaris),
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

  // ========== Divisi Management ==========
  void addDivisi({
    String nama = '',
    String koordinator = '',
    String alamatKoordinator = '',
  }) {
    _divisiList.add(
      DivisiData(
        namaController: TextEditingController(text: nama),
        koordinatorController: TextEditingController(text: koordinator),
        alamatKoordinatorController:
            TextEditingController(text: alamatKoordinator),
      ),
    );
  }

  void removeDivisi(int index) {
    if (index >= 0 && index < _divisiList.length) {
      _divisiList[index].dispose();
      _divisiList.removeAt(index);
    }
  }

  void clearDivisi() {
    for (var item in _divisiList) {
      item.dispose();
    }
    _divisiList.clear();
  }

  // ========== Clear & Dispose ==========
  void clear() {
    jenisLembagaController.clear();
    namaLembagaController.clear();
    alamatLembagaController.clear();
    nomorTeleponLembagaController.clear();
    emailLembagaController.clear();
    periodeKepengurusanController.clear();

    namaRoisSyuriyahController.clear();
    namaKetuaTanfidziyahController.clear();
    namaKepalaMadrasahController.clear();

    namaKetuaController.clear();
    alamatKetuaController.clear();

    namaSekretarisController.clear();
    alamatSekretarisController.clear();

    namaBendaharaController.clear();
    alamatBendaharaController.clear();
    namaWakilBendController.clear();
    alamatWakilBendController.clear();

    hasLembagaCBP.value = false;
    komandanController.clear();
    alamatKomandanController.clear();
    wakilKomandanController.clear();
    alamatWakilKomandanController.clear();

    hasDivisi.value = false;

    clearPembina();
    clearWakilKetua();
    clearWakilSekretaris();
    clearDepartemen();
    clearLembaga();
    clearDivisi();
  }

  void dispose() {
    jenisLembagaController.dispose();
    namaLembagaController.dispose();
    alamatLembagaController.dispose();
    nomorTeleponLembagaController.dispose();
    emailLembagaController.dispose();
    periodeKepengurusanController.dispose();

    namaRoisSyuriyahController.dispose();
    namaKetuaTanfidziyahController.dispose();
    namaKepalaMadrasahController.dispose();

    namaKetuaController.dispose();
    alamatKetuaController.dispose();

    namaSekretarisController.dispose();
    alamatSekretarisController.dispose();

    namaBendaharaController.dispose();
    alamatBendaharaController.dispose();
    namaWakilBendController.dispose();
    alamatWakilBendController.dispose();

    komandanController.dispose();
    alamatKomandanController.dispose();
    wakilKomandanController.dispose();
    alamatWakilKomandanController.dispose();

    clearPembina();
    clearWakilKetua();
    clearWakilSekretaris();
    clearDepartemen();
    clearLembaga();
    clearDivisi();
  }

  // ========== To Entity ==========
  SusunanPengurusIpnuEntity toEntity() {
    return SusunanPengurusIpnuEntity(
      jenisLembaga: jenisLembaga,
      namaLembaga: namaLembaga,
      alamatLembaga: alamatLembaga,
      nomorTeleponLembaga: nomorTeleponLembaga,
      emailLembaga: emailLembaga,
      periodeKepengurusan: periodeKepengurusan,
      isRanting: isRanting,
      namaRoisSyuriyah: isRanting && namaRoisSyuriyah.isNotEmpty 
          ? namaRoisSyuriyah 
          : null,
      namaKetuaTanfidziyah: isRanting && namaKetuaTanfidziyah.isNotEmpty 
          ? namaKetuaTanfidziyah 
          : null,
      isKomisariat: isKomisariat,
      namaKepalaMadrasah: isKomisariat && namaKepalaMadrasah.isNotEmpty 
          ? namaKepalaMadrasah 
          : null,
      pembina: _pembinaList
          .map((item) => PembinaEntity(
                no: item.no,
                nama: item.nama,
              ))
          .toList(),
      namaKetua: namaKetua,
      alamatKetua: alamatKetua,
      wakilKetua: _wakilKetuaList
          .map((item) => WakilKetuaEntity(
                title: item.title,
                nama: item.nama,
                alamat: item.alamat,
              ))
          .toList(),
      namaSekretaris: namaSekretaris,
      alamatSekretaris: alamatSekretaris,
      wakilSekre: _wakilSekreList.isNotEmpty
          ? _wakilSekreList
              .map((item) => WakilSekretarisEntity(
                    title: item.title,
                    nama: item.nama,
                    alamat: item.alamat,
                  ))
              .toList()
          : null,
      namaBendahara: namaBendahara,
      alamatBendahara: alamatBendahara,
      namaWakilBend: namaWakilBend.isNotEmpty ? namaWakilBend : null,
      alamatWakilBend: alamatWakilBend.isNotEmpty ? alamatWakilBend : null,
      departemen: _departemenList
          .map((dept) => DepartemenEntity(
                nama: dept.nama,
                koordinator: dept.koordinator,
                alamatKoordinator: dept.alamatKoordinator,
                anggota: dept.anggota
                    .map((anggota) => AnggotaDepartemenEntity(
                          nama: anggota.nama,
                          alamat: anggota.alamat,
                        ))
                    .toList(),
              ))
          .toList(),
      lembaga: _lembagaList
          .map((lembaga) => LembagaEntity(
                nama: lembaga.nama,
                direktur: lembaga.direktur,
                alamatDirektur: lembaga.alamatDirektur,
                sekretaris: lembaga.sekretaris,
                alamatSekretaris: lembaga.alamatSekretaris,
                anggota: lembaga.anggota
                    .map((anggota) => AnggotaLembagaEntity(
                          nama: anggota.nama,
                          alamat: anggota.alamat,
                        ))
                    .toList(),
              ))
          .toList(),
      hasLembagaCBP: hasLembagaCBP.value ? true : null,
      komandan: hasLembagaCBP.value && komandan.isNotEmpty ? komandan : null,
      alamatKomandan: hasLembagaCBP.value && alamatKomandan.isNotEmpty 
          ? alamatKomandan 
          : null,
      wakilKomandan: hasLembagaCBP.value && wakilKomandan.isNotEmpty 
          ? wakilKomandan 
          : null,
      alamatWakilKomandan: hasLembagaCBP.value && alamatWakilKomandan.isNotEmpty 
          ? alamatWakilKomandan 
          : null,
      hasDivisi: hasDivisi.value ? true : null,
      divisi: hasDivisi.value && _divisiList.isNotEmpty
          ? _divisiList
              .map((divisi) => DivisiEntity(
                    nama: divisi.nama,
                    koordinator: divisi.koordinator,
                    alamatKoordinator: divisi.alamatKoordinator,
                    anggota: divisi.anggota
                        .map((anggota) => AnggotaDivisiEntity(
                              nama: anggota.nama,
                              alamat: anggota.alamat,
                            ))
                        .toList(),
                  ))
              .toList()
          : null,
    );
  }
}

// ========== Data Classes ==========

class PembinaData {
  int no;
  final TextEditingController noController;
  final TextEditingController namaController;

  PembinaData({
    required this.no,
    required this.noController,
    required this.namaController,
  });

  void dispose() {
    noController.dispose();
    namaController.dispose();
  }

  String get nama => namaController.text.trim();
  bool get isValid => nama.isNotEmpty;
}

class WakilKetuaData {
  final TextEditingController titleController;
  final TextEditingController namaController;
  final TextEditingController alamatController;

  WakilKetuaData({
    required this.titleController,
    required this.namaController,
    required this.alamatController,
  });

  void dispose() {
    titleController.dispose();
    namaController.dispose();
    alamatController.dispose();
  }

  String get title => titleController.text.trim();
  String get nama => namaController.text.trim();
  String get alamat => alamatController.text.trim();
  bool get isValid => title.isNotEmpty && nama.isNotEmpty && alamat.isNotEmpty;
}

class WakilSekretarisData {
  final TextEditingController titleController;
  final TextEditingController namaController;
  final TextEditingController alamatController;

  WakilSekretarisData({
    required this.titleController,
    required this.namaController,
    required this.alamatController,
  });

  void dispose() {
    titleController.dispose();
    namaController.dispose();
    alamatController.dispose();
  }

  String get title => titleController.text.trim();
  String get nama => namaController.text.trim();
  String get alamat => alamatController.text.trim();
  bool get isValid => title.isNotEmpty && nama.isNotEmpty && alamat.isNotEmpty;
}

class DepartemenData {
  final TextEditingController namaController;
  final TextEditingController koordinatorController;
  final TextEditingController alamatKoordinatorController;
  final List<AnggotaData> _anggotaList = [];

  DepartemenData({
    required this.namaController,
    required this.koordinatorController,
    required this.alamatKoordinatorController,
  });

  List<AnggotaData> get anggota => _anggotaList;
  int get anggotaCount => _anggotaList.length;

  void addAnggota({String nama = '', String alamat = ''}) {
    _anggotaList.add(
      AnggotaData(
        namaController: TextEditingController(text: nama),
        alamatController: TextEditingController(text: alamat),
      ),
    );
  }

  void removeAnggota(int index) {
    if (index >= 0 && index < _anggotaList.length) {
      _anggotaList[index].dispose();
      _anggotaList.removeAt(index);
    }
  }

  void dispose() {
    namaController.dispose();
    koordinatorController.dispose();
    alamatKoordinatorController.dispose();
    for (var item in _anggotaList) {
      item.dispose();
    }
    _anggotaList.clear();
  }

  String get nama => namaController.text.trim();
  String get koordinator => koordinatorController.text.trim();
  String get alamatKoordinator => alamatKoordinatorController.text.trim();
  bool get isValid =>
      nama.isNotEmpty && koordinator.isNotEmpty && alamatKoordinator.isNotEmpty;
}

class LembagaData {
  final TextEditingController namaController;
  final TextEditingController direkturController;
  final TextEditingController alamatDirekturController;
  final TextEditingController sekretarisController;
  final TextEditingController alamatSekretarisController;
  final List<AnggotaData> _anggotaList = [];

  LembagaData({
    required this.namaController,
    required this.direkturController,
    required this.alamatDirekturController,
    required this.sekretarisController,
    required this.alamatSekretarisController,
  });

  List<AnggotaData> get anggota => _anggotaList;
  int get anggotaCount => _anggotaList.length;

  void addAnggota({String nama = '', String alamat = ''}) {
    _anggotaList.add(
      AnggotaData(
        namaController: TextEditingController(text: nama),
        alamatController: TextEditingController(text: alamat),
      ),
    );
  }

  void removeAnggota(int index) {
    if (index >= 0 && index < _anggotaList.length) {
      _anggotaList[index].dispose();
      _anggotaList.removeAt(index);
    }
  }

  void dispose() {
    namaController.dispose();
    direkturController.dispose();
    alamatDirekturController.dispose();
    sekretarisController.dispose();
    alamatSekretarisController.dispose();
    for (var item in _anggotaList) {
      item.dispose();
    }
    _anggotaList.clear();
  }

  String get nama => namaController.text.trim();
  String get direktur => direkturController.text.trim();
  String get alamatDirektur => alamatDirekturController.text.trim();
  String get sekretaris => sekretarisController.text.trim();
  String get alamatSekretaris => alamatSekretarisController.text.trim();
  bool get isValid =>
      nama.isNotEmpty &&
      direktur.isNotEmpty &&
      alamatDirektur.isNotEmpty &&
      sekretaris.isNotEmpty &&
      alamatSekretaris.isNotEmpty;
}

class DivisiData {
  final TextEditingController namaController;
  final TextEditingController koordinatorController;
  final TextEditingController alamatKoordinatorController;
  final List<AnggotaData> _anggotaList = [];

  DivisiData({
    required this.namaController,
    required this.koordinatorController,
    required this.alamatKoordinatorController,
  });

  List<AnggotaData> get anggota => _anggotaList;
  int get anggotaCount => _anggotaList.length;

  void addAnggota({String nama = '', String alamat = ''}) {
    _anggotaList.add(
      AnggotaData(
        namaController: TextEditingController(text: nama),
        alamatController: TextEditingController(text: alamat),
      ),
    );
  }

  void removeAnggota(int index) {
    if (index >= 0 && index < _anggotaList.length) {
      _anggotaList[index].dispose();
      _anggotaList.removeAt(index);
    }
  }

  void dispose() {
    namaController.dispose();
    koordinatorController.dispose();
    alamatKoordinatorController.dispose();
    for (var item in _anggotaList) {
      item.dispose();
    }
    _anggotaList.clear();
  }

  String get nama => namaController.text.trim();
  String get koordinator => koordinatorController.text.trim();
  String get alamatKoordinator => alamatKoordinatorController.text.trim();
  bool get isValid =>
      nama.isNotEmpty && koordinator.isNotEmpty && alamatKoordinator.isNotEmpty;
}

class AnggotaData {
  final TextEditingController namaController;
  final TextEditingController alamatController;

  AnggotaData({
    required this.namaController,
    required this.alamatController,
  });

  void dispose() {
    namaController.dispose();
    alamatController.dispose();
  }

  String get nama => namaController.text.trim();
  String get alamat => alamatController.text.trim();
  bool get isValid => nama.isNotEmpty && alamat.isNotEmpty;
}
