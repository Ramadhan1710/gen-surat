import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/constants/type_surat_constants.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/exception/validation_exception.dart';
import '../../../data/mappers/ipnu/susunan_pengurus_ipnu_mapper.dart';
import '../../entities/ipnu/susunan_pengurus_ipnu_entity.dart';
import '../../repositories/i_surat_repository.dart';

class GenerateSusunanPengurusIpnuUseCase {
  final ISuratRepository repository;

  GenerateSusunanPengurusIpnuUseCase(this.repository);

  Future<File> execute(
    SusunanPengurusIpnuEntity entity, {
    String? customSavePath,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    _validateEntity(entity);

    final model = SusunanPengurusIpnuMapper.toModel(entity);

    return await repository.generateSurat(
      data: model,
      lembaga: AppConstants.lembagaIpnu,
      typeSurat: TypeSuratConstants.susunanPengurus,
      endpoint: ApiConstants.susunanPengurusIpnuEndpoint,
      toMultipartMap: (data) => data.toMultipartMap(),
      customSavePath: customSavePath,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );
  }

  void _validateEntity(SusunanPengurusIpnuEntity entity) {
    // Validasi informasi lembaga
    if (entity.jenisLembaga.trim().isEmpty) {
      throw ValidationException('Jenis lembaga tidak boleh kosong');
    }

    if (entity.namaLembaga.trim().isEmpty) {
      throw ValidationException('Nama lembaga tidak boleh kosong');
    }

    if (entity.alamatLembaga.trim().isEmpty) {
      throw ValidationException('Alamat lembaga tidak boleh kosong');
    }

    if (entity.nomorTeleponLembaga.trim().isEmpty) {
      throw ValidationException('Nomor telepon lembaga tidak boleh kosong');
    }

    if (entity.emailLembaga.trim().isEmpty) {
      throw ValidationException('Email lembaga tidak boleh kosong');
    }

    if (entity.periodeKepengurusan.trim().isEmpty) {
      throw ValidationException('Periode kepengurusan tidak boleh kosong');
    }

    // Validasi pembina
    if (entity.pembina.isEmpty) {
      throw ValidationException('Data pembina tidak boleh kosong');
    }

    // Validasi ketua
    if (entity.namaKetua.trim().isEmpty) {
      throw ValidationException('Nama ketua tidak boleh kosong');
    }

    if (entity.alamatKetua.trim().isEmpty) {
      throw ValidationException('Alamat ketua tidak boleh kosong');
    }

    // Validasi wakil ketua
    if (entity.wakilKetua.isEmpty) {
      throw ValidationException('Data wakil ketua tidak boleh kosong');
    }

    // Validasi sekretaris
    if (entity.namaSekretaris.trim().isEmpty) {
      throw ValidationException('Nama sekretaris tidak boleh kosong');
    }

    if (entity.alamatSekretaris.trim().isEmpty) {
      throw ValidationException('Alamat sekretaris tidak boleh kosong');
    }

    // Wakil sekretaris is optional, no validation needed

    // Validasi bendahara
    if (entity.namaBendahara.trim().isEmpty) {
      throw ValidationException('Nama bendahara tidak boleh kosong');
    }

    if (entity.alamatBendahara.trim().isEmpty) {
      throw ValidationException('Alamat bendahara tidak boleh kosong');
    }

    // Wakil bendahara is optional, no validation needed

    // Validasi departemen
    if (entity.departemen.isEmpty) {
      throw ValidationException('Data departemen tidak boleh kosong');
    }

    // Validasi lembaga
    if (entity.lembaga.isEmpty) {
      throw ValidationException('Data lembaga tidak boleh kosong');
    }

    // Validasi conditional: jika hasLembagaCBP true, komandan & wakil komandan wajib
    if (entity.hasLembagaCBP == true) {
      if (entity.komandan == null || entity.komandan!.trim().isEmpty) {
        throw ValidationException(
          'Komandan wajib diisi jika memiliki lembaga CBP',
        );
      }

      if (entity.alamatKomandan == null ||
          entity.alamatKomandan!.trim().isEmpty) {
        throw ValidationException(
          'Alamat komandan wajib diisi jika memiliki lembaga CBP',
        );
      }

      if (entity.wakilKomandan == null ||
          entity.wakilKomandan!.trim().isEmpty) {
        throw ValidationException(
          'Wakil komandan wajib diisi jika memiliki lembaga CBP',
        );
      }

      if (entity.alamatWakilKomandan == null ||
          entity.alamatWakilKomandan!.trim().isEmpty) {
        throw ValidationException(
          'Alamat wakil komandan wajib diisi jika memiliki lembaga CBP',
        );
      }

      // Jika hasDivisi true, divisi wajib ada
      if (entity.hasDivisi == true) {
        if (entity.divisi == null || entity.divisi!.isEmpty) {
          throw ValidationException(
            'Data divisi wajib diisi jika memiliki divisi',
          );
        }
      }
    }
  }
}
