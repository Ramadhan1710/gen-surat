import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gen_surat/core/constants/api_constants.dart';
import 'package:gen_surat/core/constants/app_constants.dart';
import 'package:gen_surat/core/constants/type_surat_constants.dart';
import 'package:gen_surat/core/exception/validation_exception.dart';
import 'package:gen_surat/data/mappers/ippnu/berita_acara_penyusunan_pengurus_ippnu_mapper.dart';
import 'package:gen_surat/domain/entities/ippnu/berita_acara_penyusunan_pengurus_ippnu_entity.dart';
import 'package:gen_surat/domain/repositories/i_surat_repository.dart';

class GenerateBeritaAcaraPenyusunanPengurusIppnuUseCase {
  final ISuratRepository repository;

  GenerateBeritaAcaraPenyusunanPengurusIppnuUseCase(
    this.repository,
  );

  Future<File> execute(
    BeritaAcaraPenyusunanPengurusIppnuEntity entity, {
    String? customSavePath,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    _validateEntity(entity);

    final model = BeritaAcaraPenyusunanPengurusIppnuMapper.toModel(
      entity,
    );

    return await repository.generateSurat(
      data: model,
      lembaga: AppConstants.lembagaIppnu,
      typeSurat: TypeSuratConstants.beritaAcaraPenyusunanPengurus,
      endpoint: ApiConstants.beritaAcaraPenyusunanPengurusIppnuEndpoint,
      toMultipartMap: (data) => data.toMultipartMap(),
      customSavePath: customSavePath,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );
  }

  void _validateEntity(
    BeritaAcaraPenyusunanPengurusIppnuEntity entity,
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

    if (entity.tanggalPenyusunan.trim().isEmpty) {
      throw ValidationException('Tanggal penyusunan tidak boleh kosong');
    }

    if (entity.tempatPenyusunan.trim().isEmpty) {
      throw ValidationException('Tempat penyusunan tidak boleh kosong');
    }

    if (entity.namaWilayah.trim().isEmpty) {
      throw ValidationException('Nama wilayah tidak boleh kosong');
    }

    if (entity.hariPenyusunan.trim().isEmpty) {
      throw ValidationException('Hari penyusunan tidak boleh kosong');
    }

    if (entity.tanggalHijriah.trim().isEmpty) {
      throw ValidationException('Tanggal hijriah tidak boleh kosong');
    }

    if (entity.tanggalMasehi.trim().isEmpty) {
      throw ValidationException('Tanggal masehi tidak boleh kosong');
    }

    if (entity.pengurusHarian.isEmpty) {
      throw ValidationException('Data pengurus harian tidak boleh kosong');
    }

    for (var pengurus in entity.pengurusHarian) {
      if (pengurus.jabatan.trim().isEmpty) {
        throw ValidationException('Jabatan pengurus harian tidak boleh kosong');
      }
      if (pengurus.nama.trim().isEmpty) {
        throw ValidationException('Nama pengurus harian tidak boleh kosong');
      }
      // TTD is optional
      if (pengurus.ttdPath != null && pengurus.ttdPath!.trim().isNotEmpty) {
        final ttdFile = File(pengurus.ttdPath!);
        if (!ttdFile.existsSync()) {
          throw ValidationException(
            'File tanda tangan pengurus harian tidak ditemukan',
          );
        }
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
    if (entity.wakilSekre != null && entity.wakilSekre!.isNotEmpty) {
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

    if (entity.departemen.isEmpty) {
      throw ValidationException('Data departemen tidak boleh kosong');
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
          'Anggota departemen "${dept.namaDepartemen}" tidak boleh kosong',
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
      throw ValidationException('Data lembaga tidak boleh kosong');
    }

    for (var lembaga in entity.lembaga) {
      if (lembaga.nama.trim().isEmpty) {
        throw ValidationException('Nama lembaga tidak boleh kosong');
      }
      if (lembaga.direktur.trim().isEmpty) {
        throw ValidationException('Direktur lembaga tidak boleh kosong');
      }
      if (lembaga.sekretaris.trim().isEmpty) {
        throw ValidationException('Sekretaris lembaga tidak boleh kosong');
      }
      if (lembaga.anggota.isEmpty) {
        throw ValidationException(
          'Anggota lembaga "${lembaga.nama}" tidak boleh kosong',
        );
      }
      for (var anggota in lembaga.anggota) {
        if (anggota.nama.trim().isEmpty) {
          throw ValidationException(
            'Nama anggota lembaga tidak boleh kosong',
          );
        }
      }
    }
  }
}
