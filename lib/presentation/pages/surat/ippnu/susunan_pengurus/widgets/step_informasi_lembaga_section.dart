import 'package:flutter/material.dart';
import '../../../../../../core/themes/app_dimensions.dart';
import '../../../../../../core/validator/ui_field_validators.dart';
import '../../../../../../presentation/widgets/custom_text_field.dart';
import '../../../../../../presentation/widgets/section_header.dart';
import '../../../../../viewmodels/surat/ippnu/susunan_pengurus/susunan_pengurus_ippnu_viewmodel.dart';

class StepInformasiLembagaSection extends StatelessWidget {
  final SusunanPengurusIppnuViewmodel viewModel;

  const StepInformasiLembagaSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Informasi Pimpinan'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan informasi lengkap tentang pimpinan.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceL),
        CustomTextField(
          controller: viewModel.formDataManager.jenisLembagaController,
          label: 'Tingkatan Pimpinan *',
          helpText: 'Contoh: Pimpinan Ranting, Pimpinan Komisariat, dll.',
          textCapitalization: TextCapitalization.words,
          focusNode: viewModel.formDataManager.jenisLembagaFocus,
          textInputAction: TextInputAction.next,
          icon: Icons.apartment,
          hint: 'Masukkan tingkatan pimpinan',
          validator: UiFieldValidators.required('Tingkatan pimpinan'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaLembagaController,
          label: 'Nama Desa/Sekolah *',
          helpText:
              'Contoh: Desa Ngepeh, Madrasah Aliyah Nahdlatul Ulama, dll.',
          textCapitalization: TextCapitalization.words,
          focusNode: viewModel.formDataManager.namaLembagaFocus,
          textInputAction: TextInputAction.next,
          icon: Icons.location_city,
          hint: 'Masukkan nama desa/sekolah',
          validator: UiFieldValidators.required('Nama desa/sekolah'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.periodeKepengurusanController,
          label: 'Periode Kepengurusan *',
          helpText: 'Contoh: 2024-2026',
          hint: 'Masukkan periode kepengurusan',
          icon: Icons.calendar_today,
          validator: UiFieldValidators.required('Periode kepengurusan'),
          focusNode: viewModel.formDataManager.periodeKepengurusanFocus,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.alamatLembagaController,
          label: 'Alamat Pimpinan *',
          helpText: 'Contoh: Jl. Merpati No. 10, Desa Ngepeh, Kec. Mojosari',
          textCapitalization: TextCapitalization.words,
          hint: 'Masukkan alamat lengkap pimpinan',
          icon: Icons.location_on,
          validator: UiFieldValidators.required('Alamat lembaga'),
          focusNode: viewModel.formDataManager.alamatLembagaFocus,
          textInputAction: TextInputAction.next,
          maxLines: 3,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.nomorTeleponLembagaController,
          label: 'Nomor Telepon *',
          helpText: 'Contoh: 081234567890',
          hint: 'Masukkan nomor telepon lembaga',
          icon: Icons.phone,
          validator: UiFieldValidators.required('Nomor telepon lembaga'),
          focusNode: viewModel.formDataManager.nomorTeleponLembagaFocus,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.emailLembagaController,
          label: 'Email *',
          helpText: 'Contoh: email@lembaga.com',
          hint: 'Masukkan email pimpinan',
          icon: Icons.email,
          validator: UiFieldValidators.required('Email lembaga'),
          focusNode: viewModel.formDataManager.emailLembagaFocus,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }
}
