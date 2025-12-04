import 'package:flutter/material.dart';
import '../../../../../../domain/entities/ippnu/susunan_pengurus_ippnu_entity.dart';

class SusunanPengurusIppnuFormDataManager {
  // Controllers - Informasi Lembaga
  final jenisLembagaController = TextEditingController();
  final namaLembagaController = TextEditingController();
  final periodeKepengurusanController = TextEditingController();
  final alamatLembagaController = TextEditingController();
  final nomorTeleponLembagaController = TextEditingController();
  final emailLembagaController = TextEditingController();

  // Controllers - Pengurus Harian
  final namaKetuaController = TextEditingController();
  final namaSekretarisController = TextEditingController();
  final namaBendaharaController = TextEditingController();
  final namaWakilBendController = TextEditingController();

  // Focus nodes - Informasi Lembaga
  final jenisLembagaFocus = FocusNode();
  final namaLembagaFocus = FocusNode();
  final periodeKepengurusanFocus = FocusNode();
  final alamatLembagaFocus = FocusNode();
  final nomorTeleponLembagaFocus = FocusNode();
  final emailLembagaFocus = FocusNode();

  // Focus nodes - Pengurus Harian
  final namaKetuaFocus = FocusNode();
  final namaSekretarisFocus = FocusNode();
  final namaBendaharaFocus = FocusNode();
  final namaWakilBendFocus = FocusNode();

  // Lists
  final List<WakilKetuaData> _wakilKetuaList = [];
  final List<WakilSekretarisData> _wakilSekreList = [];
  final List<DepartemenData> _departemenList = [];
  final List<LembagaData> _lembagaList = [];
  final List<PelindungData> _pelindungList = [];
  final List<PembinaData> _pembinaList = [];

  // Getters - Informasi Lembaga
  String get jenisLembaga => jenisLembagaController.text.trim();
  String get namaLembaga => namaLembagaController.text.trim();
  String get periodeKepengurusan => periodeKepengurusanController.text.trim();
  String get alamatLembaga => alamatLembagaController.text.trim();
  String get nomorTeleponLembaga => nomorTeleponLembagaController.text.trim();
  String get emailLembaga => emailLembagaController.text.trim();

  // Getters - Pengurus Harian
  String get namaKetua => namaKetuaController.text.trim();
  String get namaSekretaris => namaSekretarisController.text.trim();
  String get namaBendahara => namaBendaharaController.text.trim();
  String get namaWakilBend => namaWakilBendController.text.trim();

  // List getters
  List<WakilKetuaData> get wakilKetua => _wakilKetuaList;
  List<WakilSekretarisData> get wakilSekre => _wakilSekreList;
  List<DepartemenData> get departemen => _departemenList;
  List<LembagaData> get lembaga => _lembagaList;
  List<PelindungData> get pelindung => _pelindungList;
  List<PembinaData> get pembina => _pembinaList;

  // Wakil Ketua methods
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

  // Wakil Sekretaris methods
  void addWakilSekretaris({String title = '', String nama = ''}) {
    _wakilSekreList.add(
      WakilSekretarisData(
        titleController: TextEditingController(text: title),
        namaController: TextEditingController(text: nama),
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

  // Departemen methods
  void addDepartemen({String namaDepartemen = '', String koordinator = ''}) {
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

  // Lembaga methods
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

  // Pelindung methods
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

  // Pembina methods
  void addPembina({String nama = ''}) {
    final no = _pembinaList.length + 1;
    _pembinaList.add(
      PembinaData(no: no, namaController: TextEditingController(text: nama)),
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

  void clear() {
    jenisLembagaController.clear();
    namaLembagaController.clear();
    periodeKepengurusanController.clear();
    alamatLembagaController.clear();
    nomorTeleponLembagaController.clear();
    emailLembagaController.clear();
    namaKetuaController.clear();
    namaSekretarisController.clear();
    namaBendaharaController.clear();
    namaWakilBendController.clear();

    clearWakilKetua();
    clearWakilSekretaris();
    clearDepartemen();
    clearLembaga();
    clearPelindung();
    clearPembina();
  }

  void dispose() {
    jenisLembagaController.dispose();
    namaLembagaController.dispose();
    periodeKepengurusanController.dispose();
    alamatLembagaController.dispose();
    nomorTeleponLembagaController.dispose();
    emailLembagaController.dispose();
    namaKetuaController.dispose();
    namaSekretarisController.dispose();
    namaBendaharaController.dispose();
    namaWakilBendController.dispose();

    jenisLembagaFocus.dispose();
    namaLembagaFocus.dispose();
    periodeKepengurusanFocus.dispose();
    alamatLembagaFocus.dispose();
    nomorTeleponLembagaFocus.dispose();
    emailLembagaFocus.dispose();
    namaKetuaFocus.dispose();
    namaSekretarisFocus.dispose();
    namaBendaharaFocus.dispose();
    namaWakilBendFocus.dispose();

    clearWakilKetua();
    clearWakilSekretaris();
    clearDepartemen();
    clearLembaga();
    clearPelindung();
    clearPembina();
  }

  SusunanPengurusIppnuEntity toEntity() {
    return SusunanPengurusIppnuEntity(
      jenisLembaga: jenisLembaga,
      namaLembaga: namaLembaga,
      periodeKepengurusan: periodeKepengurusan,
      alamatLembaga: alamatLembaga,
      nomorTeleponLembaga: nomorTeleponLembaga,
      emailLembaga: emailLembaga,
      namaKetua: namaKetua,
      wakilKetua:
          _wakilKetuaList
              .map((e) => WakilKetuaItem(title: e.title, nama: e.nama))
              .toList(),
      namaSekretaris: namaSekretaris,
      wakilSekre:
          _wakilSekreList
              .map((e) => WakilSekretarisItem(title: e.title, nama: e.nama))
              .toList(),
      namaBendahara: namaBendahara,
      namaWakilBend: namaWakilBend,
      departemen:
          _departemenList
              .map(
                (e) => DepartemenItem(
                  namaDepartemen: e.namaDepartemen,
                  koordinator: e.koordinator,
                  anggota:
                      e.anggota
                          .map((a) => AnggotaDepartemenItem(nama: a.nama))
                          .toList(),
                ),
              )
              .toList(),
      lembaga:
          _lembagaList
              .map(
                (e) => LembagaItem(
                  nama: e.nama,
                  direktur: e.direktur,
                  sekretaris: e.sekretaris,
                  anggota:
                      e.anggota
                          .map((a) => AnggotaLembagaItem(nama: a.nama))
                          .toList(),
                ),
              )
              .toList(),
      pelindung:
          _pelindungList.map((e) => PelindungItem(nama: e.nama)).toList(),
      pembina:
          _pembinaList.map((e) => PembinaItem(no: e.no, nama: e.nama)).toList(),
    );
  }
}

// Helper classes
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
  bool get isValid => title.isNotEmpty && nama.isNotEmpty;
}

class DepartemenData {
  final TextEditingController namaDepartemenController;
  final TextEditingController koordinatorController;
  final List<AnggotaDepartemenData> anggota = [];

  DepartemenData({
    required this.namaDepartemenController,
    required this.koordinatorController,
  });

  String get namaDepartemen => namaDepartemenController.text.trim();
  String get koordinator => koordinatorController.text.trim();

  void addAnggota({String nama = ''}) {
    anggota.add(
      AnggotaDepartemenData(namaController: TextEditingController(text: nama)),
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

  bool get isValid =>
      namaDepartemen.isNotEmpty && koordinator.isNotEmpty && anggota.isNotEmpty;
}

class AnggotaDepartemenData {
  final TextEditingController namaController;

  AnggotaDepartemenData({required this.namaController});

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

  String get nama => namaController.text.trim();
  String get direktur => direkturController.text.trim();
  String get sekretaris => sekretarisController.text.trim();

  void addAnggota({String nama = ''}) {
    anggota.add(
      AnggotaLembagaData(namaController: TextEditingController(text: nama)),
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

  bool get isValid =>
      nama.isNotEmpty &&
      direktur.isNotEmpty &&
      sekretaris.isNotEmpty &&
      anggota.isNotEmpty;
}

class AnggotaLembagaData {
  final TextEditingController namaController;

  AnggotaLembagaData({required this.namaController});

  void dispose() {
    namaController.dispose();
  }

  String get nama => namaController.text.trim();
  bool get isValid => nama.isNotEmpty;
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
