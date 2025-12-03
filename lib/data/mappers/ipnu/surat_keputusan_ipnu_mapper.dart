import 'dart:io';

import 'package:gen_surat/data/models/ipnu/surat_keputusan_ipnu_model.dart';
import 'package:gen_surat/domain/entities/ipnu/surat_keputusan_ipnu_entity.dart';

class SuratKeputusanIpnuMapper {
  static SuratKeputusanIpnuEntity toEntity(SuratKeputusanIpnuModel model) {
    return SuratKeputusanIpnuEntity(
      jenisLembaga: model.jenisLembaga,
      namaLembaga: model.namaLembaga,
      periodeRapta: model.periodeRapta,
      nomorSurat: model.nomorSurat,
      periodeKepengurusan: model.periodeKepengurusan,
      ketuaTerpilih: model.ketuaTerpilih,
      namaWilayah: model.namaWilayah,
      tanggalHijriah: model.tanggalHijriah,
      tanggalMasehi: model.tanggalMasehi,
      waktuPenetapan: model.waktuPenetapan,
      namaKetua: model.namaKetua,
      namaSekretaris: model.namaSekretaris,
      namaAnggota: model.namaAnggota,
      ttdKetuaPath: model.ttdKetua.path,
      ttdSekretarisPath: model.ttdSekretaris.path,
      ttdAnggotaPath: model.ttdAnggota.path,
      timFormatur:
          model.timFormatur
              .map(
                (tim) => TimFormaturEntity(
                  no: tim.no,
                  nama: tim.nama,
                  daerahPengkaderan: tim.daerahPengkaderan,
                ),
              )
              .toList(),
    );
  }

  static SuratKeputusanIpnuModel toModel(SuratKeputusanIpnuEntity entity) {
    return SuratKeputusanIpnuModel(
      jenisLembaga: entity.jenisLembaga,
      namaLembaga: entity.namaLembaga,
      periodeRapta: entity.periodeRapta,
      nomorSurat: entity.nomorSurat,
      periodeKepengurusan: entity.periodeKepengurusan,
      ketuaTerpilih: entity.ketuaTerpilih,
      namaWilayah: entity.namaWilayah,
      tanggalHijriah: entity.tanggalHijriah,
      tanggalMasehi: entity.tanggalMasehi,
      waktuPenetapan: entity.waktuPenetapan,
      namaKetua: entity.namaKetua,
      namaSekretaris: entity.namaSekretaris,
      namaAnggota: entity.namaAnggota,
      ttdKetua: File(entity.ttdKetuaPath),
      ttdSekretaris: File(entity.ttdSekretarisPath),
      ttdAnggota: File(entity.ttdAnggotaPath),
      timFormatur:
          entity.timFormatur
              .map(
                (tim) => TimFormaturModel(
                  no: tim.no,
                  nama: tim.nama,
                  daerahPengkaderan: tim.daerahPengkaderan,
                ),
              )
              .toList(),
    );
  }
}
