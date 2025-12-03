import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/constants/type_surat_constants.dart';
import '../../../core/exception/validation_exception.dart';
import '../../../data/mappers/ipnu/surat_keputusan_ipnu_mapper.dart';
import '../../entities/ipnu/surat_keputusan_ipnu_entity.dart';
import '../../../core/constants/api_constants.dart';
import '../../repositories/i_surat_repository.dart';

class GenerateSuratKeputusanIpnuUseCase {
  final ISuratRepository repository;

  GenerateSuratKeputusanIpnuUseCase(this.repository);

  Future<File> execute(
    SuratKeputusanIpnuEntity entity, {
    String? customSavePath,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    _validateEntity(entity);

    final model = SuratKeputusanIpnuMapper.toModel(entity);

    return await repository.generateSurat(
      data: model,
      lembaga: AppConstants.lembagaIpnu,
      typeSurat: TypeSuratConstants.suratKeputusan,
      endpoint: ApiConstants.suratKeputusanIpnuEndpoint,
      toMultipartMap: (data) => data.toMultipartMap(),
      customSavePath: customSavePath,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );
  }

  void _validateEntity(SuratKeputusanIpnuEntity entity) {
    if (entity.jenisLembaga.trim().isEmpty) {
      throw ValidationException('Jenis lembaga tidak boleh kosong');
    }

    if (entity.namaLembaga.trim().isEmpty) {
      throw ValidationException('Nama lembaga tidak boleh kosong');
    }

    if (entity.periodeRapta.trim().isEmpty) {
      throw ValidationException('Periode rapta tidak boleh kosong');
    }

    if (entity.nomorSurat.trim().isEmpty) {
      throw ValidationException('Nomor surat tidak boleh kosong');
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

    if (entity.ketuaTerpilih.trim().isEmpty) {
      throw ValidationException('Ketua terpilih tidak boleh kosong');
    }

    if (entity.namaWilayah.trim().isEmpty) {
      throw ValidationException('Nama wilayah tidak boleh kosong');
    }

    if (entity.namaKetua.trim().isEmpty) {
      throw ValidationException('Nama ketua tidak boleh kosong');
    }

    if (entity.namaSekretaris.trim().isEmpty) {
      throw ValidationException('Nama sekretaris tidak boleh kosong');
    }

    if (entity.namaAnggota.trim().isEmpty) {
      throw ValidationException('Nama anggota tidak boleh kosong');
    }

    if (entity.ttdKetuaPath.trim().isEmpty) {
      throw ValidationException('Path tanda tangan ketua tidak boleh kosong');
    }

    if (entity.ttdSekretarisPath.trim().isEmpty) {
      throw ValidationException(
        'Path tanda tangan sekretaris tidak boleh kosong',
      );
    }

    if (entity.ttdAnggotaPath.trim().isEmpty) {
      throw ValidationException('Path tanda tangan anggota tidak boleh kosong');
    }

    final ttdKetuaFile = File(entity.ttdKetuaPath);
    if (!ttdKetuaFile.existsSync()) {
      throw ValidationException('File tanda tangan ketua tidak ditemukan');
    }

    final ttdSekretarisFile = File(entity.ttdSekretarisPath);
    if (!ttdSekretarisFile.existsSync()) {
      throw ValidationException('File tanda tangan sekretaris tidak ditemukan');
    }

    final ttdAnggotaFile = File(entity.ttdAnggotaPath);
    if (!ttdAnggotaFile.existsSync()) {
      throw ValidationException('File tanda tangan anggota tidak ditemukan');
    }

    if (entity.timFormatur.isEmpty) {
      throw ValidationException('Tim formatur tidak boleh kosong');
    }
  }
}
