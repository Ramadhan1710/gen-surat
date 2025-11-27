import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';
import '../../../data/mappers/ipnu/surat_permohonan_pengesahan_ipnu_mapper.dart';
import '../../entities/surat_permohonan_pengesahan_ipnu_entity.dart';
import '../../repositories/i_surat_repository.dart';

/// UseCase untuk generate surat permohonan pengesahan IPNU
/// 
/// Mengikuti prinsip Single Responsibility (SOLID)
/// UseCase bertanggung jawab untuk orchestrate business logic dan validasi
class GenerateSuratPermohonanPengesahanIpnuUseCase {
  final ISuratRepository repository;

  GenerateSuratPermohonanPengesahanIpnuUseCase(this.repository);

  /// Execute usecase untuk generate surat
  /// 
  /// [entity] - Data surat yang akan di-generate
  /// [customSavePath] - Custom path untuk menyimpan file (optional)
  /// [onReceiveProgress] - Callback untuk track progress (optional)
  /// [cancelToken] - Token untuk cancel request (optional)
  /// 
  /// Returns: File yang sudah di-generate
  /// Throws: Exception jika validasi gagal atau terjadi error
  Future<File> execute(
    SuratPermohonanPengesahanIpnuEntity entity, {
    String? customSavePath,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    // Validasi entity sebelum dikirim ke repository
    _validateEntity(entity);

    // Convert entity ke model
    final model = SuratPermohonanPengesahanIpnuMapper.toModel(entity);

    // Delegate ke repository dengan generic method
    return await repository.generateSurat(
      data: model,
      lembaga: "ipnu",
      typeSurat: "surat_permohonan_pengesahan",
      endpoint: ApiConstants.suratPermohonanPengesahanIpnuEndpoint,
      toMultipartMap: (data) => data.toMultipartMap(),
      customSavePath: customSavePath,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );
  }

  /// Validasi data entity
  void _validateEntity(SuratPermohonanPengesahanIpnuEntity entity) {
    if (entity.jenisLembaga.trim().isEmpty) {
      throw ValidationException('Jenis lembaga tidak boleh kosong');
    }
    
    if (entity.namaLembaga.trim().isEmpty) {
      throw ValidationException('Nama lembaga tidak boleh kosong');
    }
    
    if (entity.nomorTeleponLembaga.trim().isEmpty) {
      throw ValidationException('Nomor telepon lembaga tidak boleh kosong');
    }
    
    if (entity.alamatLembaga.trim().isEmpty) {
      throw ValidationException('Alamat lembaga tidak boleh kosong');
    }
    
    if (entity.emailLembaga.trim().isEmpty) {
      throw ValidationException('Email lembaga tidak boleh kosong');
    }
    
    if (entity.nomorSurat.trim().isEmpty) {
      throw ValidationException('Nomor surat tidak boleh kosong');
    }
    
    if (entity.tanggalRapat.trim().isEmpty) {
      throw ValidationException('Tanggal rapat tidak boleh kosong');
    }
    
    if (entity.tanggalHijriah.trim().isEmpty) {
      throw ValidationException('Tanggal hijriah tidak boleh kosong');
    }
    
    if (entity.tanggalMasehi.trim().isEmpty) {
      throw ValidationException('Tanggal masehi tidak boleh kosong');
    }
    
    if (entity.periodeKepengurusan.trim().isEmpty) {
      throw ValidationException('Periode kepengurusan tidak boleh kosong');
    }
    
    if (entity.namaKetuaTerpilih.trim().isEmpty) {
      throw ValidationException('Nama ketua terpilih tidak boleh kosong');
    }
    
    if (entity.namaSekretarisTerpilih.trim().isEmpty) {
      throw ValidationException('Nama sekretaris terpilih tidak boleh kosong');
    }
    
    if (entity.jenisLembagaInduk.trim().isEmpty) {
      throw ValidationException('Jenis lembaga induk tidak boleh kosong');
    }
    
    if (entity.ttdKetuaPath.trim().isEmpty) {
      throw ValidationException('Path tanda tangan ketua tidak boleh kosong');
    }
    
    if (entity.ttdSekretarisPath.trim().isEmpty) {
      throw ValidationException('Path tanda tangan sekretaris tidak boleh kosong');
    }

    // Validasi file exists
    final ttdKetuaFile = File(entity.ttdKetuaPath);
    if (!ttdKetuaFile.existsSync()) {
      throw ValidationException('File tanda tangan ketua tidak ditemukan');
    }

    final ttdSekretarisFile = File(entity.ttdSekretarisPath);
    if (!ttdSekretarisFile.existsSync()) {
      throw ValidationException('File tanda tangan sekretaris tidak ditemukan');
    }

    // Validasi email format
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(entity.emailLembaga)) {
      throw ValidationException('Format email tidak valid');
    }
  }
}

/// Custom exception untuk validation error
class ValidationException implements Exception {
  final String message;

  ValidationException(this.message);

  @override
  String toString() => 'ValidationException: $message';
}
