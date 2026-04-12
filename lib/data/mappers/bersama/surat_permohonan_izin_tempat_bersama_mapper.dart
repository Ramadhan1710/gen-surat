import 'package:gen_surat/data/models/bersama/surat_permohonan_izin_tempat_bersama_model.dart';
import 'package:gen_surat/domain/entities/bersama/surat_permohonan_izin_tempat_bersama_entity.dart';

class SuratPermohonanIzinTempatBersamaMapper {
  static SuratPermohonanIzinTempatBersamaEntity toEntity(SuratPermohonanIzinTempatBersamaModel model) {
    return SuratPermohonanIzinTempatBersamaEntity(
      nomorSurat: model.nomorSurat,
      lampiran: model.lampiran,
      tujuanSurat: model.tujuanSurat,
      namaKegiatan: model.namaKegiatan,
      hariTanggal: model.hariTanggal,
      waktu: model.waktu,
      tempat: model.tempat,
      tanggalHijriah: model.tanggalHijriah,
      tanggalMasehi: model.tanggalMasehi,
    );
  }

  static SuratPermohonanIzinTempatBersamaModel toModel(SuratPermohonanIzinTempatBersamaEntity entity) {
    return SuratPermohonanIzinTempatBersamaModel(
      nomorSurat: entity.nomorSurat,
      lampiran: entity.lampiran,
      tujuanSurat: entity.tujuanSurat,
      namaKegiatan: entity.namaKegiatan,
      hariTanggal: entity.hariTanggal,
      waktu: entity.waktu,
      tempat: entity.tempat,
      tanggalHijriah: entity.tanggalHijriah,
      tanggalMasehi: entity.tanggalMasehi,
    );
  }
}
