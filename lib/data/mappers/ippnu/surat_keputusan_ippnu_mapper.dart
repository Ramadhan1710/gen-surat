import 'dart:io';
import '../../../domain/entities/ippnu/surat_keputusan_ippnu_entity.dart';
import '../../models/ippnu/surat_keputusan_ippnu_model.dart';

class SuratKeputusanIppnuMapper {
  static SuratKeputusanIppnuEntity toEntity(
    SuratKeputusanIppnuModel model,
  ) {
    return SuratKeputusanIppnuEntity(
      periodeRapta: model.periodeRapta,
      jenisLembaga: model.jenisLembaga,
      nomorSurat: model.nomorSurat,
      namaLembaga: model.namaLembaga,
      periodeKepengurusan: model.periodeKepengurusan,
      ketuaTerpilih: model.ketuaTerpilih,
      namaWilayah: model.namaWilayah,
      tanggalHijriah: model.tanggalHijriah,
      tanggalMasehi: model.tanggalMasehi,
      waktuPenetapan: model.waktuPenetapan,
      namaKetua: model.namaKetua,
      namaSekretaris: model.namaSekretaris,
      namaAnggota: model.namaAnggota,
      timFormatur: model.timFormatur
          .map((e) => TimFormaturItem(
                no: e.no,
                nama: e.nama,
                daerahPengkaderan: e.daerahPengkaderan,
              ))
          .toList(),
      ttdKetuaPath: model.ttdKetua.path,
      ttdSekretarisPath: model.ttdSekretaris.path,
      ttdAnggotaPath: model.ttdAnggota.path,
    );
  }

  static SuratKeputusanIppnuModel toModel(
    SuratKeputusanIppnuEntity entity,
  ) {
    return SuratKeputusanIppnuModel(
      periodeRapta: entity.periodeRapta,
      jenisLembaga: entity.jenisLembaga,
      nomorSurat: entity.nomorSurat,
      namaLembaga: entity.namaLembaga,
      periodeKepengurusan: entity.periodeKepengurusan,
      ketuaTerpilih: entity.ketuaTerpilih,
      namaWilayah: entity.namaWilayah,
      tanggalHijriah: entity.tanggalHijriah,
      tanggalMasehi: entity.tanggalMasehi,
      waktuPenetapan: entity.waktuPenetapan,
      namaKetua: entity.namaKetua,
      namaSekretaris: entity.namaSekretaris,
      namaAnggota: entity.namaAnggota,
      timFormatur: entity.timFormatur
          .map((e) => TimFormaturItemModel(
                no: e.no,
                nama: e.nama,
                daerahPengkaderan: e.daerahPengkaderan,
              ))
          .toList(),
      ttdKetua: File(entity.ttdKetuaPath),
      ttdSekretaris: File(entity.ttdSekretarisPath),
      ttdAnggota: File(entity.ttdAnggotaPath),
    );
  }
}
