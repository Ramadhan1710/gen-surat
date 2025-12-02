import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gen_surat/core/constants/app_constants.dart';
import 'package:gen_surat/core/exception/validation_exception.dart';
import 'package:gen_surat/data/mappers/ipnu/kartu_identitas_mapper.dart';
import 'package:gen_surat/domain/entities/ipnu/kartu_identitas_entity.dart';
import 'package:gen_surat/domain/repositories/i_surat_repository.dart';

class GenerateKartuIdentitasUseCase {
  final ISuratRepository _repository;
  final KartuIdentitasMapper _mapper;

  GenerateKartuIdentitasUseCase(this._repository, this._mapper);

  Future<File> execute(
    KartuIdentitasEntity entity, {
    String? customSavePath,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    // Validasi input
    _validateInput(entity);

    // Convert entity to model
    final model = _mapper.toModel(entity);

    log(
      'GenerateKartuIdentitasUseCase: Generating Kartu Identitas for ${entity.namaLembaga}',
    );

    // Generate surat
    return await _repository.generateSurat(
      data: model,
      lembaga: AppConstants.lembagaIpnu,
      typeSurat: 'kartu_identitas',
      endpoint: '/ipnu/kartu-identitas',
      toMultipartMap: (data) => data.toMultipartMap(),
      customSavePath: customSavePath,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );
  }

  void _validateInput(KartuIdentitasEntity entity) {
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
