import 'package:gen_surat/data/models/sertifikat_kaderisasi_model.dart';
import 'package:gen_surat/domain/entities/sertifikat_kaderisasi_entity.dart';

class SertifikatKaderisasiMapper {
  static SertifikatKaderisasiEntity toEntity(SertifikatKaderisasiModel model) {
    return SertifikatKaderisasiEntity(
      jenisLembaga: model.jenisLembaga,
      namaLembaga: model.namaLembaga,
      periodeKepengurusan: model.periodeKepengurusan,
      sertifikatKaderisasiKetuaPath: model.sertifikatKaderisasiKetuaPath,
      sertifikatKaderisasiSekretarisPath:
          model.sertifikatKaderisasiSekretarisPath,
      sertifikatKaderisasiBendaharaPath:
          model.sertifikatKaderisasiBendaharaPath,
    );
  }

  static SertifikatKaderisasiModel toModel(SertifikatKaderisasiEntity entity) {
    return SertifikatKaderisasiModel(
      jenisLembaga: entity.jenisLembaga,
      namaLembaga: entity.namaLembaga,
      periodeKepengurusan: entity.periodeKepengurusan,
      sertifikatKaderisasiKetuaPath: entity.sertifikatKaderisasiKetuaPath,
      sertifikatKaderisasiSekretarisPath:
          entity.sertifikatKaderisasiSekretarisPath,
      sertifikatKaderisasiBendaharaPath:
          entity.sertifikatKaderisasiBendaharaPath,
    );
  }
}
