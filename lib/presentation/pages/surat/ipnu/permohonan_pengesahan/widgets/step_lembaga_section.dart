import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/permohonan_pengesahan/surat_permohonan_pengesahan_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';

/// Widget untuk step 1: Informasi Lembaga
class StepLembagaSection extends StatelessWidget {
  final SuratPermohonanPengesahanIpnuViewmodel viewModel;

  const StepLembagaSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Informasi Lembaga'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan informasi lengkap tentang lembaga yang mengajukan surat permohonan pengesahan.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceL),
        CustomTextField(
          controller: viewModel.formDataManager.jenisLembagaController,
          focusNode: viewModel.formDataManager.jenisLembagaFocus,
          label: 'Tingkatan Lembaga *',
          helpText: 'Contoh: Pimpinan Ranting (PR), Pimpinan Komisariat (PK)',
          hint: 'Masukkan tingkatan lembaga',
          icon: Icons.account_balance,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          validator: UiFieldValidators.required('Tingkatan lembaga'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaLembagaController,
          focusNode: viewModel.formDataManager.namaLembagaFocus,
          label: 'Nama Desa/Sekolah *',
          helpText: 'Contoh: Desa Ngepeh atau Madrasah Aliyah Nahdlatul Ulama',
          hint: 'Masukkan nama desa atau sekolah',
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          icon: Icons.location_city,
          validator: UiFieldValidators.required('Nama desa/sekolah'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.nomorTeleponLembagaController,
          focusNode: viewModel.formDataManager.nomorTeleponLembagaFocus,
          label: 'Nomor Telepon *',
          helpText: 'Contoh: 081234567890',
          hint: 'Masukkan nomor telepon',
          keyboardType: TextInputType.phone,
          validator: UiFieldValidators.required('Nomor telepon'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.emailLembagaController,
          focusNode: viewModel.formDataManager.emailLembagaFocus,
          label: 'Email *',
          helpText: 'Contoh: email@ipnu.or.id',
          hint: 'Masukkan email lembaga',
          keyboardType: TextInputType.emailAddress,
          validator: UiFieldValidators.email('Email'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.alamatLembagaController,
          focusNode: viewModel.formDataManager.alamatLembagaFocus,
          label: 'Alamat Lembaga *',
          helpText:
              'Alamat lengkap lembaga, Contoh: Jl. Raya No. 123, Desa Ngepeh',
          hint: 'Masukkan alamat lengkap lembaga',
          maxLines: 3,
          validator: UiFieldValidators.required('Alamat lembaga'),
        ),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }
}
