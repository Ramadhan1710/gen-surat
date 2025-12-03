import 'package:gen_surat/data/models/ipnu/susunan_pengurus_ipnu_model.dart';
import 'package:gen_surat/domain/entities/ipnu/susunan_pengurus_ipnu_entity.dart';

class SusunanPengurusIpnuMapper {
  static SusunanPengurusIpnuEntity toEntity(SusunanPengurusIpnuModel model) {
    return SusunanPengurusIpnuEntity(
      jenisLembaga: model.jenisLembaga,
      namaLembaga: model.namaLembaga,
      alamatLembaga: model.alamatLembaga,
      nomorTeleponLembaga: model.nomorTeleponLembaga,
      emailLembaga: model.emailLembaga,
      periodeKepengurusan: model.periodeKepengurusan,
      isRanting: model.isRanting,
      namaRoisSyuriyah: model.namaRoisSyuriyah,
      namaKetuaTanfidziyah: model.namaKetuaTanfidziyah,
      isKomisariat: model.isKomisariat,
      namaKepalaMadrasah: model.namaKepalaMadrasah,
      pembina:
          model.pembina
              .map(
                (pembina) => PembinaEntity(no: pembina.no, nama: pembina.nama),
              )
              .toList(),
      namaKetua: model.namaKetua,
      alamatKetua: model.alamatKetua,
      wakilKetua:
          model.wakilKetua
              .map(
                (wakil) => WakilKetuaEntity(
                  title: wakil.title,
                  nama: wakil.nama,
                  alamat: wakil.alamat,
                ),
              )
              .toList(),
      namaSekretaris: model.namaSekretaris,
      alamatSekretaris: model.alamatSekretaris,
      wakilSekre:
          model.wakilSekre
              ?.map(
                (wakil) => WakilSekretarisEntity(
                  title: wakil.title,
                  nama: wakil.nama,
                  alamat: wakil.alamat,
                ),
              )
              .toList(),
      namaBendahara: model.namaBendahara,
      alamatBendahara: model.alamatBendahara,
      namaWakilBend: model.namaWakilBend,
      alamatWakilBend: model.alamatWakilBend,
      departemen:
          model.departemen
              .map(
                (dept) => DepartemenEntity(
                  nama: dept.nama,
                  koordinator: dept.koordinator,
                  alamatKoordinator: dept.alamatKoordinator,
                  anggota:
                      dept.anggota
                          .map(
                            (anggota) => AnggotaDepartemenEntity(
                              nama: anggota.nama,
                              alamat: anggota.alamat,
                            ),
                          )
                          .toList(),
                ),
              )
              .toList(),
      lembaga:
          model.lembaga
              .map(
                (lembaga) => LembagaEntity(
                  nama: lembaga.nama,
                  direktur: lembaga.direktur,
                  alamatDirektur: lembaga.alamatDirektur,
                  sekretaris: lembaga.sekretaris,
                  alamatSekretaris: lembaga.alamatSekretaris,
                  anggota:
                      lembaga.anggota
                          ?.map(
                            (anggota) => AnggotaLembagaEntity(
                              nama: anggota.nama,
                              alamat: anggota.alamat,
                            ),
                          )
                          .toList(),
                ),
              )
              .toList(),
      hasLembagaCBP: model.hasLembagaCBP,
      komandan: model.komandan,
      alamatKomandan: model.alamatKomandan,
      wakilKomandan: model.wakilKomandan,
      alamatWakilKomandan: model.alamatWakilKomandan,
      hasDivisi: model.hasDivisi,
      divisi:
          model.divisi
              ?.map(
                (divisi) => DivisiEntity(
                  nama: divisi.nama,
                  koordinator: divisi.koordinator,
                  alamatKoordinator: divisi.alamatKoordinator,
                  anggota:
                      divisi.anggota
                          ?.map(
                            (anggota) => AnggotaDivisiEntity(
                              nama: anggota.nama,
                              alamat: anggota.alamat,
                            ),
                          )
                          .toList(),
                ),
              )
              .toList(),
    );
  }

  static SusunanPengurusIpnuModel toModel(SusunanPengurusIpnuEntity entity) {
    return SusunanPengurusIpnuModel(
      jenisLembaga: entity.jenisLembaga,
      namaLembaga: entity.namaLembaga,
      alamatLembaga: entity.alamatLembaga,
      nomorTeleponLembaga: entity.nomorTeleponLembaga,
      emailLembaga: entity.emailLembaga,
      periodeKepengurusan: entity.periodeKepengurusan,
      isRanting: entity.isRanting,
      namaRoisSyuriyah: entity.namaRoisSyuriyah,
      namaKetuaTanfidziyah: entity.namaKetuaTanfidziyah,
      isKomisariat: entity.isKomisariat,
      namaKepalaMadrasah: entity.namaKepalaMadrasah,
      pembina:
          entity.pembina
              .map(
                (pembina) => PembinaModel(no: pembina.no, nama: pembina.nama),
              )
              .toList(),
      namaKetua: entity.namaKetua,
      alamatKetua: entity.alamatKetua,
      wakilKetua:
          entity.wakilKetua
              .map(
                (wakil) => WakilKetuaModel(
                  title: wakil.title,
                  nama: wakil.nama,
                  alamat: wakil.alamat,
                ),
              )
              .toList(),
      namaSekretaris: entity.namaSekretaris,
      alamatSekretaris: entity.alamatSekretaris,
      wakilSekre:
          entity.wakilSekre
              ?.map(
                (wakil) => WakilSekretarisModel(
                  title: wakil.title,
                  nama: wakil.nama,
                  alamat: wakil.alamat,
                ),
              )
              .toList(),
      namaBendahara: entity.namaBendahara,
      alamatBendahara: entity.alamatBendahara,
      namaWakilBend: entity.namaWakilBend,
      alamatWakilBend: entity.alamatWakilBend,
      departemen:
          entity.departemen
              .map(
                (dept) => DepartemenModel(
                  nama: dept.nama,
                  koordinator: dept.koordinator,
                  alamatKoordinator: dept.alamatKoordinator,
                  anggota:
                      dept.anggota
                          .map(
                            (anggota) => AnggotaDepartemenModel(
                              nama: anggota.nama,
                              alamat: anggota.alamat,
                            ),
                          )
                          .toList(),
                ),
              )
              .toList(),
      lembaga:
          entity.lembaga
              .map(
                (lembaga) => LembagaModel(
                  nama: lembaga.nama,
                  direktur: lembaga.direktur,
                  alamatDirektur: lembaga.alamatDirektur,
                  sekretaris: lembaga.sekretaris,
                  alamatSekretaris: lembaga.alamatSekretaris,
                  anggota:
                      lembaga.anggota
                          ?.map(
                            (anggota) => AnggotaLembagaModel(
                              nama: anggota.nama,
                              alamat: anggota.alamat,
                            ),
                          )
                          .toList(),
                ),
              )
              .toList(),
      hasLembagaCBP: entity.hasLembagaCBP,
      komandan: entity.komandan,
      alamatKomandan: entity.alamatKomandan,
      wakilKomandan: entity.wakilKomandan,
      alamatWakilKomandan: entity.alamatWakilKomandan,
      hasDivisi: entity.hasDivisi,
      divisi:
          entity.divisi
              ?.map(
                (divisi) => DivisiModel(
                  nama: divisi.nama,
                  koordinator: divisi.koordinator,
                  alamatKoordinator: divisi.alamatKoordinator,
                  anggota:
                      divisi.anggota
                          ?.map(
                            (anggota) => AnggotaDivisiModel(
                              nama: anggota.nama,
                              alamat: anggota.alamat,
                            ),
                          )
                          .toList(),
                ),
              )
              .toList(),
    );
  }
}
