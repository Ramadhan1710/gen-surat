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
    _timFormaturList.add(
      TimFormaturData(
        no: (_timFormaturList.length + 1).toString(),
        namaController: TextEditingController(text: nama),
        daerahPengkaderanController: TextEditingController(
          text: daerahPengkaderan,
        ),
      ),
    );
  }

  void removeTimFormatur(int index) {
    if (index >= 0 && index < _timFormaturList.length) {
      _timFormaturList[index].dispose();
      _timFormaturList.removeAt(index);

      _updateTimFormaturNumbering();
    }
  }

  void updateTimFormatur(int index, {String? nama, String? daerahPengkaderan}) {
    if (index >= 0 && index < _timFormaturList.length) {
      if (nama != null) {
        _timFormaturList[index].namaController.text = nama;
      }
      if (daerahPengkaderan != null) {
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

  TimFormaturData({
    required this.no,
    required this.namaController,
    required this.daerahPengkaderanController,
  });

  void dispose() {
    namaController.dispose();
    daerahPengkaderanController.dispose();
  }

  String get nama => namaController.text.trim();
  String get daerahPengkaderan => daerahPengkaderanController.text.trim();

  bool get isValid => nama.isNotEmpty && daerahPengkaderan.isNotEmpty;
}
