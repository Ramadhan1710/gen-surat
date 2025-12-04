class BeritaAcaraPemilihanKetuaEntity {
  final String jenisLembaga;
  final String namaLembaga;
  final String periodeKepengurusan;
  final String tanggal;
  final String bulan;
  final String tahun;
  final String waktuPemilihanKetua;
  final String tempatPemilihanKetua;
  final int totalSuaraSahPencalonanKetua;
  final int totalSuaraTidakSahPencalonanKetua;
  final int totalSuaraTidakSahPemilihanKetua;
  final int totalSuaraSahPemilihanKetua;
  final String namaWilayah;
  final String tanggalHijriah;
  final String tanggalMasehi;
  final String waktuPenetapan;
  final String namaKetua;
  final String namaSekretaris;
  final String namaAnggota;
  final List<PencalonanKetuaEntity> pencalonanKetua;
  final List<PemilihanKetuaEntity> pemilihanKetua;
  final String namaKetuaTerpilih;
  final String alamatKetuaTerpilih;
  final int totalSuaraKetuaTerpilih;
  final List<FormaturEntity> formatur;
  final String ttdKetuaPath;
  final String ttdSekretarisPath;
  final String ttdAnggotaPath;

  BeritaAcaraPemilihanKetuaEntity({
    required this.jenisLembaga,
    required this.namaLembaga,
    required this.periodeKepengurusan,
    required this.tanggal,
    required this.bulan,
    required this.tahun,
    required this.waktuPemilihanKetua,
    required this.tempatPemilihanKetua,
    required this.totalSuaraSahPencalonanKetua,
    required this.totalSuaraTidakSahPencalonanKetua,
    required this.totalSuaraTidakSahPemilihanKetua,
    required this.totalSuaraSahPemilihanKetua,
    required this.namaWilayah,
    required this.tanggalHijriah,
    required this.tanggalMasehi,
    required this.waktuPenetapan,
    required this.namaKetua,
    required this.namaSekretaris,
    required this.namaAnggota,
    required this.pencalonanKetua,
    required this.pemilihanKetua,
    required this.namaKetuaTerpilih,
    required this.alamatKetuaTerpilih,
    required this.totalSuaraKetuaTerpilih,
    required this.formatur,
    required this.ttdKetuaPath,
    required this.ttdSekretarisPath,
    required this.ttdAnggotaPath,
  });
}

class PencalonanKetuaEntity {
  final int nomor;
  final String nama;
  final String alamat;
  final int jmlSuaraSah;

  PencalonanKetuaEntity({
    required this.nomor,
    required this.nama,
    required this.alamat,
    required this.jmlSuaraSah,
  });
}

class PemilihanKetuaEntity {
  final int nomor;
  final String nama;
  final String alamat;
  final int jmlSuaraSah;

  PemilihanKetuaEntity({
    required this.nomor,
    required this.nama,
    required this.alamat,
    required this.jmlSuaraSah,
  });
}

class FormaturEntity {
  final int nomor;
  final String nama;
  final String alamat;
  final String daerahPengkaderan;

  FormaturEntity({
    required this.nomor,
    required this.nama,
    required this.alamat,
    required this.daerahPengkaderan,
  });
}
