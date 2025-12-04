import 'dart:io';

import 'package:gen_surat/data/models/ippnu/berita_acara_formatur_pembentukan_pengurus_harian_ippnu_model.dart';
import 'package:gen_surat/domain/entities/ippnu/berita_acara_formatur_pembentukan_pengurus_harian_ippnu_entity.dart';

class BeritaAcaraFormaturPembentukanPengurusHarianIppnuMapper {
  static BeritaAcaraFormaturPembentukanPengurusHarianIppnuEntity toEntity(
    BeritaAcaraFormaturPembentukanPengurusHarianIppnuModel model,
  ) {
    return BeritaAcaraFormaturPembentukanPengurusHarianIppnuEntity(
      jenisLembaga: model.jenisLembaga,
      namaLembaga: model.namaLembaga,
      periodeKepengurusan: model.periodeKepengurusan,
      tingkatLembaga: model.tingkatLembaga,
      tanggalPenyusunan: model.tanggalPenyusunan,
      tempatPenyusunan: model.tempatPenyusunan,
      namaWilayah: model.namaWilayah,
      tanggalHijriah: model.tanggalHijriah,
      tanggalMasehi: model.tanggalMasehi,
      formatur:
          model.formatur
              .map(
                (f) => FormaturEntity(
                  no: f.no,
                  nama: f.nama,
                  jabatan: f.jabatan,
                  ttdPath: f.ttd.path,
                ),
              )
              .toList(),
      pelindung:
          model.pelindung
              .map(
                (p) => PelindungEntity(
                  nama: p.nama,
                ),
              )
              .toList(),
      pembina:
          model.pembina
              .map(
                (p) => PembinaEntity(
                  no: p.no,
                  nama: p.nama,
                ),
              )
              .toList(),
      namaKetua: model.namaKetua,
      wakilKetua:
          model.wakilKetua
              .map(
                (w) => WakilKetuaEntity(
                  title: w.title,
                  nama: w.nama,
                ),
              )
              .toList(),
      namaSekretaris: model.namaSekretaris,
      wakilSekre:
          model.wakilSekre
              ?.map(
                (w) => WakilSekretarisEntity(
                  title: w.title,
                  nama: w.nama,
                ),
              )
              .toList(),
      namaBendahara: model.namaBendahara,
      namaWakilBend: model.namaWakilBend,
    );
  }

  static BeritaAcaraFormaturPembentukanPengurusHarianIppnuModel toModel(
    BeritaAcaraFormaturPembentukanPengurusHarianIppnuEntity entity,
  ) {
    return BeritaAcaraFormaturPembentukanPengurusHarianIppnuModel(
      jenisLembaga: entity.jenisLembaga,
      namaLembaga: entity.namaLembaga,
      periodeKepengurusan: entity.periodeKepengurusan,
      tingkatLembaga: entity.tingkatLembaga,
      tanggalPenyusunan: entity.tanggalPenyusunan,
      tempatPenyusunan: entity.tempatPenyusunan,
      namaWilayah: entity.namaWilayah,
      tanggalHijriah: entity.tanggalHijriah,
      tanggalMasehi: entity.tanggalMasehi,
      formatur:
          entity.formatur
              .map(
                (f) => FormaturModel(
                  no: f.no,
                  nama: f.nama,
                  jabatan: f.jabatan,
                  ttd: File(f.ttdPath),
                ),
              )
              .toList(),
      pelindung:
          entity.pelindung
              .map(
                (p) => PelindungModel(
                  nama: p.nama,
                ),
              )
              .toList(),
      pembina:
          entity.pembina
              .map(
                (p) => PembinaModel(
                  no: p.no,
                  nama: p.nama,
                ),
              )
              .toList(),
      namaKetua: entity.namaKetua,
      wakilKetua:
          entity.wakilKetua
              .map(
                (w) => WakilKetuaModel(
                  title: w.title,
                  nama: w.nama,
                ),
              )
              .toList(),
      namaSekretaris: entity.namaSekretaris,
      wakilSekre:
          entity.wakilSekre
              ?.map(
                (w) => WakilSekretarisModel(
                  title: w.title,
                  nama: w.nama,
                ),
              )
              .toList(),
      namaBendahara: entity.namaBendahara,
      namaWakilBend: entity.namaWakilBend,
    );
  }
}
