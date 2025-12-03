import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gen_surat/core/constants/app_constants.dart';
import 'package:gen_surat/core/constants/type_surat_constants.dart';
import 'package:gen_surat/core/constants/api_constants.dart';
import 'package:gen_surat/core/exception/validation_exception.dart';
import 'package:gen_surat/data/mappers/ipnu/sertifikat_kaderisasi_mapper.dart';
import 'package:gen_surat/domain/entities/ipnu/sertifikat_kaderisasi_entity.dart';
import 'package:gen_surat/domain/repositories/i_surat_repository.dart';

class GenerateSertifikatKaderisasiUseCase {
  final ISuratRepository repository;

  GenerateSertifikatKaderisasiUseCase(this.repository);

  Future<File> execute(
    SertifikatKaderisasiEntity entity, {
    String? customSavePath,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    _validateEntity(entity);

    final model = SertifikatKaderisasiMapper.toModel(entity);

    return await repository.generateSurat(
      data: model,
      lembaga: AppConstants.lembagaIpnu,
      typeSurat: TypeSuratConstants.sertifikatKaderisasi,
      endpoint: ApiConstants.sertifikatKaderisasiEndpoint,
      toMultipartMap: (data) => data.toMultipartMap(),
      customSavePath: customSavePath,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );
  }

  void _validateEntity(SertifikatKaderisasiEntity entity) {
    if (entity.jenisLembaga.isEmpty) {
      throw ValidationException('Jenis lembaga harus diisi');
    }

    if (entity.namaLembaga.isEmpty) {
      throw ValidationException('Nama lembaga harus diisi');
    }

    if (entity.periodeKepengurusan.isEmpty) {
      throw ValidationException('Periode kepengurusan harus diisi');
    }

    if (entity.sertifikatKaderisasiKetuaPath == null ||
        entity.sertifikatKaderisasiKetuaPath!.isEmpty) {
      throw ValidationException(
        'Foto sertifikat kaderisasi ketua harus diunggah',
      );
    }

    if (entity.sertifikatKaderisasiSekretarisPath == null ||
        entity.sertifikatKaderisasiSekretarisPath!.isEmpty) {
      throw ValidationException(
        'Foto sertifikat kaderisasi sekretaris harus diunggah',
      );
    }

    if (entity.sertifikatKaderisasiBendaharaPath == null ||
        entity.sertifikatKaderisasiBendaharaPath!.isEmpty) {
      throw ValidationException(
        'Foto sertifikat kaderisasi bendahara harus diunggah',
      );
    }
  }
}
