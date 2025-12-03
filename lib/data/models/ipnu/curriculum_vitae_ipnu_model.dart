import 'package:dio/dio.dart';

class CurriculumVitaeIpnuModel {
  final String jenisLembaga;
  final String namaLembaga;
  final String periodeKepengurusan;
  
  // Data Ketua
  final String namaKetua;
  final String ttlKetua;
  final String niaKetua;
  final String alamatKetua;
  final String mottoKetua;
  final String nomorHpKetua;
  final String emailKetua;
  final List<OrganisasiModel>? organisasiKetua;
  final List<PendidikanModel> pendidikanKetua;
  final String? fotoKetuaPath;
  
  // Data Sekretaris
  final String namaSekretaris;
  final String ttlSekretaris;
  final String niaSekretaris;
  final String alamatSekretaris;
  final String mottoSekretaris;
  final String nomorHpSekretaris;
  final String emailSekretaris;
  final List<OrganisasiModel>? organisasiSekretaris;
  final List<PendidikanModel> pendidikanSekretaris;
  final String? fotoSekretarisPath;
  
  // Data Bendahara
  final String namaBendahara;
  final String ttlBendahara;
  final String niaBendahara;
  final String alamatBendahara;
  final String mottoBendahara;
  final String nomorHpBendahara;
  final String emailBendahara;
  final List<OrganisasiModel>? organisasiBendahara;
  final List<PendidikanModel> pendidikanBendahara;
  final String? fotoBendaharaPath;

  CurriculumVitaeIpnuModel({
    required this.jenisLembaga,
    required this.namaLembaga,
    required this.periodeKepengurusan,
    required this.namaKetua,
    required this.ttlKetua,
    required this.niaKetua,
    required this.alamatKetua,
    required this.mottoKetua,
    required this.nomorHpKetua,
    required this.emailKetua,
    required this.organisasiKetua,
    required this.pendidikanKetua,
    this.fotoKetuaPath,
    required this.namaSekretaris,
    required this.ttlSekretaris,
    required this.niaSekretaris,
    required this.alamatSekretaris,
    required this.mottoSekretaris,
    required this.nomorHpSekretaris,
    required this.emailSekretaris,
    required this.organisasiSekretaris,
    required this.pendidikanSekretaris,
    this.fotoSekretarisPath,
    required this.namaBendahara,
    required this.ttlBendahara,
    required this.niaBendahara,
    required this.alamatBendahara,
    required this.mottoBendahara,
    required this.nomorHpBendahara,
    required this.emailBendahara,
    required this.organisasiBendahara,
    required this.pendidikanBendahara,
    this.fotoBendaharaPath,
  });

  Future<Map<String, dynamic>> toMultipartMap() async {
    final Map<String, dynamic> data = {
      "jenis_lembaga": jenisLembaga,
      "nama_lembaga": namaLembaga,
      "periode_kepengurusan": periodeKepengurusan,
      
      // Data Ketua
      "nama_ketua": namaKetua,
      "ttl_ketua": ttlKetua,
      "nia_ketua": niaKetua,
      "alamat_ketua": alamatKetua,
      "motto_ketua": mottoKetua,
      "nomor_hp_ketua": nomorHpKetua,
      "email_ketua": emailKetua,
      "organisasi_ketua": organisasiKetua?.map((e) => e.toMap()).toList(),
      "pendidikan_ketua": pendidikanKetua.map((e) => e.toMap()).toList(),
      
      // Data Sekretaris
      "nama_sekretaris": namaSekretaris,
      "ttl_sekretaris": ttlSekretaris,
      "nia_sekretaris": niaSekretaris,
      "alamat_sekretaris": alamatSekretaris,
      "motto_sekretaris": mottoSekretaris,
      "nomor_hp_sekretaris": nomorHpSekretaris,
      "email_sekretaris": emailSekretaris,
      "organisasi_sekretaris": organisasiSekretaris?.map((e) => e.toMap()).toList(),
      "pendidikan_sekretaris": pendidikanSekretaris.map((e) => e.toMap()).toList(),
      
      // Data Bendahara
      "nama_bendahara": namaBendahara,
      "ttl_bendahara": ttlBendahara,
      "nia_bendahara": niaBendahara,
      "alamat_bendahara": alamatBendahara,
      "motto_bendahara": mottoBendahara,
      "nomor_hp_bendahara": nomorHpBendahara,
      "email_bendahara": emailBendahara,
      "organisasi_bendahara": organisasiBendahara?.map((e) => e.toMap()).toList(),
      "pendidikan_bendahara": pendidikanBendahara.map((e) => e.toMap()).toList(),
    };

    // Handle file uploads
    if (fotoKetuaPath != null && fotoKetuaPath!.isNotEmpty) {
      data["foto_ketua"] = await MultipartFile.fromFile(
        fotoKetuaPath!,
        filename: fotoKetuaPath!.split('/').last,
      );
    }

    if (fotoSekretarisPath != null && fotoSekretarisPath!.isNotEmpty) {
      data["foto_sekre"] = await MultipartFile.fromFile(
        fotoSekretarisPath!,
        filename: fotoSekretarisPath!.split('/').last,
      );
    }

    if (fotoBendaharaPath != null && fotoBendaharaPath!.isNotEmpty) {
      data["foto_bend"] = await MultipartFile.fromFile(
        fotoBendaharaPath!,
        filename: fotoBendaharaPath!.split('/').last,
      );
    }

    return data;
  }
}

class OrganisasiModel {
  final String nama;

  OrganisasiModel({
    required this.nama,
  });

  Map<String, dynamic> toMap() {
    return {
      "nama": nama,
    };
  }
}

class PendidikanModel {
  final String tingkatPendidikan;
  final String namaPendidikan;

  PendidikanModel({
    required this.tingkatPendidikan,
    required this.namaPendidikan,
  });

  Map<String, dynamic> toMap() {
    return {
      "tingkat_pendidikan": tingkatPendidikan,
      "nama_pendidikan": namaPendidikan,
    };
  }
}
