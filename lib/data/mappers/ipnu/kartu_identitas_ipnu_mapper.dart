import 'package:gen_surat/data/models/ipnu/kartu_identitas_ipnu_model.dart';
import 'package:gen_surat/domain/entities/ipnu/kartu_identitas_ipnu_entity.dart';

class KartuIdentitasIpnuMapper {
  static KartuIdentitasIpnuEntity toEntity(KartuIdentitasIpnuModel model) {
    return KartuIdentitasIpnuEntity(
      jenisLembaga: model.jenisLembaga,
      namaLembaga: model.namaLembaga,
      periodeKepengurusan: model.periodeKepengurusan,
      kartuIdentitasKetuaPath: model.kartuIdentitasKetuaPath,
      kartuIdentitasSekretarisPath: model.kartuIdentitasSekretarisPath,
      kartuIdentitasBendaharaPath: model.kartuIdentitasBendaharaPath,
    );
  }

  static KartuIdentitasIpnuModel toModel(KartuIdentitasIpnuEntity entity) {
    return KartuIdentitasIpnuModel(
      jenisLembaga: entity.jenisLembaga,
      namaLembaga: entity.namaLembaga,
      periodeKepengurusan: entity.periodeKepengurusan,
      kartuIdentitasKetuaPath: entity.kartuIdentitasKetuaPath,
      kartuIdentitasSekretarisPath: entity.kartuIdentitasSekretarisPath,
      kartuIdentitasBendaharaPath: entity.kartuIdentitasBendaharaPath,
    );
  }
}
