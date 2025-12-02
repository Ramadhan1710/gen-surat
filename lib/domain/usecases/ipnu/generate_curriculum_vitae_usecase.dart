import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/exception/validation_exception.dart';
import '../../../data/mappers/ipnu/curriculum_vitae_mapper.dart';
import '../../entities/ipnu/curriculum_vitae_entity.dart';
import '../../repositories/i_surat_repository.dart';

class GenerateCurriculumVitaeUseCase {
  final ISuratRepository repository;

  GenerateCurriculumVitaeUseCase(this.repository);

  Future<File> execute(
    CurriculumVitaeEntity entity, {
    String? customSavePath,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    _validateEntity(entity);

    final model = CurriculumVitaeMapper.toModel(entity);

    log('GenerateCurriculumVitaeUseCase: Generating CV with data for ${entity.namaLembaga}');

    return await repository.generateSurat(
      data: model,
      lembaga: AppConstants.lembagaIpnu,
      typeSurat: 'curriculum_vitae',
      endpoint: '/ipnu/curriculum-vitae',
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
      throw ValidationException('Tempat tanggal lahir ketua tidak boleh kosong');
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

    if (entity.noOrganizationKetua.trim().isEmpty) {
      throw ValidationException('Status pengalaman organisasi ketua tidak boleh kosong');
    }

    if (entity.organisasiKetua.isEmpty) {
      throw ValidationException('Data pengalaman organisasi ketua tidak boleh kosong');
    }

    if (entity.pendidikanKetua.isEmpty) {
      throw ValidationException('Data pendidikan ketua tidak boleh kosong');
    }

    if (entity.fotoKetuaPath == null || entity.fotoKetuaPath!.trim().isEmpty) {
      throw ValidationException('Foto ketua tidak boleh kosong');
    }

    // ========== Validasi Data Sekretaris ==========
    if (entity.namaSekretaris.trim().isEmpty) {
      throw ValidationException('Nama sekretaris tidak boleh kosong');
    }

    if (entity.ttlSekretaris.trim().isEmpty) {
      throw ValidationException('Tempat tanggal lahir sekretaris tidak boleh kosong');
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

    if (entity.noOrganizationSekretaris.trim().isEmpty) {
      throw ValidationException('Status pengalaman organisasi sekretaris tidak boleh kosong');
    }

    if (entity.organisasiSekretaris.isEmpty) {
      throw ValidationException('Data pengalaman organisasi sekretaris tidak boleh kosong');
    }

    if (entity.pendidikanSekretaris.isEmpty) {
      throw ValidationException('Data pendidikan sekretaris tidak boleh kosong');
    }

    if (entity.fotoSekretarisPath == null || entity.fotoSekretarisPath!.trim().isEmpty) {
      throw ValidationException('Foto sekretaris tidak boleh kosong');
    }

    // ========== Validasi Data Bendahara ==========
    if (entity.namaBendahara.trim().isEmpty) {
      throw ValidationException('Nama bendahara tidak boleh kosong');
    }

    if (entity.ttlBendahara.trim().isEmpty) {
      throw ValidationException('Tempat tanggal lahir bendahara tidak boleh kosong');
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

    if (entity.noOrganizationBendahara.trim().isEmpty) {
      throw ValidationException('Status pengalaman organisasi bendahara tidak boleh kosong');
    }

    if (entity.organisasiBendahara.isEmpty) {
      throw ValidationException('Data pengalaman organisasi bendahara tidak boleh kosong');
    }

    if (entity.pendidikanBendahara.isEmpty) {
      throw ValidationException('Data pendidikan bendahara tidak boleh kosong');
    }

    if (entity.fotoBendaharaPath == null || entity.fotoBendaharaPath!.trim().isEmpty) {
      throw ValidationException('Foto bendahara tidak boleh kosong');
    }
  }
}
