import 'dart:io';

import 'package:dio/dio.dart';

import 'package:gen_surat/core/constants/app_constants.dart';
import 'package:gen_surat/core/constants/type_surat_constants.dart';
import 'package:gen_surat/core/constants/api_constants.dart';
import 'package:gen_surat/core/exception/validation_exception.dart';
import 'package:gen_surat/data/mappers/curriculum_vitae_mapper.dart';
import 'package:gen_surat/domain/entities/curriculum_vitae_entity.dart';
import 'package:gen_surat/domain/repositories/i_surat_repository.dart';

class GenerateCurriculumVitaeUseCase {
  final ISuratRepository repository;

  GenerateCurriculumVitaeUseCase(this.repository);

  Future<File> execute(
    CurriculumVitaeEntity entity, {
    String? customSavePath,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    String? endpoint,
    String? lembaga,
  }) async {
    _validateEntity(entity);

    final model = CurriculumVitaeMapper.toModel(entity);

    if (lembaga == null) {
      throw ValidationException('Lembaga tidak boleh null');
    }

    if (endpoint == null) {
      throw ValidationException('Endpoint tidak boleh null');
    }  

    return await repository.generateSurat(
      data: model,
      lembaga: lembaga,
      typeSurat: TypeSuratConstants.curriculumVitae,
      endpoint: endpoint,
      toMultipartMap: (data) => data.toMultipartMap(),
      customSavePath: customSavePath,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );
  }

  void _validateEntity(CurriculumVitaeEntity entity) {
    // Validasi informasi lembaga
    if (entity.jenisLembaga.trim().isEmpty) {
      throw ValidationException('Jenis lembaga tidak boleh kosong');
    }

    if (entity.namaLembaga.trim().isEmpty) {
      throw ValidationException('Nama lembaga tidak boleh kosong');
    }

    if (entity.periodeKepengurusan.trim().isEmpty) {
      throw ValidationException('Periode kepengurusan tidak boleh kosong');
    }

    // ========== Validasi Data Ketua ==========
    if (entity.namaKetua.trim().isEmpty) {
      throw ValidationException('Nama ketua tidak boleh kosong');
    }

    if (entity.ttlKetua.trim().isEmpty) {
      throw ValidationException(
        'Tempat tanggal lahir ketua tidak boleh kosong',
      );
    }

    if (entity.niaKetua.trim().isEmpty) {
      throw ValidationException('NIA ketua tidak boleh kosong');
    }

    if (entity.alamatKetua.trim().isEmpty) {
      throw ValidationException('Alamat ketua tidak boleh kosong');
    }

    if (entity.mottoKetua.trim().isEmpty) {
      throw ValidationException('Motto ketua tidak boleh kosong');
    }

    if (entity.nomorHpKetua.trim().isEmpty) {
      throw ValidationException('Nomor HP ketua tidak boleh kosong');
    }

    if (entity.emailKetua.trim().isEmpty) {
      throw ValidationException('Email ketua tidak boleh kosong');
    }

    if (entity.pendidikanKetua.isEmpty) {
      throw ValidationException('Data pendidikan ketua tidak boleh kosong');
    }

    if (entity.fotoKetuaPath == null || entity.fotoKetuaPath!.trim().isEmpty) {
      throw ValidationException('Foto ketua tidak boleh kosong');
    }

    if (entity.namaSekretaris.trim().isEmpty) {
      throw ValidationException('Nama sekretaris tidak boleh kosong');
    }

    if (entity.ttlSekretaris.trim().isEmpty) {
      throw ValidationException(
        'Tempat tanggal lahir sekretaris tidak boleh kosong',
      );
    }

    if (entity.niaSekretaris.trim().isEmpty) {
      throw ValidationException('NIA sekretaris tidak boleh kosong');
    }

    if (entity.alamatSekretaris.trim().isEmpty) {
      throw ValidationException('Alamat sekretaris tidak boleh kosong');
    }

    if (entity.mottoSekretaris.trim().isEmpty) {
      throw ValidationException('Motto sekretaris tidak boleh kosong');
    }

    if (entity.nomorHpSekretaris.trim().isEmpty) {
      throw ValidationException('Nomor HP sekretaris tidak boleh kosong');
    }

    if (entity.emailSekretaris.trim().isEmpty) {
      throw ValidationException('Email sekretaris tidak boleh kosong');
    }

    if (entity.pendidikanSekretaris.isEmpty) {
      throw ValidationException(
        'Data pendidikan sekretaris tidak boleh kosong',
      );
    }

    if (entity.fotoSekretarisPath == null ||
        entity.fotoSekretarisPath!.trim().isEmpty) {
      throw ValidationException('Foto sekretaris tidak boleh kosong');
    }

    // ========== Validasi Data Bendahara ==========
    if (entity.namaBendahara.trim().isEmpty) {
      throw ValidationException('Nama bendahara tidak boleh kosong');
    }

    if (entity.ttlBendahara.trim().isEmpty) {
      throw ValidationException(
        'Tempat tanggal lahir bendahara tidak boleh kosong',
      );
    }

    if (entity.niaBendahara.trim().isEmpty) {
      throw ValidationException('NIA bendahara tidak boleh kosong');
    }

    if (entity.alamatBendahara.trim().isEmpty) {
      throw ValidationException('Alamat bendahara tidak boleh kosong');
    }

    if (entity.mottoBendahara.trim().isEmpty) {
      throw ValidationException('Motto bendahara tidak boleh kosong');
    }

    if (entity.nomorHpBendahara.trim().isEmpty) {
      throw ValidationException('Nomor HP bendahara tidak boleh kosong');
    }

    if (entity.emailBendahara.trim().isEmpty) {
      throw ValidationException('Email bendahara tidak boleh kosong');
    }

    if (entity.pendidikanBendahara.isEmpty) {
      throw ValidationException('Data pendidikan bendahara tidak boleh kosong');
    }

    if (entity.fotoBendaharaPath == null ||
        entity.fotoBendaharaPath!.trim().isEmpty) {
      throw ValidationException('Foto bendahara tidak boleh kosong');
    }
  }
}
