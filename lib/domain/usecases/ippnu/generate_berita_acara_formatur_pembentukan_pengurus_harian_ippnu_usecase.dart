import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gen_surat/core/constants/api_constants.dart';
import 'package:gen_surat/core/constants/app_constants.dart';
import 'package:gen_surat/core/constants/type_surat_constants.dart';
import 'package:gen_surat/core/exception/validation_exception.dart';
import 'package:gen_surat/data/mappers/ippnu/berita_acara_formatur_pembentukan_pengurus_harian_ippnu_mapper.dart';
import 'package:gen_surat/domain/entities/ippnu/berita_acara_formatur_pembentukan_pengurus_harian_ippnu_entity.dart';
import 'package:gen_surat/domain/repositories/i_surat_repository.dart';

class GenerateBeritaAcaraFormaturPembentukanPengurusHarianIppnuUseCase {
  final ISuratRepository repository;

  GenerateBeritaAcaraFormaturPembentukanPengurusHarianIppnuUseCase(
    this.repository,
  );

  Future<File> execute(
    BeritaAcaraFormaturPembentukanPengurusHarianIppnuEntity entity, {
    String? customSavePath,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    _validateEntity(entity);

    final model =
        BeritaAcaraFormaturPembentukanPengurusHarianIppnuMapper.toModel(
      entity,
    );

    return await repository.generateSurat(
      data: model,
      lembaga: AppConstants.lembagaIppnu,
      typeSurat:
          TypeSuratConstants.beritaAcaraFormaturPembentukanPengurusHarian,
      endpoint: ApiConstants
          .beritaAcaraFormaturPembentukanPengurusHarianIppnuEndpoint,
      toMultipartMap: (data) => data.toMultipartMap(),
      customSavePath: customSavePath,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );
  }

  void _validateEntity(
    BeritaAcaraFormaturPembentukanPengurusHarianIppnuEntity entity,
  ) {
    if (entity.jenisLembaga.trim().isEmpty) {
      throw ValidationException('Jenis lembaga tidak boleh kosong');
    }

    if (entity.namaLembaga.trim().isEmpty) {
      throw ValidationException('Nama lembaga tidak boleh kosong');
    }

    if (entity.periodeKepengurusan.trim().isEmpty) {
      throw ValidationException('Periode kepengurusan tidak boleh kosong');
    }

    if (entity.tingkatLembaga.trim().isEmpty) {
      throw ValidationException('Tingkat lembaga tidak boleh kosong');
    }

    if (entity.tanggalPenyusunan.trim().isEmpty) {
      throw ValidationException('Tanggal penyusunan tidak boleh kosong');
    }

    if (entity.tempatPenyusunan.trim().isEmpty) {
      throw ValidationException('Tempat penyusunan tidak boleh kosong');
    }

    if (entity.namaWilayah.trim().isEmpty) {
      throw ValidationException('Nama wilayah tidak boleh kosong');
    }

    if (entity.tanggalHijriah.trim().isEmpty) {
      throw ValidationException('Tanggal hijriah tidak boleh kosong');
    }

    if (entity.tanggalMasehi.trim().isEmpty) {
      throw ValidationException('Tanggal masehi tidak boleh kosong');
    }

    if (entity.formatur.isEmpty) {
      throw ValidationException('Data formatur tidak boleh kosong');
    }

    for (var formatur in entity.formatur) {
      if (formatur.nama.trim().isEmpty) {
        throw ValidationException('Nama formatur tidak boleh kosong');
      }
      if (formatur.jabatan.trim().isEmpty) {
        throw ValidationException('Jabatan formatur tidak boleh kosong');
      }
      if (formatur.ttdPath.trim().isEmpty) {
        throw ValidationException(
          'Tanda tangan formatur tidak boleh kosong',
        );
      }
      final ttdFile = File(formatur.ttdPath);
      if (!ttdFile.existsSync()) {
        throw ValidationException(
          'File tanda tangan formatur tidak ditemukan',
        );
      }
    }

    if (entity.pelindung.isEmpty) {
      throw ValidationException('Data pelindung tidak boleh kosong');
    }

    for (var pelindung in entity.pelindung) {
      if (pelindung.nama.trim().isEmpty) {
        throw ValidationException('Nama pelindung tidak boleh kosong');
      }
    }

    if (entity.pembina.isEmpty) {
      throw ValidationException('Data pembina tidak boleh kosong');
    }

    for (var pembina in entity.pembina) {
      if (pembina.nama.trim().isEmpty) {
        throw ValidationException('Nama pembina tidak boleh kosong');
      }
    }

    if (entity.namaKetua.trim().isEmpty) {
      throw ValidationException('Nama ketua tidak boleh kosong');
    }

    if (entity.wakilKetua.isEmpty) {
      throw ValidationException('Data wakil ketua tidak boleh kosong');
    }

    for (var wakil in entity.wakilKetua) {
      if (wakil.title.trim().isEmpty) {
        throw ValidationException('Jabatan wakil ketua tidak boleh kosong');
      }
      if (wakil.nama.trim().isEmpty) {
        throw ValidationException('Nama wakil ketua tidak boleh kosong');
      }
    }

    if (entity.namaSekretaris.trim().isEmpty) {
      throw ValidationException('Nama sekretaris tidak boleh kosong');
    }

    // wakil sekre optional, tapi jika ada harus valid
    if (entity.wakilSekre != null) {
      for (var wakil in entity.wakilSekre!) {
        if (wakil.title.trim().isEmpty) {
          throw ValidationException(
            'Jabatan wakil sekretaris tidak boleh kosong',
          );
        }
        if (wakil.nama.trim().isEmpty) {
          throw ValidationException('Nama wakil sekretaris tidak boleh kosong');
        }
      }
    }

    if (entity.namaBendahara.trim().isEmpty) {
      throw ValidationException('Nama bendahara tidak boleh kosong');
    }

    // wakil bendahara optional
  }
}
