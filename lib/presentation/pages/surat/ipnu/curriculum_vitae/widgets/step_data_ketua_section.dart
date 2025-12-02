import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/viewmodels/surat/curriculum_vitae/curriculum_vitae_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';
import 'package:gen_surat/presentation/widgets/file_picker_widget.dart';
import 'package:get/get.dart';

class StepDataKetuaSection extends StatelessWidget {
  final CurriculumVitaeViewmodel viewModel;

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
          label: 'Nama Ketua',
          hint: 'Masukkan nama lengkap ketua',
          helpText: 'Nama lengkap ketua sesuai KTP, Contoh: Ahmad Fauzi',
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          icon: Icons.person,
          validator: viewModel.formValidator.validateNamaKetua,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.ttlKetuaController,
          label: 'Tempat Tanggal Lahir',
          helpText: 'Tempat dan tanggal lahir ketua, Contoh: Mojosari, 10 Januari 2000',
          hint: 'Masukkan tempat dan tanggal lahir',
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          icon: Icons.cake,
          validator: viewModel.formValidator.validateTtlKetua,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.niaKetuaController,
          label: 'Nomor Induk Anggota (NIA)',
          hint: 'Masukkan nomor induk anggota',
          helpText: 'Nomor induk anggota IPNU ketua, Contoh: 1234567890',
          textInputAction: TextInputAction.next,
          icon: Icons.badge,
          validator: viewModel.formValidator.validateNiaKetua,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.alamatKetuaController,
          label: 'Alamat',
          hint: 'Masukkan alamat lengkap ketua',
          helpText: 'Alamat lengkap ketua sesuai KTP',
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          icon: Icons.home,
          validator: viewModel.formValidator.validateAlamatKetua,
          maxLines: 2,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.mottoKetuaController,
          label: 'Motto Hidup',
          helpText: 'Motto hidup ketua, Contoh: Hidup untuk memberi manfaat bagi sesama',
          icon: Icons.format_quote_rounded,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.sentences,
          hint: 'Masukkan motto hidup ketua',
          validator: viewModel.formValidator.validateMottoKetua,
          maxLines: 2,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.nomorHpKetuaController,
          label: 'Nomor Handphone',
          helpText: 'Nomor handphone aktif ketua, Contoh: 081234567890',
          icon: Icons.phone,
          textInputAction: TextInputAction.next,
          hint: 'Masukkan nomor handphone ketua',
          validator: viewModel.formValidator.validateNomorHpKetua,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.emailKetuaController,
          label: 'Email',
          helpText: 'Alamat email aktif ketua, Contoh: ahmad@example.com',
          hint: 'Masukkan email ketua',
          validator: viewModel.formValidator.validateEmailKetua,
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
    return GetBuilder<CurriculumVitaeViewmodel>(
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
