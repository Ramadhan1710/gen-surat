import 'dart:io';

import '../../../domain/entities/ippnu/surat_permohonan_pengesahan_ippnu_entity.dart';
import '../../models/ippnu/surat_permohonan_pengesahan_ippnu_model.dart';

class SuratPermohonanPengesahanIppnuMapper {
  static SuratPermohonanPengesahanIppnuEntity toEntity(
    SuratPermohonanPengesahanIppnuModel model,
  ) {
    return SuratPermohonanPengesahanIppnuEntity(
      jenisLembaga: model.jenisLembaga,
      namaLembaga: model.namaLembaga,
      teleponLembaga: model.teleponLembaga,
      alamatLembaga: model.alamatLembaga,
      emailLembaga: model.emailLembaga,
      nomorSurat: model.nomorSurat,
      tanggalRapta: model.tanggalRapta,
      nomorRapta: model.nomorRapta,
      tempatRapta: model.tempatRapta,
      tanggalKeputusan: model.tanggalKeputusan,
      tanggalHijriah: model.tanggalHijriah,
      tanggalMasehi: model.tanggalMasehi,
      periodeKepengurusan: model.periodeKepengurusan,
      namaKetuaTerpilih: model.namaKetuaTerpilih,
      namaSekretarisTerpilih: model.namaSekretarisTerpilih,
      namaLembagaInduk: model.namaLembagaInduk,
      tingkatLembaga: model.tingkatLembaga,
      ttdKetuaPath: model.ttdKetua.path,
      ttdSekretarisPath: model.ttdSekretaris.path,
    );
  }

  static SuratPermohonanPengesahanIppnuModel toModel(
    SuratPermohonanPengesahanIppnuEntity entity,
  ) {
    return SuratPermohonanPengesahanIppnuModel(
      jenisLembaga: entity.jenisLembaga,
      namaLembaga: entity.namaLembaga,
      teleponLembaga: entity.teleponLembaga,
      alamatLembaga: entity.alamatLembaga,
      emailLembaga: entity.emailLembaga,
      nomorSurat: entity.nomorSurat,
      tanggalRapta: entity.tanggalRapta,
      nomorRapta: entity.nomorRapta,
      tempatRapta: entity.tempatRapta,
      tanggalKeputusan: entity.tanggalKeputusan,
      tanggalHijriah: entity.tanggalHijriah,
      tanggalMasehi: entity.tanggalMasehi,
      periodeKepengurusan: entity.periodeKepengurusan,
      namaKetuaTerpilih: entity.namaKetuaTerpilih,
      namaSekretarisTerpilih: entity.namaSekretarisTerpilih,
      namaLembagaInduk: entity.namaLembagaInduk,
      tingkatLembaga: entity.tingkatLembaga,
      ttdKetua: File(entity.ttdKetuaPath),
      ttdSekretaris: File(entity.ttdSekretarisPath),
    );
  }
}
