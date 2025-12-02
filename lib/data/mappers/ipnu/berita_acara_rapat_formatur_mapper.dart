import 'package:gen_surat/data/models/ipnu/berita_acara_rapat_formatur_model.dart';
import 'package:gen_surat/domain/entities/ipnu/berita_acara_rapat_formatur_entity.dart';

class BeritaAcaraRapatFormaturMapper {
  BeritaAcaraRapatFormaturEntity toEntity(BeritaAcaraRapatFormaturModel model) {
    return BeritaAcaraRapatFormaturEntity(
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
                (m) => TimFormaturEntity(
                  nama: m.nama,
                  jabatan: m.jabatan,
                  ttdPath: m.ttdPath,
                ),
              )
              .toList(),
    );
  }

  BeritaAcaraRapatFormaturModel toModel(BeritaAcaraRapatFormaturEntity entity) {
    return BeritaAcaraRapatFormaturModel(
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
                (e) => TimFormaturModel(
                  nama: e.nama,
                  jabatan: e.jabatan,
                  ttdPath: e.ttdPath,
                ),
              )
              .toList(),
    );
  }
}
