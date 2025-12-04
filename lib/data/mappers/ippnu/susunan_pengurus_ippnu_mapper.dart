import '../../../domain/entities/ippnu/susunan_pengurus_ippnu_entity.dart';
import '../../models/ippnu/susunan_pengurus_ippnu_model.dart';

class SusunanPengurusIppnuMapper {
  static SusunanPengurusIppnuEntity toEntity(SusunanPengurusIppnuModel model) {
    return SusunanPengurusIppnuEntity(
      jenisLembaga: model.jenisLembaga,
      namaLembaga: model.namaLembaga,
      periodeKepengurusan: model.periodeKepengurusan,
      alamatLembaga: model.alamatLembaga,
      nomorTeleponLembaga: model.nomorTeleponLembaga,
      emailLembaga: model.emailLembaga,
      namaKetua: model.namaKetua,
      wakilKetua:
          model.wakilKetua
              .map((e) => WakilKetuaItem(title: e.title, nama: e.nama))
              .toList(),
      namaSekretaris: model.namaSekretaris,
      wakilSekre:
          model.wakilSekre
              .map((e) => WakilSekretarisItem(title: e.title, nama: e.nama))
              .toList(),
      namaBendahara: model.namaBendahara,
      namaWakilBend: model.namaWakilBend,
      departemen:
          model.departemen
              .map(
                (e) => DepartemenItem(
                  namaDepartemen: e.namaDepartemen,
                  koordinator: e.koordinator,
                  anggota:
                      e.anggota
                          .map((a) => AnggotaDepartemenItem(nama: a.nama))
                          .toList(),
                ),
              )
              .toList(),
      lembaga:
          model.lembaga
              .map(
                (e) => LembagaItem(
                  nama: e.nama,
                  direktur: e.direktur,
                  sekretaris: e.sekretaris,
                  anggota:
                      e.anggota
                          .map((a) => AnggotaLembagaItem(nama: a.nama))
                          .toList(),
                ),
              )
              .toList(),
      pelindung:
          model.pelindung.map((e) => PelindungItem(nama: e.nama)).toList(),
      pembina:
          model.pembina
              .map((e) => PembinaItem(no: e.no, nama: e.nama))
              .toList(),
    );
  }

  static SusunanPengurusIppnuModel toModel(SusunanPengurusIppnuEntity entity) {
    return SusunanPengurusIppnuModel(
      jenisLembaga: entity.jenisLembaga,
      namaLembaga: entity.namaLembaga,
      periodeKepengurusan: entity.periodeKepengurusan,
      alamatLembaga: entity.alamatLembaga,
      nomorTeleponLembaga: entity.nomorTeleponLembaga,
      emailLembaga: entity.emailLembaga,
      namaKetua: entity.namaKetua,
      wakilKetua:
          entity.wakilKetua
              .map((e) => WakilKetuaItemModel(title: e.title, nama: e.nama))
              .toList(),
      namaSekretaris: entity.namaSekretaris,
      wakilSekre:
          entity.wakilSekre
              .map(
                (e) => WakilSekretarisItemModel(title: e.title, nama: e.nama),
              )
              .toList(),
      namaBendahara: entity.namaBendahara,
      namaWakilBend: entity.namaWakilBend,
      departemen:
          entity.departemen
              .map(
                (e) => DepartemenItemModel(
                  namaDepartemen: e.namaDepartemen,
                  koordinator: e.koordinator,
                  anggota:
                      e.anggota
                          .map((a) => AnggotaDepartemenItemModel(nama: a.nama))
                          .toList(),
                ),
              )
              .toList(),
      lembaga:
          entity.lembaga
              .map(
                (e) => LembagaItemModel(
                  nama: e.nama,
                  direktur: e.direktur,
                  sekretaris: e.sekretaris,
                  anggota:
                      e.anggota
                          .map((a) => AnggotaLembagaItemModel(nama: a.nama))
                          .toList(),
                ),
              )
              .toList(),
      pelindung:
          entity.pelindung
              .map((e) => PelindungItemModel(nama: e.nama))
              .toList(),
      pembina:
          entity.pembina
              .map((e) => PembinaItemModel(no: e.no, nama: e.nama))
              .toList(),
    );
  }
}
