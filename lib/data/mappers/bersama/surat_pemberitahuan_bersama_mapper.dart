import 'package:gen_surat/data/models/bersama/surat_pemberitahuan_bersama_model.dart';
import 'package:gen_surat/data/models/bersama/surat_undangan_bersama_model.dart';
import 'package:gen_surat/domain/entities/bersama/surat_pemberitahuan_bersama_entity.dart';
import 'package:gen_surat/domain/entities/bersama/surat_undangan_bersama_entity.dart';

class SuratPemberitahuanBersamaMapper {
  static SuratPemberitahuanBersamaEntity toEntity(SuratPemberitahuanBersamaModel model) {
    return SuratPemberitahuanBersamaEntity(
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

  static SuratPemberitahuanBersamaModel toModel(SuratPemberitahuanBersamaEntity entity) {
    return SuratPemberitahuanBersamaModel(
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
