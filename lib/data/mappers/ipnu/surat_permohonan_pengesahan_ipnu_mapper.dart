import 'dart:io';

import '../../../domain/entities/surat_permohonan_pengesahan_ipnu_entity.dart';
import '../../models/ipnu/surat_permohonan_pengesahan_ipnu_model.dart';

class SuratPermohonanPengesahanIpnuMapper {
  static SuratPermohonanPengesahanIpnuEntity toEntity(
    SuratPermohonanPengesahanIpnuModel model,
  ) {
    return SuratPermohonanPengesahanIpnuEntity(
      jenisLembaga: model.jenisLembaga,
      namaLembaga: model.namaLembaga,
      nomorTeleponLembaga: model.nomorTeleponLembaga,
      alamatLembaga: model.alamatLembaga,
      emailLembaga: model.emailLembaga,
      nomorSurat: model.nomorSurat,
      tanggalRapat: model.tanggalRapat,
      tanggalHijriah: model.tanggalHijriah,
      tanggalMasehi: model.tanggalMasehi,
      periodeKepengurusan: model.periodeKepengurusan,
      namaKetuaTerpilih: model.namaKetuaTerpilih,
      namaSekretarisTerpilih: model.namaSekretarisTerpilih,
      jenisLembagaInduk: model.jenisLembagaInduk,
      ttdKetuaPath: model.ttdKetua.path,
      ttdSekretarisPath: model.ttdSekretaris.path,
    );
  }

  static SuratPermohonanPengesahanIpnuModel toModel(
    SuratPermohonanPengesahanIpnuEntity entity,
  ) {
    return SuratPermohonanPengesahanIpnuModel(
      jenisLembaga: entity.jenisLembaga,
      namaLembaga: entity.namaLembaga,
      nomorTeleponLembaga: entity.nomorTeleponLembaga,
      alamatLembaga: entity.alamatLembaga,
      emailLembaga: entity.emailLembaga,
      nomorSurat: entity.nomorSurat,
      tanggalRapat: entity.tanggalRapat,
      tanggalHijriah: entity.tanggalHijriah,
      tanggalMasehi: entity.tanggalMasehi,
      periodeKepengurusan: entity.periodeKepengurusan,
      namaKetuaTerpilih: entity.namaKetuaTerpilih,
      namaSekretarisTerpilih: entity.namaSekretarisTerpilih,
      jenisLembagaInduk: entity.jenisLembagaInduk,
      ttdKetua: File(entity.ttdKetuaPath),
      ttdSekretaris: File(entity.ttdSekretarisPath),
    );
  }
}
