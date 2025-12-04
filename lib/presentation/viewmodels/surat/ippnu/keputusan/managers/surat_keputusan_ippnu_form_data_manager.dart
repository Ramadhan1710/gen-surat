import 'package:flutter/material.dart';
import '../../../../../../domain/entities/ippnu/surat_keputusan_ippnu_entity.dart';

class SuratKeputusanIppnuFormDataManager {
  // Controllers
  final periodeRaptaController = TextEditingController();
  final jenisLembagaController = TextEditingController();
  final nomorSuratController = TextEditingController();
  final namaLembagaController = TextEditingController();
  final periodeKepengurusanController = TextEditingController();
  final ketuaTerpilihController = TextEditingController();
  final namaWilayahController = TextEditingController();
  final tanggalHijriahController = TextEditingController();
  final tanggalMasehiController = TextEditingController();
  final waktuPenetapanController = TextEditingController();
  final namaKetuaController = TextEditingController();
  final namaSekretarisController = TextEditingController();
  final namaAnggotaController = TextEditingController();

  // Focus nodes
  final periodeRaptaFocus = FocusNode();
  final jenisLembagaFocus = FocusNode();
  final nomorSuratFocus = FocusNode();
  final namaLembagaFocus = FocusNode();
  final periodeKepengurusanFocus = FocusNode();
  final ketuaTerpilihFocus = FocusNode();
  final namaWilayahFocus = FocusNode();
  final tanggalHijriahFocus = FocusNode();
  final tanggalMasehiFocus = FocusNode();
  final waktuPenetapanFocus = FocusNode();
  final namaKetuaFocus = FocusNode();
  final namaSekretarisFocus = FocusNode();
  final namaAnggotaFocus = FocusNode();

  // Tim Formatur List
  final List<TimFormaturData> _timFormaturList = [];

  // Getters
  String get periodeRapta => periodeRaptaController.text.trim();
  String get jenisLembaga => jenisLembagaController.text.trim();
  String get nomorSurat => nomorSuratController.text.trim();
  String get namaLembaga => namaLembagaController.text.trim();
  String get periodeKepengurusan => periodeKepengurusanController.text.trim();
  String get ketuaTerpilih => ketuaTerpilihController.text.trim();
  String get namaWilayah => namaWilayahController.text.trim();
  String get tanggalHijriah => tanggalHijriahController.text.trim();
  String get tanggalMasehi => tanggalMasehiController.text.trim();
  String get waktuPenetapan => waktuPenetapanController.text.trim();
  String get namaKetua => namaKetuaController.text.trim();
  String get namaSekretaris => namaSekretarisController.text.trim();
  String get namaAnggota => namaAnggotaController.text.trim();

  List<TimFormaturData> get timFormatur => _timFormaturList;
  int get timFormaturCount => _timFormaturList.length;

  void addTimFormatur({String nama = '', String daerahPengkaderan = ''}) {
    final currentIndex = _timFormaturList.length;
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

    _timFormaturList.add(
      TimFormaturData(
        no: (currentIndex + 1).toString(),
        namaController: TextEditingController(text: nama),
        daerahPengkaderanController: TextEditingController(
          text: finalDaerahPengkaderan,
        ),
        isDaerahPengkaderanReadOnly: isReadOnly,
      ),
    );
  }

  void removeTimFormatur(int index) {
    if (index >= 0 && index < _timFormaturList.length) {
      _timFormaturList[index].dispose();
      _timFormaturList.removeAt(index);

      _updateTimFormaturNumbering();
      _updateTimFormaturReadOnlyStatus();
    }
  }

  void updateTimFormatur(int index, {String? nama, String? daerahPengkaderan}) {
    if (index >= 0 && index < _timFormaturList.length) {
      if (nama != null) {
        _timFormaturList[index].namaController.text = nama;
      }
      // Hanya update daerah pengkaderan jika tidak readonly
      if (daerahPengkaderan != null &&
          !_timFormaturList[index].isDaerahPengkaderanReadOnly) {
        _timFormaturList[index].daerahPengkaderanController.text =
            daerahPengkaderan;
      }
    }
  }

  void clearTimFormatur() {
    for (var item in _timFormaturList) {
      item.dispose();
    }
    _timFormaturList.clear();
  }

  void _updateTimFormaturNumbering() {
    for (int i = 0; i < _timFormaturList.length; i++) {
      _timFormaturList[i].no = (i + 1).toString();
    }
  }

  void _updateTimFormaturReadOnlyStatus() {
    for (int i = 0; i < _timFormaturList.length; i++) {
      // Update daerah pengkaderan dan readonly status untuk anggota 1 dan 2
      if (i == 0) {
        _timFormaturList[i].daerahPengkaderanController.text =
            'Ketua Terpilih / Ketua Formatur';
        _timFormaturList[i].setReadOnly(true);
      } else if (i == 1) {
        _timFormaturList[i].daerahPengkaderanController.text =
            'Ketua Demisioner';
        _timFormaturList[i].setReadOnly(true);
      } else {
        // Untuk anggota lainnya, set menjadi tidak readonly
        _timFormaturList[i].setReadOnly(false);
      }
    }
  }

  void clear() {
    periodeRaptaController.clear();
    jenisLembagaController.clear();
    nomorSuratController.clear();
    namaLembagaController.clear();
    periodeKepengurusanController.clear();
    ketuaTerpilihController.clear();
    namaWilayahController.clear();
    tanggalHijriahController.clear();
    tanggalMasehiController.clear();
    waktuPenetapanController.clear();
    namaKetuaController.clear();
    namaSekretarisController.clear();
    namaAnggotaController.clear();
    clearTimFormatur();
  }

  void dispose() {
    periodeRaptaController.dispose();
    jenisLembagaController.dispose();
    nomorSuratController.dispose();
    namaLembagaController.dispose();
    periodeKepengurusanController.dispose();
    ketuaTerpilihController.dispose();
    namaWilayahController.dispose();
    tanggalHijriahController.dispose();
    tanggalMasehiController.dispose();
    waktuPenetapanController.dispose();
    namaKetuaController.dispose();
    namaSekretarisController.dispose();
    namaAnggotaController.dispose();

    periodeRaptaFocus.dispose();
    jenisLembagaFocus.dispose();
    nomorSuratFocus.dispose();
    namaLembagaFocus.dispose();
    periodeKepengurusanFocus.dispose();
    ketuaTerpilihFocus.dispose();
    namaWilayahFocus.dispose();
    tanggalHijriahFocus.dispose();
    tanggalMasehiFocus.dispose();
    waktuPenetapanFocus.dispose();
    namaKetuaFocus.dispose();
    namaSekretarisFocus.dispose();
    namaAnggotaFocus.dispose();

    clearTimFormatur();
  }

  SuratKeputusanIppnuEntity toEntity({
    required String ttdKetuaPath,
    required String ttdSekretarisPath,
    required String ttdAnggotaPath,
  }) {
    return SuratKeputusanIppnuEntity(
      periodeRapta: periodeRapta,
      jenisLembaga: jenisLembaga,
      nomorSurat: nomorSurat,
      namaLembaga: namaLembaga,
      periodeKepengurusan: periodeKepengurusan,
      ketuaTerpilih: ketuaTerpilih,
      namaWilayah: namaWilayah,
      tanggalHijriah: tanggalHijriah,
      tanggalMasehi: tanggalMasehi,
      waktuPenetapan: waktuPenetapan,
      namaKetua: namaKetua,
      namaSekretaris: namaSekretaris,
      namaAnggota: namaAnggota,
      timFormatur: _timFormaturList
          .map((e) => TimFormaturItem(
                no: int.parse(e.no),
                nama: e.nama,
                daerahPengkaderan: e.daerahPengkaderan,
              ))
          .toList(),
      ttdKetuaPath: ttdKetuaPath,
      ttdSekretarisPath: ttdSekretarisPath,
      ttdAnggotaPath: ttdAnggotaPath,
    );
  }
}

class TimFormaturData {
  String no;
  final TextEditingController namaController;
  final TextEditingController daerahPengkaderanController;
  bool isDaerahPengkaderanReadOnly;

  TimFormaturData({
    required this.no,
    required this.namaController,
    required this.daerahPengkaderanController,
    this.isDaerahPengkaderanReadOnly = false,
  });

  void setReadOnly(bool value) {
    isDaerahPengkaderanReadOnly = value;
  }

  void dispose() {
    namaController.dispose();
    daerahPengkaderanController.dispose();
  }

  String get nama => namaController.text.trim();
  String get daerahPengkaderan => daerahPengkaderanController.text.trim();

  bool get isValid => nama.isNotEmpty && daerahPengkaderan.isNotEmpty;
}
