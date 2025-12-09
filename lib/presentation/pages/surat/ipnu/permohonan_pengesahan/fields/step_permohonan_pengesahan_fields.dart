import 'package:flutter/material.dart';
import 'package:gen_surat/core/models/form_field_model.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/permohonan_pengesahan/surat_permohonan_pengesahan_ipnu_viewmodel.dart';

class StepPermohonanPengesahanFields {
  StepPermohonanPengesahanFields._();

  // Lembaga Fields
  static List<FormFieldModel> buildLembagaField(
    SuratPermohonanPengesahanIpnuViewmodel vm,
  ) {
    final f = vm.formDataManager;

    return [
      FormFieldModel(
        controller: f.jenisLembagaController,
        focusNode: f.jenisLembagaFocus,
        label: 'Tingkatan Pimpinan *',
        hint: 'Masukkan tingkatan pimpinan',
        helpText: 'Contoh: Pimpinan Ranting (PR) atau Pimpinan Komisariat (PK)',
        icon: Icons.account_balance,
        validator: UiFieldValidators.required('Tingkatan pimpinan'),
        nextFocus: f.namaLembagaFocus,
      ),
      FormFieldModel(
        controller: f.namaLembagaController,
        focusNode: f.namaLembagaFocus,
        label: 'Nama Desa/Sekolah *',
        hint: 'Masukkan nama desa atau sekolah',
        helpText: 'Contoh: Desa Ngepeh atau Madrasah Aliyah Nahdlatul Ulama',
        icon: Icons.location_city,
        validator: UiFieldValidators.required('Nama desa/sekolah'),
        nextFocus: f.nomorTeleponLembagaFocus,
      ),
      FormFieldModel(
        controller: f.nomorTeleponLembagaController,
        focusNode: f.nomorTeleponLembagaFocus,
        label: 'Nomor Telepon *',
        hint: 'Masukkan nomor telepon',
        helpText: 'Contoh: 081234567890',
        keyboard: TextInputType.phone,
        icon: Icons.phone,
        validator: UiFieldValidators.required('Nomor telepon'),
        nextFocus: f.emailLembagaFocus,
      ),
      FormFieldModel(
        controller: f.emailLembagaController,
        focusNode: f.emailLembagaFocus,
        label: 'Email *',
        hint: 'Masukkan email pimpinan',
        helpText: 'Contoh: email@ipnu.or.id',
        keyboard: TextInputType.emailAddress,
        icon: Icons.email,
        validator: UiFieldValidators.email('Email'),
        nextFocus: f.alamatLembagaFocus,
      ),
      FormFieldModel(
        controller: f.alamatLembagaController,
        focusNode: f.alamatLembagaFocus,
        label: 'Alamat Pimpinan *',
        hint: 'Masukkan alamat lengkap pimpinan',
        helpText: 'Contoh: Jl. Raya No. 123, Desa Ngepeh',
        icon: Icons.home,
        validator: UiFieldValidators.required('Alamat lembaga'),
      ),
    ];
  }

  // Surat Fields
  static List<FormFieldModel> buildSuratField(
    SuratPermohonanPengesahanIpnuViewmodel vm,
  ) {
    final f = vm.formDataManager;

    return [
      FormFieldModel(
        controller: f.tanggalRapatController,
        focusNode: f.tanggalRapatFocus,
        label: 'Tanggal Rapat *',
        hint: 'Masukkan tanggal rapat',
        helpText: 'Tanggal pelaksanaan RAPTA (Rapat Anggota), Contoh: 15 Januari 2025',
        icon: Icons.calendar_today,
        validator: UiFieldValidators.required('Tanggal rapat'),
        isDatePicker: true,
        nextFocus: f.tanggalHijriahFocus,
      ),
      FormFieldModel(
        controller: f.tanggalHijriahController,
        focusNode: f.tanggalHijriahFocus,
        label: 'Tanggal Hijriah *',
        hint: 'Masukkan tanggal hijriah',
        helpText: 'Tanggal hijriah penetapan surat, Contoh: 15 Rajab 1446',
        icon: Icons.calendar_today,
        validator: UiFieldValidators.required('Tanggal hijriah'),
        nextFocus: f.tanggalMasehiFocus,
      ),
      FormFieldModel(
        controller: f.tanggalMasehiController,
        focusNode: f.tanggalMasehiFocus,
        label: 'Tanggal Masehi *',
        hint: 'Masukkan tanggal masehi',
        helpText: 'Tanggal masehi penetapan surat, Contoh: 15 Januari 2025',
        icon: Icons.calendar_today,
        validator: UiFieldValidators.required('Tanggal masehi'),
        isDatePicker: true,
      ),
    ];
  }

  static List<FormFieldModel> buildKepengurusanField(
    SuratPermohonanPengesahanIpnuViewmodel vm,
  ) {
    final f = vm.formDataManager;

    return [
      FormFieldModel(
        controller: f.periodeKepengurusanController,
        focusNode: f.periodeKepengurusanFocus,
        label: 'Periode Kepengurusan *',
        hint: 'Masukkan periode kepengurusan',
        helpText: 'Periode kepengurusan yang akan disahkan, Contoh: 2025-2027',
        keyboard: TextInputType.datetime,
        icon: Icons.date_range,
        validator: UiFieldValidators.required('Periode kepengurusan'),
        nextFocus: f.namaKetuaTerpilihFocus,
      ),
      FormFieldModel(
        controller: f.namaKetuaTerpilihController,
        focusNode: f.namaKetuaTerpilihFocus,
        label: 'Nama Ketua Terpilih *',
        hint: 'Masukkan nama lengkap ketua',
        helpText: 'Nama lengkap ketua terpilih, Contoh: Ahmad Fauzi',
        icon: Icons.person,
        validator: UiFieldValidators.required('Nama ketua terpilih'),
        nextFocus: f.namaSekretarisTerpilihFocus,
      ),
      FormFieldModel(
        controller: f.namaSekretarisTerpilihController,
        focusNode: f.namaSekretarisTerpilihFocus,
        label: 'Nama Sekretaris Terpilih *',
        hint: 'Masukkan nama lengkap sekretaris',
        helpText: 'Nama lengkap sekretaris terpilih, Contoh: Budi Santoso',
        icon: Icons.person_outline,
        validator: UiFieldValidators.required('Nama sekretaris terpilih'),
        nextFocus: f.jenisLembagaIndukFocus,
      ),
      FormFieldModel(
        controller: f.jenisLembagaIndukController,
        focusNode: f.jenisLembagaIndukFocus,
        label: 'Jenis Lembaga Induk *',
        hint: 'Masukkan Tingkatan Pimpinan induk',
        helpText:
            'Jenis lembaga induk, Contoh: Untuk PR : Ranting, Untuk PK : Madrasah/Sekolah, dll.',
        icon: Icons.business,
        validator: UiFieldValidators.required('Jenis lembaga induk'),
      ),
    ];
  }
}