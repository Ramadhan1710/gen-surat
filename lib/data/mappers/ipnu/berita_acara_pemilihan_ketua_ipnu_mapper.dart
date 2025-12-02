import 'dart:io';

import 'package:gen_surat/data/models/ipnu/berita_acara_pemilihan_ketua_ipnu_model.dart';
import 'package:gen_surat/domain/entities/ipnu/berita_acara_pemilihan_ketua_ipnu_entity.dart';

class BeritaAcaraPemilihanKetuaIpnuMapper {
  static BeritaAcaraPemilihanKetuaIpnuEntity toEntity(
    BeritaAcaraPemilihanKetuaIpnuModel model,
  ) {
    return BeritaAcaraPemilihanKetuaIpnuEntity(
      jenisLembaga: model.jenisLembaga,
      namaLembaga: model.namaLembaga,
      periodeKepengurusan: model.periodeKepengurusan,
      tanggal: model.tanggal,
      bulan: model.bulan,
      tahun: model.tahun,
      waktuPemilihanKetua: model.waktuPemilihanKetua,
      tempatPemilihanKetua: model.tempatPemilihanKetua,
      totalSuaraSahPencalonanKetua: model.totalSuaraSahPencalonanKetua,
      totalSuaraTidakSahPencalonanKetua: model.totalSuaraTidakSahPencalonanKetua,
      totalSuaraTidakSahPemilihanKetua: model.totalSuaraTidakSahPemilihanKetua,
      totalSuaraSahPemilihanKetua: model.totalSuaraSahPemilihanKetua,
      namaWilayah: model.namaWilayah,
      tanggalHijriah: model.tanggalHijriah,
      tanggalMasehi: model.tanggalMasehi,
      waktuPenetapan: model.waktuPenetapan,
      namaKetua: model.namaKetua,
      namaSekretaris: model.namaSekretaris,
      namaAnggota: model.namaAnggota,
      pencalonanKetua: model.pencalonanKetua
          .map(
            (pencalonan) => PencalonanKetuaEntity(
              nomor: pencalonan.nomor,
              nama: pencalonan.nama,
              alamat: pencalonan.alamat,
              jmlSuaraSah: pencalonan.jmlSuaraSah,
            ),
          )
          .toList(),
      pemilihanKetua: model.pemilihanKetua
          .map(
            (pemilihan) => PemilihanKetuaEntity(
              nomor: pemilihan.nomor,
              nama: pemilihan.nama,
              alamat: pemilihan.alamat,
              jmlSuaraSah: pemilihan.jmlSuaraSah,
            ),
          )
          .toList(),
      namaKetuaTerpilih: model.namaKetuaTerpilih,
      alamatKetuaTerpilih: model.alamatKetuaTerpilih,
      totalSuaraKetuaTerpilih: model.totalSuaraKetuaTerpilih,
      formatur: model.formatur
          .map(
            (formatur) => FormaturEntity(
              nomor: formatur.nomor,
              nama: formatur.nama,
              alamat: formatur.alamat,
              daerahPengkaderan: formatur.daerahPengkaderan,
            ),
          )
          .toList(),
      ttdKetuaPath: model.ttdKetua.path,
      ttdSekretarisPath: model.ttdSekretaris.path,
      ttdAnggotaPath: model.ttdAnggota.path,
    );
  }

  static BeritaAcaraPemilihanKetuaIpnuModel toModel(
    BeritaAcaraPemilihanKetuaIpnuEntity entity,
  ) {
    return BeritaAcaraPemilihanKetuaIpnuModel(
      jenisLembaga: entity.jenisLembaga,
      namaLembaga: entity.namaLembaga,
      periodeKepengurusan: entity.periodeKepengurusan,
      tanggal: entity.tanggal,
      bulan: entity.bulan,
      tahun: entity.tahun,
      waktuPemilihanKetua: entity.waktuPemilihanKetua,
      tempatPemilihanKetua: entity.tempatPemilihanKetua,
      totalSuaraSahPencalonanKetua: entity.totalSuaraSahPencalonanKetua,
      totalSuaraTidakSahPencalonanKetua: entity.totalSuaraTidakSahPencalonanKetua,
      totalSuaraTidakSahPemilihanKetua: entity.totalSuaraTidakSahPemilihanKetua,
      totalSuaraSahPemilihanKetua: entity.totalSuaraSahPemilihanKetua,
      namaWilayah: entity.namaWilayah,
      tanggalHijriah: entity.tanggalHijriah,
      tanggalMasehi: entity.tanggalMasehi,
      waktuPenetapan: entity.waktuPenetapan,
      namaKetua: entity.namaKetua,
      namaSekretaris: entity.namaSekretaris,
      namaAnggota: entity.namaAnggota,
      pencalonanKetua: entity.pencalonanKetua
          .map(
            (pencalonan) => PencalonanKetuaModel(
              nomor: pencalonan.nomor,
              nama: pencalonan.nama,
              alamat: pencalonan.alamat,
              jmlSuaraSah: pencalonan.jmlSuaraSah,
            ),
          )
          .toList(),
      pemilihanKetua: entity.pemilihanKetua
          .map(
            (pemilihan) => PemilihanKetuaModel(
              nomor: pemilihan.nomor,
              nama: pemilihan.nama,
              alamat: pemilihan.alamat,
              jmlSuaraSah: pemilihan.jmlSuaraSah,
            ),
          )
          .toList(),
      namaKetuaTerpilih: entity.namaKetuaTerpilih,
      alamatKetuaTerpilih: entity.alamatKetuaTerpilih,
      totalSuaraKetuaTerpilih: entity.totalSuaraKetuaTerpilih,
      formatur: entity.formatur
          .map(
            (formatur) => FormaturModel(
              nomor: formatur.nomor,
              nama: formatur.nama,
              alamat: formatur.alamat,
              daerahPengkaderan: formatur.daerahPengkaderan,
            ),
          )
          .toList(),
      ttdKetua: File(entity.ttdKetuaPath),
      ttdSekretaris: File(entity.ttdSekretarisPath),
      ttdAnggota: File(entity.ttdAnggotaPath),
    );
  }
}
