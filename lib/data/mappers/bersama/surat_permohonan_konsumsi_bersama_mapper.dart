import 'package:gen_surat/data/models/bersama/surat_permohonan_konsumsi_bersama_model.dart';
import 'package:gen_surat/domain/entities/bersama/surat_permohonan_konsumsi_bersama_entity.dart';

class SuratPermohonanKonsumsiBersamaMapper {
  static SuratPermohonanKonsumsiBersamaEntity toEntity(SuratPermohonanKonsumsiBersamaModel model) {
    return SuratPermohonanKonsumsiBersamaEntity(
      nomorSurat: model.nomorSurat,
      lampiran: model.lampiran,
      tujuanSurat: model.tujuanSurat,
      namaKegiatan: model.namaKegiatan,
      hariTanggal: model.hariTanggal,
      waktu: model.waktu,
      tempat: model.tempat,
      namaKonsumsi: model.namaKonsumsi,
      jumlahKonsumsi: model.jumlahKonsumsi,
      tanggalHijriah: model.tanggalHijriah,
      tanggalMasehi: model.tanggalMasehi,
    );
  }

  static SuratPermohonanKonsumsiBersamaModel toModel(SuratPermohonanKonsumsiBersamaEntity entity) {
    return SuratPermohonanKonsumsiBersamaModel(
      nomorSurat: entity.nomorSurat,
      lampiran: entity.lampiran,
      tujuanSurat: entity.tujuanSurat,
      namaKegiatan: entity.namaKegiatan,
      hariTanggal: entity.hariTanggal,
      waktu: entity.waktu,
      tempat: entity.tempat,
      namaKonsumsi: entity.namaKonsumsi,
      jumlahKonsumsi: entity.jumlahKonsumsi,
      tanggalHijriah: entity.tanggalHijriah,
      tanggalMasehi: entity.tanggalMasehi,
    );
  }
}
