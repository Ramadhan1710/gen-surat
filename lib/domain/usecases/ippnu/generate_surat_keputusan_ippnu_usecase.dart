import 'dart:io';
import 'package:dio/dio.dart';
import 'package:gen_surat/core/constants/app_constants.dart';
import 'package:gen_surat/core/constants/type_surat_constants.dart';
import 'package:gen_surat/core/exception/validation_exception.dart';
import '../../../core/constants/api_constants.dart';
import '../../../data/mappers/ippnu/surat_keputusan_ippnu_mapper.dart';
import '../../entities/ippnu/surat_keputusan_ippnu_entity.dart';
import '../../repositories/i_surat_repository.dart';

class GenerateSuratKeputusanIppnuUseCase {
  final ISuratRepository repository;

  GenerateSuratKeputusanIppnuUseCase(this.repository);

  Future<File> execute(
    SuratKeputusanIppnuEntity entity, {
    String? customSavePath,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    _validateEntity(entity);

    final model = SuratKeputusanIppnuMapper.toModel(entity);

    return await repository.generateSurat(
      data: model,
      lembaga: AppConstants.lembagaIppnu,
      typeSurat: TypeSuratConstants.suratKeputusan,
      endpoint: ApiConstants.suratKeputusanIppnuEndpoint,
      toMultipartMap: (data) => data.toMultipartMap(),
      customSavePath: customSavePath,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );
  }

  void _validateEntity(SuratKeputusanIppnuEntity entity) {
    if (entity.jenisLembaga.trim().isEmpty) {
      throw ValidationException('Jenis lembaga tidak boleh kosong');
    }
    if (entity.namaLembaga.trim().isEmpty) {
      throw ValidationException('Nama lembaga tidak boleh kosong');
    }
    if (entity.nomorSurat.trim().isEmpty) {
      throw ValidationException('Nomor surat tidak boleh kosong');
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

    if (entity.tanggalHijriah.trim().isEmpty) {
      throw ValidationException('Tanggal Hijriah tidak boleh kosong');
    }

    if (entity.tanggalMasehi.trim().isEmpty) {
      throw ValidationException('Tanggal Masehi tidak boleh kosong');
    }

    if (entity.waktuPenetapan.trim().isEmpty) {
      throw ValidationException('Waktu penetapan tidak boleh kosong');
    }

    if (entity.namaKetua.trim().isEmpty) {
      throw ValidationException('Nama ketua sidang tidak boleh kosong');
    }

    if (entity.namaSekretaris.trim().isEmpty) {
      throw ValidationException('Nama sekretaris sidang tidak boleh kosong');
    }

    if (entity.namaAnggota.trim().isEmpty) {
      throw ValidationException('Nama anggota sidang tidak boleh kosong');
    }

    if (entity.timFormatur.isEmpty) {
      throw ValidationException('Tim formatur harus diisi minimal satu anggota');
    }

    for (var item in entity.timFormatur) {
      if (item.nama.trim().isEmpty) {
        throw ValidationException('Nama anggota tim formatur tidak boleh kosong');
      }
      if (item.daerahPengkaderan.trim().isEmpty) {
        throw ValidationException(
          'Daerah pengkaderan anggota tim formatur tidak boleh kosong',
        );
      }
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
  }
}
