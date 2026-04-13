import 'package:gen_surat/data/models/bersama/surat_permohonan_peminjaman_alat_bersama_model.dart';
import 'package:gen_surat/data/models/bersama/surat_undangan_bersama_model.dart';
import 'package:gen_surat/domain/entities/bersama/surat_permohonan_peminjaman_alat_bersama_entity.dart';

class SuratPermohonanPeminjamanAlatBersamaMapper {
  static SuratPermohonanPeminjamanAlatBersamaEntity toEntity(SuratPermohonanPeminjamanAlatBersamaModel model) {
    return SuratPermohonanPeminjamanAlatBersamaEntity(
      nomorSurat: model.nomorSurat,
      lampiran: model.lampiran,
      tujuanSurat: model.tujuanSurat,
      namaKegiatan: model.namaKegiatan,
      hariTanggal: model.hariTanggal,
      waktu: model.waktu,
      tempat: model.tempat,
      alat: model.alat,
      tanggalHijriah: model.tanggalHijriah,
      tanggalMasehi: model.tanggalMasehi,
    );
  }

  static SuratPermohonanPeminjamanAlatBersamaModel toModel(SuratPermohonanPeminjamanAlatBersamaEntity entity) {
    return SuratPermohonanPeminjamanAlatBersamaModel(
      nomorSurat: entity.nomorSurat,
      lampiran: entity.lampiran,
      tujuanSurat: entity.tujuanSurat,
      namaKegiatan: entity.namaKegiatan,
      hariTanggal: entity.hariTanggal,
      waktu: entity.waktu,
      tempat: entity.tempat,
      alat: entity.alat,
      tanggalHijriah: entity.tanggalHijriah,
      tanggalMasehi: entity.tanggalMasehi,
    );
  }
}
