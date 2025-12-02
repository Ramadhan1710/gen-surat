import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/viewmodels/surat/permohonan_pengesahan/surat_permohonan_pengesahan_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';

/// Widget untuk step 1: Informasi Lembaga
class StepLembagaSection extends StatelessWidget {
  final SuratPermohonanPengesahanIpnuViewmodel viewModel;

  const StepLembagaSection({
    super.key,
    required this.viewModel,
  });

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
          label: 'Jenis Lembaga *',
          helpText: 'Jenis lembaga yang mengajukan surat, Contoh: Pimpinan Ranting',
          hint: 'Masukkan jenis lembaga',
          validator: _requiredValidator('Jenis lembaga'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaLembagaController,
          label: 'Nama Desa/Sekolah *',
          helpText: 'Nama lengkap desa atau sekolah, Contoh: Desa Ngepeh atau Madrasah Aliyah Nahdlatul Ulama',
          hint: 'Masukkan nama desa atau sekolah',
          validator: _requiredValidator('Nama lembaga'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.nomorTeleponLembagaController,
          label: 'Nomor Telepon *',
          helpText: 'Nomor telepon lembaga (10-13 digit), Contoh: 081234567890',
          hint: 'Masukkan nomor telepon',
          keyboardType: TextInputType.phone,
          validator: _phoneValidator,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.emailLembagaController,
          label: 'Email *',
          helpText: 'Email lembaga, Contoh: email@ipnu.or.id',
          hint: 'Masukkan email lembaga',
          keyboardType: TextInputType.emailAddress,
          validator: _emailValidator,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.alamatLembagaController,
          label: 'Alamat Lembaga *',
          helpText: 'Alamat lengkap lembaga, Contoh: Jl. Raya No. 123, Desa Ngepeh',
          hint: 'Masukkan alamat lengkap lembaga',
          maxLines: 3,
          validator: _requiredValidator('Alamat lembaga'),
        ),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }

  String? Function(String?) _requiredValidator(String fieldName) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return '$fieldName wajib diisi';
      }
      return null;
    };
  }

  String? _phoneValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nomor telepon wajib diisi';
    }
    if (!RegExp(r'^[0-9]{10,13}$').hasMatch(value.trim())) {
      return 'Nomor telepon tidak valid (10-13 digit)';
    }
    return null;
  }

  String? _emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email wajib diisi';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
      return 'Format email tidak valid';
    }
    return null;
  }
}
