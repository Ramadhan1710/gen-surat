import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/permohonan_pengesahan/surat_permohonan_pengesahan_ippnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';

/// Widget untuk step 1: Informasi Lembaga IPPNU
class StepLembagaSectionIppnu extends StatelessWidget {
  final SuratPermohonanPengesahanIppnuViewmodel viewModel;

  const StepLembagaSectionIppnu({super.key, required this.viewModel});

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
          helpText: 'Contoh: Pimpinan Ranting, Pimpinan Komisariat, dll.',
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
          helpText:
              'Contoh: Desa Ngepeh, Madrasah Aliyah Nahdlatul Ulama, dll.',
          hint: 'Masukkan nama desa/sekolah',
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          icon: Icons.location_city,
          validator: UiFieldValidators.required('Nama desa/sekolah'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.teleponLembagaController,
          focusNode: viewModel.formDataManager.teleponLembagaFocus,
          label: 'Nomor Telepon Lembaga *',
          helpText: 'Contoh: 08123456789',
          hint: 'Masukkan nomor telepon',
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          validator: UiFieldValidators.required('Nomor telepon lembaga'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.emailLembagaController,
          focusNode: viewModel.formDataManager.emailLembagaFocus,
          label: 'Email Lembaga *',
          helpText: 'Contoh: email@lembaga.com',
          hint: 'Masukkan email lembaga',
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
          validator: UiFieldValidators.email('Email'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.alamatLembagaController,
          focusNode: viewModel.formDataManager.alamatLembagaFocus,
          label: 'Alamat Lembaga *',
          helpText: 'Contoh: Ds. Macanan, Loceret, Nganjuk, Jawa Timur 64471',
          hint: 'Masukkan alamat lengkap lembaga',
          maxLines: 3,
          textInputAction: TextInputAction.next,
          validator: UiFieldValidators.required('Alamat lembaga'),
        ),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }
}
