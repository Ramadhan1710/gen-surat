import 'package:gen_surat/data/models/bersama/surat_permohonan_pemateri_bersama_model.dart';
import 'package:gen_surat/domain/entities/bersama/surat_permohonan_pemateri_bersama_entity.dart';

class SuratPermohonanPemateriBersamaMapper {
  static SuratPermohonanPemateriBersamaEntity toEntity(SuratPermohonanPemateriBersamaModel model) {
    return SuratPermohonanPemateriBersamaEntity(
      nomorSurat: model.nomorSurat,
      lampiran: model.lampiran,
      tujuanSurat: model.tujuanSurat,
      namaKegiatan: model.namaKegiatan,
      hariTanggal: model.hariTanggal,
      waktu: model.waktu,
      tempat: model.tempat,
      pemateri: model.pemateri,
      materi: model.materi,
      tanggalHijriah: model.tanggalHijriah,
      tanggalMasehi: model.tanggalMasehi,
    );
  }

  static SuratPermohonanPemateriBersamaModel toModel(SuratPermohonanPemateriBersamaEntity entity) {
    return SuratPermohonanPemateriBersamaModel(
      nomorSurat: entity.nomorSurat,
      lampiran: entity.lampiran,
      tujuanSurat: entity.tujuanSurat,
      namaKegiatan: entity.namaKegiatan,
      hariTanggal: entity.hariTanggal,
      waktu: entity.waktu,
      tempat: entity.tempat,
      pemateri: entity.pemateri,
      materi: entity.materi,
      tanggalHijriah: entity.tanggalHijriah,
      tanggalMasehi: entity.tanggalMasehi,
    );
  }
}
