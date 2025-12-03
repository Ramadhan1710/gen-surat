import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gen_surat/core/constants/app_constants.dart';
import 'package:gen_surat/core/constants/type_surat_constants.dart';
import 'package:gen_surat/core/constants/api_constants.dart';
import 'package:gen_surat/core/exception/validation_exception.dart';
import 'package:gen_surat/data/mappers/ipnu/berita_acara_rapat_formatur_ipnu_mapper.dart';
import 'package:gen_surat/domain/entities/ipnu/berita_acara_rapat_formatur_ipnu_entity.dart';
import 'package:gen_surat/domain/repositories/i_surat_repository.dart';

class GenerateBeritaAcaraRapatFormaturIpnuUseCase {
  final ISuratRepository repository;

  GenerateBeritaAcaraRapatFormaturIpnuUseCase(this.repository);

  Future<File> execute(
    BeritaAcaraRapatFormaturIpnuEntity entity, {
    String? customSavePath,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    _validateEntity(entity);

    final model = BeritaAcaraRapatFormaturIpnuMapper.toModel(entity);

    return await repository.generateSurat(
      data: model,
      lembaga: AppConstants.lembagaIpnu,
      typeSurat: TypeSuratConstants.beritaAcaraRapatFormatur,
      endpoint: ApiConstants.beritaAcaraRapatFormaturEndpoint,
      toMultipartMap: (data) => data.toMultipartMap(),
      customSavePath: customSavePath,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );
  }

  void _validateEntity(BeritaAcaraRapatFormaturIpnuEntity entity) {
    if (entity.jenisLembaga.isEmpty) {
      throw ValidationException('Jenis lembaga harus diisi');
    }

    if (entity.namaLembaga.isEmpty) {
      throw ValidationException('Nama lembaga harus diisi');
    }

    if (entity.tanggal.isEmpty) {
      throw ValidationException('Tanggal rapat harus diisi');
    }

    if (entity.bulan.isEmpty) {
      throw ValidationException('Bulan rapat harus diisi');
    }

    if (entity.tahun.isEmpty) {
      throw ValidationException('Tahun rapat harus diisi');
    }

    if (entity.tempatRapat.isEmpty) {
      throw ValidationException('Tempat rapat harus diisi');
    }

    if (entity.periodeRapta.isEmpty) {
      throw ValidationException('Periode RAPTA harus diisi');
    }

    if (entity.namaWilayah.isEmpty) {
      throw ValidationException('Nama wilayah harus diisi');
    }

    if (entity.tanggalRapat.isEmpty) {
      throw ValidationException('Tanggal penetapan harus diisi');
    }

    if (entity.timFormatur.isEmpty) {
      throw ValidationException('Tim formatur harus diisi minimal 1 orang');
    }

    // Validasi setiap anggota tim formatur
    for (int i = 0; i < entity.timFormatur.length; i++) {
      final member = entity.timFormatur[i];

      if (member.nama.isEmpty) {
        throw ValidationException('Nama tim formatur #${i + 1} harus diisi');
      }

      if (member.jabatan.isEmpty) {
        throw ValidationException('Jabatan tim formatur #${i + 1} harus diisi');
      }

      if (member.ttdPath == null || member.ttdPath!.isEmpty) {
        throw ValidationException(
          'Tanda tangan tim formatur #${i + 1} (${member.nama}) harus diunggah',
        );
      }
    }
  }
}
