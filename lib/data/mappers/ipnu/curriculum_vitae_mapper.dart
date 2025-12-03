import 'package:gen_surat/data/models/ipnu/curriculum_vitae_model.dart';
import 'package:gen_surat/domain/entities/ipnu/curriculum_vitae_entity.dart';

class CurriculumVitaeMapper {
  static CurriculumVitaeEntity toEntity(CurriculumVitaeModel model) {
    return CurriculumVitaeEntity(
      jenisLembaga: model.jenisLembaga,
      namaLembaga: model.namaLembaga,
      periodeKepengurusan: model.periodeKepengurusan,
      namaKetua: model.namaKetua,
      ttlKetua: model.ttlKetua,
      niaKetua: model.niaKetua,
      alamatKetua: model.alamatKetua,
      mottoKetua: model.mottoKetua,
      nomorHpKetua: model.nomorHpKetua,
      emailKetua: model.emailKetua,
      organisasiKetua:
          model.organisasiKetua
              ?.map((org) => OrganisasiEntity(nama: org.nama))
              .toList(),
      pendidikanKetua:
          model.pendidikanKetua
              .map(
                (pend) => PendidikanEntity(
                  tingkatPendidikan: pend.tingkatPendidikan,
                  namaPendidikan: pend.namaPendidikan,
                ),
              )
              .toList(),
      fotoKetuaPath: model.fotoKetuaPath,
      namaSekretaris: model.namaSekretaris,
      ttlSekretaris: model.ttlSekretaris,
      niaSekretaris: model.niaSekretaris,
      alamatSekretaris: model.alamatSekretaris,
      mottoSekretaris: model.mottoSekretaris,
      nomorHpSekretaris: model.nomorHpSekretaris,
      emailSekretaris: model.emailSekretaris,
      organisasiSekretaris:
          model.organisasiSekretaris
              ?.map((org) => OrganisasiEntity(nama: org.nama))
              .toList(),
      pendidikanSekretaris:
          model.pendidikanSekretaris
              .map(
                (pend) => PendidikanEntity(
                  tingkatPendidikan: pend.tingkatPendidikan,
                  namaPendidikan: pend.namaPendidikan,
                ),
              )
              .toList(),
      fotoSekretarisPath: model.fotoSekretarisPath,
      namaBendahara: model.namaBendahara,
      ttlBendahara: model.ttlBendahara,
      niaBendahara: model.niaBendahara,
      alamatBendahara: model.alamatBendahara,
      mottoBendahara: model.mottoBendahara,
      nomorHpBendahara: model.nomorHpBendahara,
      emailBendahara: model.emailBendahara,
      organisasiBendahara:
          model.organisasiBendahara
              ?.map((org) => OrganisasiEntity(nama: org.nama))
              .toList(),
      pendidikanBendahara:
          model.pendidikanBendahara
              .map(
                (pend) => PendidikanEntity(
                  tingkatPendidikan: pend.tingkatPendidikan,
                  namaPendidikan: pend.namaPendidikan,
                ),
              )
              .toList(),
      fotoBendaharaPath: model.fotoBendaharaPath,
    );
  }

  static CurriculumVitaeModel toModel(CurriculumVitaeEntity entity) {
    return CurriculumVitaeModel(
      jenisLembaga: entity.jenisLembaga,
      namaLembaga: entity.namaLembaga,
      periodeKepengurusan: entity.periodeKepengurusan,
      namaKetua: entity.namaKetua,
      ttlKetua: entity.ttlKetua,
      niaKetua: entity.niaKetua,
      alamatKetua: entity.alamatKetua,
      mottoKetua: entity.mottoKetua,
      nomorHpKetua: entity.nomorHpKetua,
      emailKetua: entity.emailKetua,
      organisasiKetua:
          entity.organisasiKetua
              ?.map((org) => OrganisasiModel(nama: org.nama))
              .toList(),
      pendidikanKetua:
          entity.pendidikanKetua
              .map(
                (pend) => PendidikanModel(
                  tingkatPendidikan: pend.tingkatPendidikan,
                  namaPendidikan: pend.namaPendidikan,
                ),
              )
              .toList(),
      fotoKetuaPath: entity.fotoKetuaPath,
      namaSekretaris: entity.namaSekretaris,
      ttlSekretaris: entity.ttlSekretaris,
      niaSekretaris: entity.niaSekretaris,
      alamatSekretaris: entity.alamatSekretaris,
      mottoSekretaris: entity.mottoSekretaris,
      nomorHpSekretaris: entity.nomorHpSekretaris,
      emailSekretaris: entity.emailSekretaris,
      organisasiSekretaris:
          entity.organisasiSekretaris
              ?.map((org) => OrganisasiModel(nama: org.nama))
              .toList(),
      pendidikanSekretaris:
          entity.pendidikanSekretaris
              .map(
                (pend) => PendidikanModel(
                  tingkatPendidikan: pend.tingkatPendidikan,
                  namaPendidikan: pend.namaPendidikan,
                ),
              )
              .toList(),
      fotoSekretarisPath: entity.fotoSekretarisPath,
      namaBendahara: entity.namaBendahara,
      ttlBendahara: entity.ttlBendahara,
      niaBendahara: entity.niaBendahara,
      alamatBendahara: entity.alamatBendahara,
      mottoBendahara: entity.mottoBendahara,
      nomorHpBendahara: entity.nomorHpBendahara,
      emailBendahara: entity.emailBendahara,
      organisasiBendahara:
          entity.organisasiBendahara
              ?.map((org) => OrganisasiModel(nama: org.nama))
              .toList(),
      pendidikanBendahara:
          entity.pendidikanBendahara
              .map(
                (pend) => PendidikanModel(
                  tingkatPendidikan: pend.tingkatPendidikan,
                  namaPendidikan: pend.namaPendidikan,
                ),
              )
              .toList(),
      fotoBendaharaPath: entity.fotoBendaharaPath,
    );
  }
}
