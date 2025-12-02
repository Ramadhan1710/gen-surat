import 'package:gen_surat/data/models/ipnu/kartu_identitas_model.dart';
import 'package:gen_surat/domain/entities/ipnu/kartu_identitas_entity.dart';

class KartuIdentitasMapper {
  KartuIdentitasEntity toEntity(KartuIdentitasModel model) {
    return KartuIdentitasEntity(
      jenisLembaga: model.jenisLembaga,
      namaLembaga: model.namaLembaga,
      periodeKepengurusan: model.periodeKepengurusan,
      kartuIdentitasKetuaPath: model.kartuIdentitasKetuaPath,
      kartuIdentitasSekretarisPath: model.kartuIdentitasSekretarisPath,
      kartuIdentitasBendaharaPath: model.kartuIdentitasBendaharaPath,
    );
  }

  KartuIdentitasModel toModel(KartuIdentitasEntity entity) {
    return KartuIdentitasModel(
      jenisLembaga: entity.jenisLembaga,
      namaLembaga: entity.namaLembaga,
      periodeKepengurusan: entity.periodeKepengurusan,
      kartuIdentitasKetuaPath: entity.kartuIdentitasKetuaPath,
      kartuIdentitasSekretarisPath: entity.kartuIdentitasSekretarisPath,
      kartuIdentitasBendaharaPath: entity.kartuIdentitasBendaharaPath,
    );
  }
}
