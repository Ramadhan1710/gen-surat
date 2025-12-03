import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gen_surat/core/constants/app_constants.dart';
import 'package:gen_surat/core/constants/type_surat_constants.dart';
import 'package:gen_surat/core/constants/api_constants.dart';
import 'package:gen_surat/core/exception/validation_exception.dart';
import 'package:gen_surat/data/mappers/ipnu/kartu_identitas_mapper.dart';
import 'package:gen_surat/domain/entities/ipnu/kartu_identitas_entity.dart';
import 'package:gen_surat/domain/repositories/i_surat_repository.dart';

class GenerateKartuIdentitasUseCase {
  final ISuratRepository repository;

  GenerateKartuIdentitasUseCase(this.repository);

  Future<File> execute(
    KartuIdentitasEntity entity, {
    String? customSavePath,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    _validateEntity(entity);

    final model = KartuIdentitasMapper.toModel(entity);

    return await repository.generateSurat(
      data: model,
      lembaga: AppConstants.lembagaIpnu,
      typeSurat: TypeSuratConstants.kartuIdentitas,
      endpoint: ApiConstants.kartuIdentitasEndpoint,
      toMultipartMap: (data) => data.toMultipartMap(),
      customSavePath: customSavePath,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );
  }

  void _validateEntity(KartuIdentitasEntity entity) {
    if (entity.jenisLembaga.isEmpty) {
      throw ValidationException('Jenis lembaga harus diisi');
    }

    if (entity.namaLembaga.isEmpty) {
      throw ValidationException('Nama lembaga harus diisi');
    }

    if (entity.periodeKepengurusan.isEmpty) {
      throw ValidationException('Periode kepengurusan harus diisi');
    }

    if (entity.kartuIdentitasKetuaPath == null ||
        entity.kartuIdentitasKetuaPath!.isEmpty) {
      throw ValidationException('Foto kartu identitas ketua harus diunggah');
    }

    if (entity.kartuIdentitasSekretarisPath == null ||
        entity.kartuIdentitasSekretarisPath!.isEmpty) {
      throw ValidationException(
        'Foto kartu identitas sekretaris harus diunggah',
      );
    }

    if (entity.kartuIdentitasBendaharaPath == null ||
        entity.kartuIdentitasBendaharaPath!.isEmpty) {
      throw ValidationException(
        'Foto kartu identitas bendahara harus diunggah',
      );
    }
  }
}
