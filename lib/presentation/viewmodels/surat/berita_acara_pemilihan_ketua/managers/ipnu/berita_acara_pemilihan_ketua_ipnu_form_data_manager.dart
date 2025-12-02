
import 'package:flutter/material.dart';
import 'package:gen_surat/domain/entities/ipnu/berita_acara_pemilihan_ketua_ipnu_entity.dart';

class BeritaAcaraPemilihanKetuaIpnuFormDataManager {
  // Informasi Lembaga
  final jenisLembagaController = TextEditingController();
  final namaLembagaController = TextEditingController();
  final periodeKepengurusanController = TextEditingController();

  // Waktu & Tempat Pemilihan Ketua
  final tanggalController = TextEditingController();
  final bulanController = TextEditingController();
  final tahunController = TextEditingController();
  final waktuPemilihanKetuaController = TextEditingController();
  final tempatPemilihanKetuaController = TextEditingController();

  // Total Suara
  final totalSuaraSahPencalonanKetuaController = TextEditingController();
  final totalSuaraTidakSahPencalonanKetuaController = TextEditingController();
  final totalSuaraTidakSahPemilihanKetuaController = TextEditingController();
  final totalSuaraSahPemilihanKetuaController = TextEditingController();

  // Informasi Penetapan
  final namaWilayahController = TextEditingController();
  final tanggalHijriahController = TextEditingController();
  final tanggalMasehiController = TextEditingController();
  final waktuPenetapanController = TextEditingController();

  // Pejabat Sidang
  final namaKetuaController = TextEditingController();
  final namaSekretarisController = TextEditingController();
  final namaAnggotaController = TextEditingController();

  // Ketua Terpilih
  final namaKetuaTerpilihController = TextEditingController();
  final alamatKetuaTerpilihController = TextEditingController();
  final totalSuaraKetuaTerpilihController = TextEditingController();

  // Array Lists
  final List<PencalonanKetuaData> _pencalonanKetuaList = [];
  final List<PemilihanKetuaData> _pemilihanKetuaList = [];
  final List<FormaturData> _formaturList = [];

  // Getters
  String get jenisLembaga => jenisLembagaController.text.trim();
  String get namaLembaga => namaLembagaController.text.trim();
  String get periodeKepengurusan => periodeKepengurusanController.text.trim();

  String get tanggal => tanggalController.text.trim();
  String get bulan => bulanController.text.trim();
  String get tahun => tahunController.text.trim();
  String get waktuPemilihanKetua => waktuPemilihanKetuaController.text.trim();
  String get tempatPemilihanKetua => tempatPemilihanKetuaController.text.trim();

  int get totalSuaraSahPencalonanKetua =>
      int.tryParse(totalSuaraSahPencalonanKetuaController.text.trim()) ?? 0;
  int get totalSuaraTidakSahPencalonanKetua =>
      int.tryParse(totalSuaraTidakSahPencalonanKetuaController.text.trim()) ?? 0;
  int get totalSuaraTidakSahPemilihanKetua =>
      int.tryParse(totalSuaraTidakSahPemilihanKetuaController.text.trim()) ?? 0;
  int get totalSuaraSahPemilihanKetua =>
      int.tryParse(totalSuaraSahPemilihanKetuaController.text.trim()) ?? 0;

  // Computed totals (sum of individual candidate votes)
  int get computedTotalSuaraSahPencalonanKetua {
    return _pencalonanKetuaList.fold(
        0, (int sum, PencalonanKetuaData item) => sum + item.jmlSuaraSah);
  }

  int get computedTotalSuaraSahPemilihanKetua {
    return _pemilihanKetuaList.fold(
        0, (int sum, PemilihanKetuaData item) => sum + item.jmlSuaraSah);
  }

  String get namaWilayah => namaWilayahController.text.trim();
  String get tanggalHijriah => tanggalHijriahController.text.trim();
  String get tanggalMasehi => tanggalMasehiController.text.trim();
  String get waktuPenetapan => waktuPenetapanController.text.trim();

  String get namaKetua => namaKetuaController.text.trim();
  String get namaSekretaris => namaSekretarisController.text.trim();
  String get namaAnggota => namaAnggotaController.text.trim();

  String get namaKetuaTerpilih => namaKetuaTerpilihController.text.trim();
  String get alamatKetuaTerpilih => alamatKetuaTerpilihController.text.trim();
  int get totalSuaraKetuaTerpilih =>
      int.tryParse(totalSuaraKetuaTerpilihController.text.trim()) ?? 0;

  List<PencalonanKetuaData> get pencalonanKetua => _pencalonanKetuaList;
  int get pencalonanKetuaCount => _pencalonanKetuaList.length;

  List<PemilihanKetuaData> get pemilihanKetua => _pemilihanKetuaList;
  int get pemilihanKetuaCount => _pemilihanKetuaList.length;

  List<FormaturData> get formatur => _formaturList;
  int get formaturCount => _formaturList.length;

  // ========== Pencalonan Ketua Management ==========

  VoidCallback? _onPencalonanSuaraChanged;

  void setOnPencalonanSuaraChangedListener(VoidCallback callback) {
    _onPencalonanSuaraChanged = callback;
    // Add listener to existing items
    for (var item in _pencalonanKetuaList) {
      item.jmlSuaraSahController.removeListener(_onPencalonanSuaraChanged!);
      item.jmlSuaraSahController.addListener(_onPencalonanSuaraChanged!);
    }
  }

  void addPencalonanKetua({
    String nama = '',
    String alamat = '',
    String jmlSuaraSah = '',
  }) {
    final controller = TextEditingController(text: jmlSuaraSah);
    if (_onPencalonanSuaraChanged != null) {
      controller.addListener(_onPencalonanSuaraChanged!);
    }
    _pencalonanKetuaList.add(
      PencalonanKetuaData(
        nomor: _pencalonanKetuaList.length + 1,
        namaController: TextEditingController(text: nama),
        alamatController: TextEditingController(text: alamat),
        jmlSuaraSahController: controller,
      ),
    );
  }

  void removePencalonanKetua(int index) {
    if (index >= 0 && index < _pencalonanKetuaList.length) {
      _pencalonanKetuaList[index].dispose();
      _pencalonanKetuaList.removeAt(index);
      _updatePencalonanKetuaNumbering();
    }
  }

  void _updatePencalonanKetuaNumbering() {
    for (int i = 0; i < _pencalonanKetuaList.length; i++) {
      _pencalonanKetuaList[i].nomor = i + 1;
    }
  }

  void clearPencalonanKetua() {
    for (var item in _pencalonanKetuaList) {
      item.dispose();
    }
    _pencalonanKetuaList.clear();
  }

  // ========== Pemilihan Ketua Management ==========

  VoidCallback? _onPemilihanSuaraChanged;

  void setOnPemilihanSuaraChangedListener(VoidCallback callback) {
    _onPemilihanSuaraChanged = callback;
    // Add listener to existing items
    for (var item in _pemilihanKetuaList) {
      item.jmlSuaraSahController.removeListener(_onPemilihanSuaraChanged!);
      item.jmlSuaraSahController.addListener(_onPemilihanSuaraChanged!);
    }
  }

  void addPemilihanKetua({
    String nama = '',
    String alamat = '',
    String jmlSuaraSah = '',
  }) {
    final controller = TextEditingController(text: jmlSuaraSah);
    if (_onPemilihanSuaraChanged != null) {
      controller.addListener(_onPemilihanSuaraChanged!);
    }
    _pemilihanKetuaList.add(
      PemilihanKetuaData(
        nomor: _pemilihanKetuaList.length + 1,
        namaController: TextEditingController(text: nama),
        alamatController: TextEditingController(text: alamat),
        jmlSuaraSahController: controller,
      ),
    );
  }

  void removePemilihanKetua(int index) {
    if (index >= 0 && index < _pemilihanKetuaList.length) {
      _pemilihanKetuaList[index].dispose();
      _pemilihanKetuaList.removeAt(index);
      _updatePemilihanKetuaNumbering();
    }
  }

  void _updatePemilihanKetuaNumbering() {
    for (int i = 0; i < _pemilihanKetuaList.length; i++) {
      _pemilihanKetuaList[i].nomor = i + 1;
    }
  }

  void clearPemilihanKetua() {
    for (var item in _pemilihanKetuaList) {
      item.dispose();
    }
    _pemilihanKetuaList.clear();
  }

  // ========== Formatur Management ==========

  void addFormatur({
    String nama = '',
    String alamat = '',
    String daerahPengkaderan = '',
  }) {
    final currentIndex = _formaturList.length;
    String finalDaerahPengkaderan = daerahPengkaderan;
    bool isReadOnly = false;

    // Anggota 1: Ketua Terpilih / Ketua Formatur (otomatis & readonly)
    if (currentIndex == 0) {
      finalDaerahPengkaderan = 'Ketua Terpilih / Ketua Formatur';
      isReadOnly = true;
    }
    // Anggota 2: Ketua Demisioner (otomatis & readonly)
    else if (currentIndex == 1) {
      finalDaerahPengkaderan = 'Ketua Demisioner';
      isReadOnly = true;
    }

    _formaturList.add(
      FormaturData(
        nomor: currentIndex + 1,
        namaController: TextEditingController(text: nama),
        alamatController: TextEditingController(text: alamat),
        daerahPengkaderanController: TextEditingController(
          text: finalDaerahPengkaderan,
        ),
        isDaerahPengkaderanReadOnly: isReadOnly,
      ),
    );
  }

  void removeFormatur(int index) {
    if (index >= 0 && index < _formaturList.length) {
      _formaturList[index].dispose();
      _formaturList.removeAt(index);
      _updateFormaturNumbering();
      _updateFormaturReadOnlyStatus();
    }
  }

  void _updateFormaturNumbering() {
    for (int i = 0; i < _formaturList.length; i++) {
      _formaturList[i].nomor = i + 1;
    }
  }

  void _updateFormaturReadOnlyStatus() {
    for (int i = 0; i < _formaturList.length; i++) {
      if (i == 0) {
        _formaturList[i].daerahPengkaderanController.text =
            'Ketua Terpilih / Ketua Formatur';
        _formaturList[i].setReadOnly(true);
      } else if (i == 1) {
        _formaturList[i].daerahPengkaderanController.text = 'Ketua Demisioner';
        _formaturList[i].setReadOnly(true);
      } else {
        _formaturList[i].setReadOnly(false);
      }
    }
  }

  void clearFormatur() {
    for (var item in _formaturList) {
      item.dispose();
    }
    _formaturList.clear();
  }

  // ========== Clear & Dispose ==========

  void clear() {
    jenisLembagaController.clear();
    namaLembagaController.clear();
    periodeKepengurusanController.clear();

    tanggalController.clear();
    bulanController.clear();
    tahunController.clear();
    waktuPemilihanKetuaController.clear();
    tempatPemilihanKetuaController.clear();

    totalSuaraSahPencalonanKetuaController.clear();
    totalSuaraTidakSahPencalonanKetuaController.clear();
    totalSuaraTidakSahPemilihanKetuaController.clear();
    totalSuaraSahPemilihanKetuaController.clear();

    namaWilayahController.clear();
    tanggalHijriahController.clear();
    tanggalMasehiController.clear();
    waktuPenetapanController.clear();

    namaKetuaController.clear();
    namaSekretarisController.clear();
    namaAnggotaController.clear();

    namaKetuaTerpilihController.clear();
    alamatKetuaTerpilihController.clear();
    totalSuaraKetuaTerpilihController.clear();

    clearPencalonanKetua();
    clearPemilihanKetua();
    clearFormatur();
  }

  void dispose() {
    jenisLembagaController.dispose();
    namaLembagaController.dispose();
    periodeKepengurusanController.dispose();

    tanggalController.dispose();
    bulanController.dispose();
    tahunController.dispose();
    waktuPemilihanKetuaController.dispose();
    tempatPemilihanKetuaController.dispose();

    totalSuaraSahPencalonanKetuaController.dispose();
    totalSuaraTidakSahPencalonanKetuaController.dispose();
    totalSuaraTidakSahPemilihanKetuaController.dispose();
    totalSuaraSahPemilihanKetuaController.dispose();

    namaWilayahController.dispose();
    tanggalHijriahController.dispose();
    tanggalMasehiController.dispose();
    waktuPenetapanController.dispose();

    namaKetuaController.dispose();
    namaSekretarisController.dispose();
    namaAnggotaController.dispose();

    namaKetuaTerpilihController.dispose();
    alamatKetuaTerpilihController.dispose();
    totalSuaraKetuaTerpilihController.dispose();

    clearPencalonanKetua();
    clearPemilihanKetua();
    clearFormatur();
  }

  // ========== To Entity ==========

  BeritaAcaraPemilihanKetuaIpnuEntity toEntity({
    required String ttdKetuaPath,
    required String ttdSekretarisPath,
    required String ttdAnggotaPath,
  }) {
    return BeritaAcaraPemilihanKetuaIpnuEntity(
      jenisLembaga: jenisLembaga,
      namaLembaga: namaLembaga,
      periodeKepengurusan: periodeKepengurusan,
      tanggal: tanggal,
      bulan: bulan,
      tahun: tahun,
      waktuPemilihanKetua: waktuPemilihanKetua,
      tempatPemilihanKetua: tempatPemilihanKetua,
      totalSuaraSahPencalonanKetua: computedTotalSuaraSahPencalonanKetua,
      totalSuaraTidakSahPencalonanKetua: totalSuaraTidakSahPencalonanKetua,
      totalSuaraTidakSahPemilihanKetua: totalSuaraTidakSahPemilihanKetua,
      totalSuaraSahPemilihanKetua: computedTotalSuaraSahPemilihanKetua,
      namaWilayah: namaWilayah,
      tanggalHijriah: tanggalHijriah,
      tanggalMasehi: tanggalMasehi,
      waktuPenetapan: waktuPenetapan,
      namaKetua: namaKetua,
      namaSekretaris: namaSekretaris,
      namaAnggota: namaAnggota,
      pencalonanKetua: _pencalonanKetuaList
          .map(
            (item) => PencalonanKetuaEntity(
              nomor: item.nomor,
              nama: item.namaController.text.trim(),
              alamat: item.alamatController.text.trim(),
              jmlSuaraSah: item.jmlSuaraSah,
            ),
          )
          .toList(),
      pemilihanKetua: _pemilihanKetuaList
          .map(
            (item) => PemilihanKetuaEntity(
              nomor: item.nomor,
              nama: item.namaController.text.trim(),
              alamat: item.alamatController.text.trim(),
              jmlSuaraSah: item.jmlSuaraSah,
            ),
          )
          .toList(),
      namaKetuaTerpilih: namaKetuaTerpilih,
      alamatKetuaTerpilih: alamatKetuaTerpilih,
      totalSuaraKetuaTerpilih: totalSuaraKetuaTerpilih,
      formatur: _formaturList
          .map(
            (item) => FormaturEntity(
              nomor: item.nomor,
              nama: item.namaController.text.trim(),
              alamat: item.alamatController.text.trim(),
              daerahPengkaderan: item.daerahPengkaderanController.text.trim(),
            ),
          )
          .toList(),
      ttdKetuaPath: ttdKetuaPath,
      ttdSekretarisPath: ttdSekretarisPath,
      ttdAnggotaPath: ttdAnggotaPath,
    );
  }
}

// ========== Data Classes ==========

class PencalonanKetuaData {
  int nomor;
  final TextEditingController namaController;
  final TextEditingController alamatController;
  final TextEditingController jmlSuaraSahController;

  PencalonanKetuaData({
    required this.nomor,
    required this.namaController,
    required this.alamatController,
    required this.jmlSuaraSahController,
  });

  void dispose() {
    namaController.dispose();
    alamatController.dispose();
    jmlSuaraSahController.dispose();
  }

  String get nama => namaController.text.trim();
  String get alamat => alamatController.text.trim();
  int get jmlSuaraSah =>
      int.tryParse(jmlSuaraSahController.text.trim()) ?? 0;

  bool get isValid => nama.isNotEmpty && alamat.isNotEmpty && jmlSuaraSah > 0;
}

class PemilihanKetuaData {
  int nomor;
  final TextEditingController namaController;
  final TextEditingController alamatController;
  final TextEditingController jmlSuaraSahController;

  PemilihanKetuaData({
    required this.nomor,
    required this.namaController,
    required this.alamatController,
    required this.jmlSuaraSahController,
  });

  void dispose() {
    namaController.dispose();
    alamatController.dispose();
    jmlSuaraSahController.dispose();
  }

  String get nama => namaController.text.trim();
  String get alamat => alamatController.text.trim();
  int get jmlSuaraSah =>
      int.tryParse(jmlSuaraSahController.text.trim()) ?? 0;

  bool get isValid => nama.isNotEmpty && alamat.isNotEmpty && jmlSuaraSah > 0;
}

class FormaturData {
  int nomor;
  final TextEditingController namaController;
  final TextEditingController alamatController;
  final TextEditingController daerahPengkaderanController;
  bool isDaerahPengkaderanReadOnly;

  FormaturData({
    required this.nomor,
    required this.namaController,
    required this.alamatController,
    required this.daerahPengkaderanController,
    this.isDaerahPengkaderanReadOnly = false,
  });

  void setReadOnly(bool value) {
    isDaerahPengkaderanReadOnly = value;
  }

  void dispose() {
    namaController.dispose();
    alamatController.dispose();
    daerahPengkaderanController.dispose();
  }

  String get nama => namaController.text.trim();
  String get alamat => alamatController.text.trim();
  String get daerahPengkaderan => daerahPengkaderanController.text.trim();

  bool get isValid =>
      nama.isNotEmpty && alamat.isNotEmpty && daerahPengkaderan.isNotEmpty;
}
