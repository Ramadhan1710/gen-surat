import 'dart:io';
import 'package:dio/dio.dart';
import 'package:gen_surat/core/constants/app_constants.dart';
import 'package:gen_surat/core/constants/type_surat_constants.dart';
import 'package:gen_surat/core/exception/validation_exception.dart';
import '../../../core/constants/api_constants.dart';
import '../../../data/mappers/ippnu/susunan_pengurus_ippnu_mapper.dart';
import '../../entities/ippnu/susunan_pengurus_ippnu_entity.dart';
import '../../repositories/i_surat_repository.dart';

class GenerateSusunanPengurusIppnuUseCase {
  final ISuratRepository repository;

  GenerateSusunanPengurusIppnuUseCase(this.repository);

  Future<File> execute(
    SusunanPengurusIppnuEntity entity, {
    String? customSavePath,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    _validateEntity(entity);

    final model = SusunanPengurusIppnuMapper.toModel(entity);

    return await repository.generateSurat(
      data: model,
      lembaga: AppConstants.lembagaIppnu,
      typeSurat: TypeSuratConstants.susunanPengurus,
      endpoint: ApiConstants.susunanPengurusIppnuEndpoint,
      toMultipartMap: (data) => data.toMultipartMap(),
      customSavePath: customSavePath,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );
  }

  void _validateEntity(SusunanPengurusIppnuEntity entity) {
    if (entity.jenisLembaga.trim().isEmpty) {
      throw ValidationException('Jenis lembaga tidak boleh kosong');
    }
    if (entity.namaLembaga.trim().isEmpty) {
      throw ValidationException('Nama lembaga tidak boleh kosong');
    }
    if (entity.periodeKepengurusan.trim().isEmpty) {
      throw ValidationException('Periode kepengurusan tidak boleh kosong');
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
    if (entity.namaKetua.trim().isEmpty) {
      throw ValidationException('Nama ketua tidak boleh kosong');
    }
    if (entity.wakilKetua.isEmpty) {
      throw ValidationException('Wakil ketua harus diisi minimal satu');
    }
    for (var item in entity.wakilKetua) {
      if (item.title.trim().isEmpty) {
        throw ValidationException('Jabatan wakil ketua tidak boleh kosong');
      }
      if (item.nama.trim().isEmpty) {
        throw ValidationException('Nama wakil ketua tidak boleh kosong');
      }
    }
    if (entity.namaSekretaris.trim().isEmpty) {
      throw ValidationException('Nama sekretaris tidak boleh kosong');
    }
    for (var item in entity.wakilSekre) {
      if (item.title.trim().isEmpty) {
        throw ValidationException(
          'Jabatan wakil sekretaris tidak boleh kosong',
        );
      }
      if (item.nama.trim().isEmpty) {
        throw ValidationException('Nama wakil sekretaris tidak boleh kosong');
      }
    }
    if (entity.namaBendahara.trim().isEmpty) {
      throw ValidationException('Nama bendahara tidak boleh kosong');
    }
    if (entity.departemen.isEmpty) {
      throw ValidationException('Departemen harus diisi minimal satu');
    }
    for (var dept in entity.departemen) {
      if (dept.namaDepartemen.trim().isEmpty) {
        throw ValidationException('Nama departemen tidak boleh kosong');
      }
      if (dept.koordinator.trim().isEmpty) {
        throw ValidationException('Koordinator departemen tidak boleh kosong');
      }
      if (dept.anggota.isEmpty) {
        throw ValidationException(
          'Anggota departemen harus diisi minimal satu',
        );
      }
      for (var anggota in dept.anggota) {
        if (anggota.nama.trim().isEmpty) {
          throw ValidationException(
            'Nama anggota departemen tidak boleh kosong',
          );
        }
      }
    }
    if (entity.lembaga.isEmpty) {
      throw ValidationException('Lembaga harus diisi minimal satu');
    }
    for (var lmb in entity.lembaga) {
      if (lmb.nama.trim().isEmpty) {
        throw ValidationException('Nama lembaga tidak boleh kosong');
      }
      if (lmb.direktur.trim().isEmpty) {
        throw ValidationException('Direktur lembaga tidak boleh kosong');
      }
      if (lmb.sekretaris.trim().isEmpty) {
        throw ValidationException('Sekretaris lembaga tidak boleh kosong');
      }
      if (lmb.anggota.isEmpty) {
        throw ValidationException('Anggota lembaga harus diisi minimal satu');
      }
      for (var anggota in lmb.anggota) {
        if (anggota.nama.trim().isEmpty) {
          throw ValidationException('Nama anggota lembaga tidak boleh kosong');
        }
      }
    }
    if (entity.pelindung.isEmpty) {
      throw ValidationException('Pelindung harus diisi minimal satu');
    }
    for (var item in entity.pelindung) {
      if (item.nama.trim().isEmpty) {
        throw ValidationException('Nama pelindung tidak boleh kosong');
      }
    }
    if (entity.pembina.isEmpty) {
      throw ValidationException('Pembina harus diisi minimal satu');
    }
    for (var item in entity.pembina) {
      if (item.nama.trim().isEmpty) {
        throw ValidationException('Nama pembina tidak boleh kosong');
      }
    }
  }
}
