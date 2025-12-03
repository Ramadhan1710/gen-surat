import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/curriculum_vitae_ipnu/curriculum_vitae_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';
import 'package:gen_surat/presentation/widgets/file_picker_widget.dart';
import 'package:get/get.dart';

class StepDataKetuaSection extends StatelessWidget {
  final CurriculumVitaeIpnuViewmodel viewModel;

  const StepDataKetuaSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Data Ketua'),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaKetuaController,
          focusNode: viewModel.formDataManager.namaKetuaFocus,
          label: 'Nama Ketua',
          hint: 'Masukkan nama lengkap ketua',
          helpText: 'Nama lengkap ketua sesuai KTP, Contoh: Ahmad Fauzi',
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          icon: Icons.person,
          validator: UiFieldValidators.required('Nama Ketua'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.ttlKetuaController,
          focusNode: viewModel.formDataManager.ttlKetuaFocus,
          label: 'Tempat Tanggal Lahir',
          helpText:
              'Tempat dan tanggal lahir ketua, Contoh: Mojosari, 10 Januari 2000',
          hint: 'Masukkan tempat dan tanggal lahir',
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          icon: Icons.cake,
          validator: UiFieldValidators.required('Tempat Tanggal Lahir'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.niaKetuaController,
          focusNode: viewModel.formDataManager.niaKetuaFocus,
          label: 'Nomor Induk Anggota (NIA)',
          hint: 'Masukkan nomor induk anggota',
          helpText: 'Nomor induk anggota IPNU ketua, Contoh: 1234567890',
          textInputAction: TextInputAction.next,
          icon: Icons.badge,
          validator: UiFieldValidators.required('Nomor Induk Anggota (NIA)'),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.alamatKetuaController,
          focusNode: viewModel.formDataManager.alamatKetuaFocus,
          label: 'Alamat',
          hint: 'Masukkan alamat lengkap ketua',
          helpText: 'Alamat lengkap ketua sesuai KTP',
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          icon: Icons.home,
          validator: UiFieldValidators.required('Alamat'),
          maxLines: 2,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.mottoKetuaController,
          focusNode: viewModel.formDataManager.mottoKetuaFocus,
          label: 'Motto Hidup',
          helpText:
              'Motto hidup ketua, Contoh: Hidup untuk memberi manfaat bagi sesama',
          icon: Icons.format_quote_rounded,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.sentences,
          hint: 'Masukkan motto hidup ketua',
          validator: UiFieldValidators.required('Motto Hidup'),
          maxLines: 2,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.nomorHpKetuaController,
          focusNode: viewModel.formDataManager.nomorHpKetuaFocus,
          label: 'Nomor Handphone',
          helpText: 'Nomor handphone aktif ketua, Contoh: 081234567890',
          icon: Icons.phone,
          textInputAction: TextInputAction.next,
          hint: 'Masukkan nomor handphone ketua',
          validator: UiFieldValidators.required('Nomor Handphone'),
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.emailKetuaController,
          focusNode: viewModel.formDataManager.emailKetuaFocus,
          label: 'Email',
          helpText: 'Alamat email aktif ketua, Contoh: ahmad@example.com',
          hint: 'Masukkan email ketua',
          validator: UiFieldValidators.email('Email'),
          icon: Icons.email,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        // CustomTextField(
        //   controller: viewModel.formDataManager.noOrganizationKetuaController,
        //   label: 'Punya Pengalaman Organisasi?',
        //   hint: 'Contoh: Ya / Tidak',
        //   validator: viewModel.formValidator.validateNoOrganizationKetua,
        // ),
        // const SizedBox(height: AppDimensions.spaceM),
        _buildFotoSection(context),
      ],
    );
  }

  Widget _buildFotoSection(BuildContext context) {
    return GetBuilder<CurriculumVitaeIpnuViewmodel>(
      builder: (vm) {
        final hasPhoto = vm.formDataManager.fotoKetuaPath != null;

        return FilePickerWidget(
          label: 'Foto Ketua *',
          icon: Icons.photo_camera,
          file: hasPhoto ? File(vm.formDataManager.fotoKetuaPath!) : null,
          onPick: () async {
            final file = await ImagePickerHelper.pickImage(context);
            if (file != null) {
              vm.setFotoKetua(file.path);
            }
          },
          onRemove: vm.removeFotoKetua,
        );
      },
    );
  }
}
