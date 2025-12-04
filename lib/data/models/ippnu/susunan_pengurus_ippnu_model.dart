class SusunanPengurusIppnuModel {
  final String jenisLembaga;
  final String namaLembaga;
  final String periodeKepengurusan;
  final String alamatLembaga;
  final String nomorTeleponLembaga;
  final String emailLembaga;
  final String namaKetua;
  final List<WakilKetuaItemModel> wakilKetua;
  final String namaSekretaris;
  final List<WakilSekretarisItemModel> wakilSekre;
  final String namaBendahara;
  final String namaWakilBend;
  final List<DepartemenItemModel> departemen;
  final List<LembagaItemModel> lembaga;
  final List<PelindungItemModel> pelindung;
  final List<PembinaItemModel> pembina;

  SusunanPengurusIppnuModel({
    required this.jenisLembaga,
    required this.namaLembaga,
    required this.periodeKepengurusan,
    required this.alamatLembaga,
    required this.nomorTeleponLembaga,
    required this.emailLembaga,
    required this.namaKetua,
    required this.wakilKetua,
    required this.namaSekretaris,
    required this.wakilSekre,
    required this.namaBendahara,
    required this.namaWakilBend,
    required this.departemen,
    required this.lembaga,
    required this.pelindung,
    required this.pembina,
  });

  Future<Map<String, dynamic>> toMultipartMap() async {
    return {
      "jenis_lembaga": jenisLembaga,
      "nama_lembaga": namaLembaga,
      "periode_kepengurusan": periodeKepengurusan,
      "alamat_lembaga": alamatLembaga,
      "nomor_telepon_lembaga": nomorTeleponLembaga,
      "email_lembaga": emailLembaga,
      "nama_ketua": namaKetua,
      "wakil_ketua": wakilKetua.map((e) => e.toMap()).toList(),
      "nama_sekretaris": namaSekretaris,
      "wakil_sekre": wakilSekre.map((e) => e.toMap()).toList(),
      "nama_bendahara": namaBendahara,
      "nama_wakil_bend": namaWakilBend,
      "departemen": departemen.map((e) => e.toMap()).toList(),
      "lembaga": lembaga.map((e) => e.toMap()).toList(),
      "pelindung": pelindung.map((e) => e.toMap()).toList(),
      "pembina": pembina.map((e) => e.toMap()).toList(),
    };
  }
}

class WakilKetuaItemModel {
  final String title;
  final String nama;

  WakilKetuaItemModel({
    required this.title,
    required this.nama,
  });

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "nama": nama,
    };
  }
}

class WakilSekretarisItemModel {
  final String title;
  final String nama;

  WakilSekretarisItemModel({
    required this.title,
    required this.nama,
  });

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "nama": nama,
    };
  }
}

class DepartemenItemModel {
  final String namaDepartemen;
  final String koordinator;
  final List<AnggotaDepartemenItemModel> anggota;

  DepartemenItemModel({
    required this.namaDepartemen,
    required this.koordinator,
    required this.anggota,
  });

  Map<String, dynamic> toMap() {
    return {
      "nama_departemen": namaDepartemen,
      "koordinator": koordinator,
      "anggota": anggota.map((e) => e.toMap()).toList(),
    };
  }
}

class AnggotaDepartemenItemModel {
  final String nama;

  AnggotaDepartemenItemModel({
    required this.nama,
  });

  Map<String, dynamic> toMap() {
    return {
      "nama": nama,
    };
  }
}

class LembagaItemModel {
  final String nama;
  final String direktur;
  final String sekretaris;
  final List<AnggotaLembagaItemModel> anggota;

  LembagaItemModel({
    required this.nama,
    required this.direktur,
    required this.sekretaris,
    required this.anggota,
  });

  Map<String, dynamic> toMap() {
    return {
      "nama": nama,
      "direktur": direktur,
      "sekretaris": sekretaris,
      "anggota": anggota.map((e) => e.toMap()).toList(),
    };
  }
}

class AnggotaLembagaItemModel {
  final String nama;

  AnggotaLembagaItemModel({
    required this.nama,
  });

  Map<String, dynamic> toMap() {
    return {
      "nama": nama,
    };
  }
}

class PelindungItemModel {
  final String nama;

  PelindungItemModel({
    required this.nama,
  });

  Map<String, dynamic> toMap() {
    return {
      "nama": nama,
    };
  }
}

class PembinaItemModel {
  final int no;
  final String nama;

  PembinaItemModel({
    required this.no,
    required this.nama,
  });

  Map<String, dynamic> toMap() {
    return {
      "no": no,
      "nama": nama,
    };
  }
}
