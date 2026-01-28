import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gen_surat/core/constants/form_surat_storage_key_constants.dart';
import 'package:gen_surat/core/services/form_storage_service.dart';
import 'package:gen_surat/domain/entities/ipnu/surat_keputusan_ipnu_entity.dart';

class SuratKeputusanIpnuFormDataManager {
  // Controllers for form fields
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

  // focus nodes for form fields
  final jenisLembagaFocus = FocusNode();
  final namaLembagaFocus = FocusNode();
  final namaWilayahFocus = FocusNode();
  final nomorSuratFocus = FocusNode();
  final periodeRaptaFocus = FocusNode();
  final tanggalHijriahFocus = FocusNode();
  final tanggalMasehiFocus = FocusNode();
  final waktuPenetapanFocus = FocusNode();
  final periodeKepengurusanFocus = FocusNode();
  final ketuaTerpilihFocus = FocusNode();
  final namaKetuaFocus = FocusNode();
  final namaSekretarisFocus = FocusNode();
  final namaAnggotaFocus = FocusNode();
  final List<FocusNode> timFormaturFocusNodes = [];

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

  // Auto-save timer untuk debouncing
  Timer? _autoSaveTimer;
  final _autoSaveDuration = Duration(seconds: 2);
  bool _isLoading = false; // Flag untuk prevent auto-save saat loading

  // constructor - step auto-save listeners
  SuratKeputusanIpnuFormDataManager() {
    _setupAutoSave();
    // Load data dari local storage saat initialization
    loadFromLocal();
  }

  // setup listener for auto-save for all controllers
  void _setupAutoSave() {
    jenisLembagaController.addListener(_triggerAutoSave);
    namaLembagaController.addListener(_triggerAutoSave);
    namaWilayahController.addListener(_triggerAutoSave);
    nomorSuratController.addListener(_triggerAutoSave);
    periodeRaptaController.addListener(_triggerAutoSave);
    tanggalHijriahController.addListener(_triggerAutoSave);
    tanggalMasehiController.addListener(_triggerAutoSave);
    waktuPenetapanController.addListener(_triggerAutoSave);
    periodeKepengurusanController.addListener(_triggerAutoSave);
    ketuaTerpilihController.addListener(_triggerAutoSave);
    namaKetuaController.addListener(_triggerAutoSave);
    namaSekretarisController.addListener(_triggerAutoSave);
    namaAnggotaController.addListener(_triggerAutoSave);
  }

  void _triggerAutoSave() {
    if (_isLoading) return; // Skip jika sedang loading

    _autoSaveTimer?.cancel();
    _autoSaveTimer = Timer(_autoSaveDuration, () {
      saveToLocal();
    });
  }

  Future<void> saveToLocal() async {
    final data = {
      'jenisLembaga': jenisLembagaController.text,
      'namaLembaga': namaLembagaController.text,
      'namaWilayah': namaWilayahController.text,
      'nomorSurat': nomorSuratController.text,
      'periodeRapta': periodeRaptaController.text,
      'tanggalHijriah': tanggalHijriahController.text,
      'tanggalMasehi': tanggalMasehiController.text,
      'waktuPenetapan': waktuPenetapanController.text,
      'periodeKepengurusan': periodeKepengurusanController.text,
      'ketuaTerpilih': ketuaTerpilihController.text,
      'namaKetua': namaKetuaController.text,
      'namaSekretaris': namaSekretarisController.text,
      'namaAnggota': namaAnggotaController.text,
      'timFormaturList':
          _timFormaturList
              .map(
                (item) => {
                  'nama': item.nama,
                  'daerahPengkaderan': item.daerahPengkaderan,
                },
              )
              .toList(),
    };

    await FormSuratStorageService.saveFormData(
      FormSuratStorageKeyConstants.suratKeputusanIpnu,
      data,
    );

    log("jenisLembaga: ${jenisLembagaController.text}");

    log("Auto-saved form surat keputusan ipnu:  ${DateTime.now()} ");
  }

  Future<void> loadFromLocal() async {
    _isLoading = true; // Set flag untuk disable auto-save

    final data = FormSuratStorageService.getFormData(
      FormSuratStorageKeyConstants.suratKeputusanIpnu,
    );

    if (data == null) {
      _isLoading = false;
      return;
    }

    jenisLembagaController.text = data['jenisLembaga'] ?? '';
    namaLembagaController.text = data['namaLembaga'] ?? '';
    namaWilayahController.text = data['namaWilayah'] ?? '';
    nomorSuratController.text = data['nomorSurat'] ?? '';
    periodeRaptaController.text = data['periodeRapta'] ?? '';
    tanggalHijriahController.text = data['tanggalHijriah'] ?? '';
    tanggalMasehiController.text = data['tanggalMasehi'] ?? '';
    waktuPenetapanController.text = data['waktuPenetapan'] ?? '';
    periodeKepengurusanController.text = data['periodeKepengurusan'] ?? '';
    ketuaTerpilihController.text = data['ketuaTerpilih'] ?? '';
    namaKetuaController.text = data['namaKetua'] ?? '';
    namaSekretarisController.text = data['namaSekretaris'] ?? '';
    namaAnggotaController.text = data['namaAnggota'] ?? '';

    // Load tim formatur list dengan casting yang benar
    if (data['timFormaturList'] != null) {
      _timFormaturList.clear();
      final list = data['timFormaturList'] as List;
      for (var item in list) {
        final itemMap = Map<String, dynamic>.from(item as Map);
        addTimFormatur(
          nama: itemMap['nama'] ?? '',
          daerahPengkaderan: itemMap['daerahPengkaderan'] ?? '',
        );
      }
    }

    _isLoading = false; // Re-enable auto-save setelah loading selesai
    log("✓ Loaded from local: ${data['lastSaved']}");
  }

  bool hasLocalData() {
    return FormSuratStorageService.hasFormData(
      FormSuratStorageKeyConstants.suratKeputusanIpnu,
    );
  }

  Future<void> clearLocalData() async {
    await FormSuratStorageService.deleteFormData(
      FormSuratStorageKeyConstants.suratKeputusanIpnu,
    );
    log("✓ Cleared local data for surat keputusan ipnu");
  }

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

    // Buat controllers baru
    final namaController = TextEditingController(text: nama);
    final daerahController = TextEditingController(
      text: finalDaerahPengkaderan,
    );

    // Setup listener untuk auto-save
    namaController.addListener(_triggerAutoSave);
    daerahController.addListener(_triggerAutoSave);

    _timFormaturList.add(
      TimFormaturData(
        no: (currentIndex + 1).toString(),
        namaController: namaController,
        daerahPengkaderanController: daerahController,
        isDaerahPengkaderanReadOnly: isReadOnly,
      ),
    );

    // Trigger save setelah add (kecuali saat loading)
    if (!_isLoading) {
      _triggerAutoSave();
    }
  }

  void removeTimFormatur(int index) {
    if (index >= 0 && index < _timFormaturList.length) {
      _timFormaturList[index].dispose();
      _timFormaturList.removeAt(index);

      _updateTimFormaturNumbering();
      _updateTimFormaturReadOnlyStatus();

      // Trigger save setelah remove
      _triggerAutoSave();
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

    _autoSaveTimer?.cancel();
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
