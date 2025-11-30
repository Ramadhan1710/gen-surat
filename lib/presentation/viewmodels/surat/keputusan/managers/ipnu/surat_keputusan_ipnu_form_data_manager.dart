import 'package:flutter/material.dart';
import 'package:gen_surat/domain/entities/ipnu/surat_keputusan_ipnu_entity.dart';

class SuratKeputusanIpnuFormDataManager {
  final jenisLembagaController = TextEditingController();
  final namaLembagaController = TextEditingController();
  final namaWilayahController = TextEditingController();

  final nomorSuratController = TextEditingController();
  final periodeRaptaController = TextEditingController();
  final tanggalHijriahController = TextEditingController();
  final tanggalMasehiController = TextEditingController();
  final waktuPenetapanController = TextEditingController();

  final periodeKepengurusanController = TextEditingController();
  final ketuaTerpilihController = TextEditingController();

  final namaKetuaController = TextEditingController();
  final namaSekretarisController = TextEditingController();
  final namaAnggotaController = TextEditingController();

  final List<TimFormaturData> _timFormaturList = [];

  String get jenisLembaga => jenisLembagaController.text.trim();
  String get namaLembaga => namaLembagaController.text.trim();
  String get namaWilayah => namaWilayahController.text.trim();

  String get nomorSurat => nomorSuratController.text.trim();
  String get periodeRapta => periodeRaptaController.text.trim();
  String get tanggalHijriah => tanggalHijriahController.text.trim();
  String get tanggalMasehi => tanggalMasehiController.text.trim();
  String get waktuPenetapan => waktuPenetapanController.text.trim();

  String get periodeKepengurusan => periodeKepengurusanController.text.trim();
  String get ketuaTerpilih => ketuaTerpilihController.text.trim();

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
    jenisLembagaController.clear();
    namaLembagaController.clear();
    namaWilayahController.clear();

    nomorSuratController.clear();
    periodeRaptaController.clear();
    tanggalHijriahController.clear();
    tanggalMasehiController.clear();
    waktuPenetapanController.clear();

    periodeKepengurusanController.clear();
    ketuaTerpilihController.clear();

    namaKetuaController.clear();
    namaSekretarisController.clear();
    namaAnggotaController.clear();

    clearTimFormatur();
  }

  void dispose() {
    jenisLembagaController.dispose();
    namaLembagaController.dispose();
    namaWilayahController.dispose();

    nomorSuratController.dispose();
    periodeRaptaController.dispose();
    tanggalHijriahController.dispose();
    tanggalMasehiController.dispose();
    waktuPenetapanController.dispose();

    periodeKepengurusanController.dispose();
    ketuaTerpilihController.dispose();

    namaKetuaController.dispose();
    namaSekretarisController.dispose();
    namaAnggotaController.dispose();

    clearTimFormatur();
  }

  SuratKeputusanIpnuEntity toEntity({
    required String ttdKetuaPath,
    required String ttdSekretarisPath,
    required String ttdAnggotaPath,
  }) {
    return SuratKeputusanIpnuEntity(
      jenisLembaga: jenisLembaga,
      namaLembaga: namaLembaga,
      periodeRapta: periodeRapta,
      nomorSurat: nomorSurat,
      periodeKepengurusan: periodeKepengurusan,
      ketuaTerpilih: ketuaTerpilih,
      namaWilayah: namaWilayah,
      tanggalHijriah: tanggalHijriah,
      tanggalMasehi: tanggalMasehi,
      waktuPenetapan: waktuPenetapan,
      namaKetua: namaKetua,
      namaSekretaris: namaSekretaris,
      namaAnggota: namaAnggota,
      ttdKetuaPath: ttdKetuaPath,
      ttdSekretarisPath: ttdSekretarisPath,
      ttdAnggotaPath: ttdAnggotaPath,
      timFormatur:
          _timFormaturList
              .map(
                (item) => TimFormaturEntity(
                  no: item.no,
                  nama: item.namaController.text.trim(),
                  daerahPengkaderan:
                      item.daerahPengkaderanController.text.trim(),
                ),
              )
              .toList(),
    );
  }

  bool hasMinimumData() {
    return jenisLembaga.isNotEmpty &&
        namaLembaga.isNotEmpty &&
        nomorSurat.isNotEmpty &&
        periodeKepengurusan.isNotEmpty &&
        _timFormaturList.isNotEmpty;
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
