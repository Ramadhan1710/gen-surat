import 'dart:io';

import 'package:gen_surat/data/models/ippnu/berita_acara_penyusunan_pengurus_ippnu_model.dart';
import 'package:gen_surat/domain/entities/ippnu/berita_acara_penyusunan_pengurus_ippnu_entity.dart';

class BeritaAcaraPenyusunanPengurusIppnuMapper {
  static BeritaAcaraPenyusunanPengurusIppnuEntity toEntity(
    BeritaAcaraPenyusunanPengurusIppnuModel model,
  ) {
    return BeritaAcaraPenyusunanPengurusIppnuEntity(
      jenisLembaga: model.jenisLembaga,
      namaLembaga: model.namaLembaga,
      periodeKepengurusan: model.periodeKepengurusan,
      tanggalPenyusunan: model.tanggalPenyusunan,
      tempatPenyusunan: model.tempatPenyusunan,
      namaWilayah: model.namaWilayah,
      hariPenyusunan: model.hariPenyusunan,
      tanggalHijriah: model.tanggalHijriah,
      tanggalMasehi: model.tanggalMasehi,
      pengurusHarian:
          model.pengurusHarian
              .map(
                (p) => PengurusHarianEntity(
                  jabatan: p.jabatan,
                  nama: p.nama,
                  ttdPath: p.ttd?.path,
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
      departemen:
          model.departemen
              .map(
                (d) => DepartemenEntity(
                  namaDepartemen: d.namaDepartemen,
                  koordinator: d.koordinator,
                  anggota:
                      d.anggota
                          .map(
                            (a) => AnggotaDepartemenEntity(
                              nama: a.nama,
                            ),
                          )
                          .toList(),
                ),
              )
              .toList(),
      lembaga:
          model.lembaga
              .map(
                (l) => LembagaEntity(
                  nama: l.nama,
                  direktur: l.direktur,
                  sekretaris: l.sekretaris,
                  anggota:
                      l.anggota
                          .map(
                            (a) => AnggotaLembagaEntity(
                              nama: a.nama,
                            ),
                          )
                          .toList(),
                ),
              )
              .toList(),
    );
  }

  static BeritaAcaraPenyusunanPengurusIppnuModel toModel(
    BeritaAcaraPenyusunanPengurusIppnuEntity entity,
  ) {
    return BeritaAcaraPenyusunanPengurusIppnuModel(
      jenisLembaga: entity.jenisLembaga,
      namaLembaga: entity.namaLembaga,
      periodeKepengurusan: entity.periodeKepengurusan,
      tanggalPenyusunan: entity.tanggalPenyusunan,
      tempatPenyusunan: entity.tempatPenyusunan,
      namaWilayah: entity.namaWilayah,
      hariPenyusunan: entity.hariPenyusunan,
      tanggalHijriah: entity.tanggalHijriah,
      tanggalMasehi: entity.tanggalMasehi,
      pengurusHarian:
          entity.pengurusHarian
              .map(
                (p) => PengurusHarianModel(
                  jabatan: p.jabatan,
                  nama: p.nama,
                  ttd: p.ttdPath != null ? File(p.ttdPath!) : null,
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
      departemen:
          entity.departemen
              .map(
                (d) => DepartemenModel(
                  namaDepartemen: d.namaDepartemen,
                  koordinator: d.koordinator,
                  anggota:
                      d.anggota
                          .map(
                            (a) => AnggotaDepartemenModel(
                              nama: a.nama,
                            ),
                          )
                          .toList(),
                ),
              )
              .toList(),
      lembaga:
          entity.lembaga
              .map(
                (l) => LembagaModel(
                  nama: l.nama,
                  direktur: l.direktur,
                  sekretaris: l.sekretaris,
                  anggota:
                      l.anggota
                          .map(
                            (a) => AnggotaLembagaModel(
                              nama: a.nama,
                            ),
                          )
                          .toList(),
                ),
              )
              .toList(),
    );
  }
}
