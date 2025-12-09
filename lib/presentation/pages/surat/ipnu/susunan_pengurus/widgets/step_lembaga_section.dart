import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/susunan_pengurus/susunan_pengurus_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';

class StepLembagaSection extends StatelessWidget {
  final SusunanPengurusIpnuViewmodel viewModel;

  const StepLembagaSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informasi Pimpinan',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppDimensions.spaceM),

          CustomTextField(
            controller: viewModel.formDataManager.jenisLembagaController,
            label: 'Tingkatan Pimpinan *',
            helpText:
                'Tingkatan Pimpinan pengurus, Contoh: Pimpinan Ranting atau Pimpinan Komisariat',
            textCapitalization: TextCapitalization.words,
            focusNode: viewModel.formDataManager.jenisLembagaFocus,
            textInputAction: TextInputAction.next,
            hint: 'Masukkan tingkatan pimpinan',
            validator: UiFieldValidators.required('Tingkatan pimpinan'),
          ),
          const SizedBox(height: AppDimensions.spaceM),

          CustomTextField(
            controller: viewModel.formDataManager.namaLembagaController,
            label: 'Nama Desa/Sekolah *',
            helpText:
                'Nama lengkap desa atau sekolah, Contoh: Desa Ngepeh atau Madrasah Aliyah Nahdlatul Ulama',
            textCapitalization: TextCapitalization.words,
            focusNode: viewModel.formDataManager.namaLembagaFocus,
            textInputAction: TextInputAction.next,
            hint: 'Masukkan nama desa/sekolah',
            validator: UiFieldValidators.required('Nama desa/sekolah'),
          ),
          const SizedBox(height: AppDimensions.spaceM),

          CustomTextField(
            controller: viewModel.formDataManager.alamatLembagaController,
            label: 'Alamat Pimpinan *',
            helpText:
                'Alamat lengkap pimpinan, Contoh: Jl. Raya Ngepeh No. 10, Desa Ngepeh',
            textCapitalization: TextCapitalization.words,
            focusNode: viewModel.formDataManager.alamatLembagaFocus,
            textInputAction: TextInputAction.next,
            hint: 'Masukkan alamat lengkap pimpinan',
            maxLines: 2,
            validator: UiFieldValidators.required('Alamat lembaga'),
          ),
          const SizedBox(height: AppDimensions.spaceM),

          CustomTextField(
            controller: viewModel.formDataManager.nomorTeleponLembagaController,
            label: 'Nomor Telepon *',
            helpText:
                'Nomor telepon atau WhatsApp pimpinan, Contoh: 081234567890',
            focusNode: viewModel.formDataManager.nomorTeleponLembagaFocus,
            textInputAction: TextInputAction.next,
            hint: 'Contoh: 081234567890',
            keyboardType: TextInputType.phone,
            validator: UiFieldValidators.required('Nomor telepon'),
          ),
          const SizedBox(height: AppDimensions.spaceM),

          CustomTextField(
            controller: viewModel.formDataManager.emailLembagaController,
            label: 'Email *',
            helpText: 'Alamat email pimpinan, Contoh: email@lembaga.com',
            focusNode: viewModel.formDataManager.emailLembagaFocus,
            textInputAction: TextInputAction.next,
            hint: 'Masukkan email pimpinan',
            keyboardType: TextInputType.emailAddress,
            validator: UiFieldValidators.email('Email'),
          ),
          const SizedBox(height: AppDimensions.spaceM),

          CustomTextField(
            controller: viewModel.formDataManager.periodeKepengurusanController,
            label: 'Periode Kepengurusan *',
            helpText: 'Periode kepengurusan pengurus harian, Contoh: 2024-2026',
            focusNode: viewModel.formDataManager.periodeKepengurusanFocus,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            hint: 'Masukkan periode kepengurusan',
            validator: UiFieldValidators.required('Periode kepengurusan'),
          ),
          const SizedBox(height: AppDimensions.spaceXL),
        ],
      ),
    );
  }
}
