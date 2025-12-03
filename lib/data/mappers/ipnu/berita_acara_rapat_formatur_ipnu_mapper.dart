import 'package:gen_surat/data/models/ipnu/berita_acara_rapat_formatur_ipnu_model.dart';
import 'package:gen_surat/domain/entities/ipnu/berita_acara_rapat_formatur_ipnu_entity.dart';

class BeritaAcaraRapatFormaturIpnuMapper {
  static BeritaAcaraRapatFormaturIpnuEntity toEntity(
    BeritaAcaraRapatFormaturIpnuModel model,
  ) {
    return BeritaAcaraRapatFormaturIpnuEntity(
      jenisLembaga: model.jenisLembaga,
      namaLembaga: model.namaLembaga,
      tanggal: model.tanggal,
      bulan: model.bulan,
      tahun: model.tahun,
      tempatRapat: model.tempatRapat,
      periodeRapta: model.periodeRapta,
      namaWilayah: model.namaWilayah,
      tanggalRapat: model.tanggalRapat,
      timFormatur:
          model.timFormatur
              .map(
                (m) => TimFormaturIpnuEntity(
                  nama: m.nama,
                  jabatan: m.jabatan,
                  ttdPath: m.ttdPath,
                ),
              )
              .toList(),
    );
  }

  static BeritaAcaraRapatFormaturIpnuModel toModel(
    BeritaAcaraRapatFormaturIpnuEntity entity,
  ) {
    return BeritaAcaraRapatFormaturIpnuModel(
      jenisLembaga: entity.jenisLembaga,
      namaLembaga: entity.namaLembaga,
      tanggal: entity.tanggal,
      bulan: entity.bulan,
      tahun: entity.tahun,
      tempatRapat: entity.tempatRapat,
      periodeRapta: entity.periodeRapta,
      namaWilayah: entity.namaWilayah,
      tanggalRapat: entity.tanggalRapat,
      timFormatur:
          entity.timFormatur
              .map(
                (e) => TimFormaturIpnuModel(
                  nama: e.nama,
                  jabatan: e.jabatan,
                  ttdPath: e.ttdPath,
                ),
              )
              .toList(),
    );
  }
}
