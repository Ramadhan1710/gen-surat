import 'package:gen_surat/data/models/bersama/surat_dispensasi_bersama_model.dart';
import 'package:gen_surat/domain/entities/bersama/surat_dispensasi_bersama_entity.dart';

class SuratDispensasiBersamaMapper {
  static SuratDispensasiBersamaEntity toEntity(SuratDispensasiBersamaModel model) {
    return SuratDispensasiBersamaEntity(
      nomorSurat: model.nomorSurat,
      lampiran: model.lampiran,
      tujuanSurat: model.tujuanSurat,
      namaKegiatan: model.namaKegiatan,
      hariTanggal: model.hariTanggal,
      waktu: model.waktu,
      tempat: model.tempat,
      nama: model.nama,
      kelasSekolah: model.kelasSekolah,
      tanggalHijriah: model.tanggalHijriah,
      tanggalMasehi: model.tanggalMasehi,
    );
  }

  static SuratDispensasiBersamaModel toModel(SuratDispensasiBersamaEntity entity) {
    return SuratDispensasiBersamaModel(
      nomorSurat: entity.nomorSurat,
      lampiran: entity.lampiran,
      tujuanSurat: entity.tujuanSurat,
      namaKegiatan: entity.namaKegiatan,
      hariTanggal: entity.hariTanggal,
      waktu: entity.waktu,
      tempat: entity.tempat,
      nama: entity.nama,
      kelasSekolah: entity.kelasSekolah,
      tanggalHijriah: entity.tanggalHijriah,
      tanggalMasehi: entity.tanggalMasehi,
    );
  }
}
