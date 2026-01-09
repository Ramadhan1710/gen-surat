class SusunanPengurusIpnuModel {
  final String jenisLembaga;
  final String namaLembaga;
  final String alamatLembaga;
  final String nomorTeleponLembaga;
  final String emailLembaga;
  final String periodeKepengurusan;
  final bool isRanting;
  final String? namaRoisSyuriyah;
  final String? namaKetuaTanfidziyah;
  final bool isKomisariat;
  final String? namaKepalaMadrasah;
  final List<PembinaModel> pembina;
  final String namaKetua;
  final String alamatKetua;
  final List<WakilKetuaModel> wakilKetua;
  final String namaSekretaris;
  final String alamatSekretaris;
  final List<WakilSekretarisModel>? wakilSekre;
  final String namaBendahara;
  final String alamatBendahara;
  final String? namaWakilBend;
  final String? alamatWakilBend;
  final List<DepartemenModel> departemen;
  final List<LembagaModel> lembaga;
  final bool? hasLembagaCBP;
  final String? komandan;
  final String? alamatKomandan;
  final String? wakilKomandan;
  final String? alamatWakilKomandan;
  final bool? hasDivisi;
  final List<DivisiModel>? divisi;

  SusunanPengurusIpnuModel({
    required this.jenisLembaga,
    required this.namaLembaga,
    required this.alamatLembaga,
    required this.nomorTeleponLembaga,
    required this.emailLembaga,
    required this.periodeKepengurusan,
    required this.isRanting,
    this.namaRoisSyuriyah,
    this.namaKetuaTanfidziyah,
    required this.isKomisariat,
    this.namaKepalaMadrasah,
    required this.pembina,
    required this.namaKetua,
    required this.alamatKetua,
    required this.wakilKetua,
    required this.namaSekretaris,
    required this.alamatSekretaris,
    this.wakilSekre,
    required this.namaBendahara,
    required this.alamatBendahara,
    this.namaWakilBend,
    this.alamatWakilBend,
    required this.departemen,
    required this.lembaga,
    this.hasLembagaCBP,
    this.komandan,
    this.alamatKomandan,
    this.wakilKomandan,
    this.alamatWakilKomandan,
    this.hasDivisi,
    this.divisi,
  });

  Future<Map<String, dynamic>> toMultipartMap() async {
    final Map<String, dynamic> data = {
      "jenis_lembaga": jenisLembaga,
      "nama_lembaga": namaLembaga,
      "alamat_lembaga": alamatLembaga,
      "nomor_telepon_lembaga": nomorTeleponLembaga,
      "email_lembaga": emailLembaga,
      "periode_kepengurusan": periodeKepengurusan,
      "isRanting": isRanting,
      "isKomisariat": isKomisariat,
      "pembina": pembina.map((e) => e.toMap()).toList(),
      "nama_ketua": namaKetua,
      "alamat_ketua": alamatKetua,
      "wakil_ketua": wakilKetua.map((e) => e.toMap()).toList(),
      "nama_sekretaris": namaSekretaris,
      "alamat_sekretaris": alamatSekretaris,
      "nama_bendahara": namaBendahara,
      "alamat_bendahara": alamatBendahara,
      "departemen": departemen.map((e) => e.toMap()).toList(),
      "lembaga": lembaga.map((e) => e.toMap()).toList(),
    };

    // Optional fields for Ranting
    if (isRanting) {
      if (namaRoisSyuriyah != null) {
        data["nama_rois_syuriyah"] = namaRoisSyuriyah;
      }
      if (namaKetuaTanfidziyah != null) {
        data["nama_ketua_tanfidziyah"] = namaKetuaTanfidziyah;
      }
    }

    // Optional fields for Komisariat
    if (isKomisariat) {
      if (namaKepalaMadrasah != null) {
        data["nama_kepala_madrasah"] = namaKepalaMadrasah;
      }
    }

    // Optional wakil sekretaris
    if (wakilSekre != null && wakilSekre!.isNotEmpty) {
      data["wakil_sekre"] = wakilSekre!.map((e) => e.toMap()).toList();
    }

    // Optional wakil bendahara
    if (namaWakilBend != null) data["nama_wakil_bend"] = namaWakilBend;
    if (alamatWakilBend != null) data["alamat_wakil_bend"] = alamatWakilBend;

    // CBP - Selalu kirim flag hasLembagaCBP (true/false)
    data["hasLembagaCBP"] = hasLembagaCBP ?? false;
    if (hasLembagaCBP == true) {
      if (komandan != null) data["komandan"] = komandan;
      if (alamatKomandan != null) data["alamat_komandan"] = alamatKomandan;
      if (wakilKomandan != null) data["wakil_komandan"] = wakilKomandan;
      if (alamatWakilKomandan != null) {
        data["alamat_wakil_komandan"] = alamatWakilKomandan;
      }
    }

    // Divisi - Selalu kirim flag hasDivisi (true/false)
    data["hasDivisi"] = hasDivisi ?? false;
    if (hasDivisi == true) {
      if (divisi != null && divisi!.isNotEmpty) {
        data["divisi"] = divisi!.map((e) => e.toMap()).toList();
      }
    }

    return data;
  }
}

class PembinaModel {
  final int no;
  final String nama;

  PembinaModel({required this.no, required this.nama});

  Map<String, dynamic> toMap() {
    return {"no": no, "nama": nama};
  }
}

class WakilKetuaModel {
  final String title;
  final String nama;
  final String alamat;

  WakilKetuaModel({
    required this.title,
    required this.nama,
    required this.alamat,
  });

  Map<String, dynamic> toMap() {
    return {"title": title, "nama": nama, "alamat": alamat};
  }
}

class WakilSekretarisModel {
  final String title;
  final String nama;
  final String alamat;

  WakilSekretarisModel({
    required this.title,
    required this.nama,
    required this.alamat,
  });

  Map<String, dynamic> toMap() {
    return {"title": title, "nama": nama, "alamat": alamat};
  }
}

class DepartemenModel {
  final String nama;
  final String koordinator;
  final String alamatKoordinator;
  final List<AnggotaDepartemenModel> anggota;

  DepartemenModel({
    required this.nama,
    required this.koordinator,
    required this.alamatKoordinator,
    required this.anggota,
  });

  Map<String, dynamic> toMap() {
    return {
      "nama": nama,
      "koordinator": koordinator,
      "alamat_koordinator": alamatKoordinator,
      "anggota": anggota.map((e) => e.toMap()).toList(),
    };
  }
}

class AnggotaDepartemenModel {
  final String nama;
  final String alamat;

  AnggotaDepartemenModel({required this.nama, required this.alamat});

  Map<String, dynamic> toMap() {
    return {"nama": nama, "alamat": alamat};
  }
}

class LembagaModel {
  final String nama;
  final String direktur;
  final String alamatDirektur;
  final String sekretaris;
  final String alamatSekretaris;
  final List<AnggotaLembagaModel>? anggota;

  LembagaModel({
    required this.nama,
    required this.direktur,
    required this.alamatDirektur,
    required this.sekretaris,
    required this.alamatSekretaris,
    this.anggota,
  });

  Map<String, dynamic> toMap() {
    return {
      "nama": nama,
      "direktur": direktur,
      "alamat_direktur": alamatDirektur,
      "sekretaris": sekretaris,
      "alamat_sekretaris": alamatSekretaris,
      "anggota": anggota?.map((e) => e.toMap()).toList(),
    };
  }
}

class AnggotaLembagaModel {
  final String nama;
  final String alamat;

  AnggotaLembagaModel({required this.nama, required this.alamat});

  Map<String, dynamic> toMap() {
    return {"nama": nama, "alamat": alamat};
  }
}

class DivisiModel {
  final String nama;
  final String koordinator;
  final String alamatKoordinator;
  final List<AnggotaDivisiModel>? anggota;

  DivisiModel({
    required this.nama,
    required this.koordinator,
    required this.alamatKoordinator,
    this.anggota,
  });

  Map<String, dynamic> toMap() {
    return {
      "nama": nama,
      "koordinator": koordinator,
      "alamat_koordinator": alamatKoordinator,
      "anggota": anggota?.map((e) => e.toMap()).toList(),
    };
  }
}

class AnggotaDivisiModel {
  final String nama;
  final String alamat;

  AnggotaDivisiModel({required this.nama, required this.alamat});

  Map<String, dynamic> toMap() {
    return {"nama": nama, "alamat": alamat};
  }
}
