import 'dart:io';

import 'package:dio/dio.dart';

import '../../core/constants/type_surat_constants.dart';
import '../../core/exception/validation_exception.dart';
import '../../data/mappers/berita_acara_pemilihan_ketua_mapper.dart';
import '../entities/berita_acara_pemilihan_ketua_entity.dart';
import '../repositories/i_surat_repository.dart';

class GenerateBeritaAcaraPemilihanKetuaUseCase {
  final ISuratRepository repository;

  GenerateBeritaAcaraPemilihanKetuaUseCase(this.repository);

  Future<File> execute(
    BeritaAcaraPemilihanKetuaEntity entity, {
    String? customSavePath,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    String? lembaga,
    String? endpoint
  }) async {
    _validateEntity(entity);

    final model = BeritaAcaraPemilihanKetuaMapper.toModel(entity);

    if (lembaga == null) {
      throw ValidationException('Lembaga tidak boleh null');
    }

    if (endpoint == null) {
      throw ValidationException('Endpoint tidak boleh null');
    }

    return await repository.generateSurat(
      data: model,
      lembaga: lembaga,
      typeSurat: TypeSuratConstants.beritaAcaraPemilihanKetua,
      endpoint: endpoint,
      toMultipartMap: (data) => data.toMultipartMap(),
      customSavePath: customSavePath,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );
  }

  void _validateEntity(BeritaAcaraPemilihanKetuaEntity entity) {
    if (entity.jenisLembaga.trim().isEmpty) {
      throw ValidationException('Tingkatan organisasi tidak boleh kosong');
    }

    if (entity.namaLembaga.trim().isEmpty) {
      throw ValidationException('Nama desa/sekolah tidak boleh kosong');
    }

    if (entity.periodeKepengurusan.trim().isEmpty) {
      throw ValidationException('Periode kepengurusan tidak boleh kosong');
    }

    if (entity.tanggal.trim().isEmpty) {
      throw ValidationException('Tanggal tidak boleh kosong');
    }

    if (entity.bulan.trim().isEmpty) {
      throw ValidationException('Bulan tidak boleh kosong');
    }

    if (entity.tahun.trim().isEmpty) {
      throw ValidationException('Tahun tidak boleh kosong');
    }

    if (entity.waktuPemilihanKetua.trim().isEmpty) {
      throw ValidationException('Waktu pemilihan ketua tidak boleh kosong');
    }

    if (entity.tempatPemilihanKetua.trim().isEmpty) {
      throw ValidationException('Tempat pemilihan ketua tidak boleh kosong');
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

    if (entity.waktuPenetapan.trim().isEmpty) {
      throw ValidationException('Waktu penetapan tidak boleh kosong');
    }

    if (entity.namaKetua.trim().isEmpty) {
      throw ValidationException('Nama ketua tidak boleh kosong');
    }

    if (entity.namaSekretaris.trim().isEmpty) {
      throw ValidationException('Nama sekretaris tidak boleh kosong');
    }

    if (entity.namaAnggota.trim().isEmpty) {
      throw ValidationException('Nama anggota tidak boleh kosong');
    }

    if (entity.namaKetuaTerpilih.trim().isEmpty) {
      throw ValidationException('Nama ketua terpilih tidak boleh kosong');
    }

    if (entity.alamatKetuaTerpilih.trim().isEmpty) {
      throw ValidationException('Alamat ketua terpilih tidak boleh kosong');
    }

    if (entity.pencalonanKetua.isEmpty) {
      throw ValidationException('Data pencalonan ketua tidak boleh kosong');
    }

    if (entity.pemilihanKetua.isEmpty) {
      throw ValidationException('Data pemilihan ketua tidak boleh kosong');
    }

    if (entity.formatur.isEmpty) {
      throw ValidationException('Data formatur tidak boleh kosong');
    }

    if (entity.ttdKetuaPath.trim().isEmpty) {
      throw ValidationException('Path tanda tangan ketua tidak boleh kosong');
    }

    if (entity.ttdSekretarisPath.trim().isEmpty) {
      throw ValidationException(
        'Path tanda tangan sekretaris tidak boleh kosong',
      );
    }

    if (entity.ttdAnggotaPath.trim().isEmpty) {
      throw ValidationException('Path tanda tangan anggota tidak boleh kosong');
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
