import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/viewmodels/surat/curriculum_vitae/curriculum_vitae_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';
import 'package:gen_surat/presentation/widgets/file_picker_widget.dart';
import 'package:get/get.dart';

class StepDataSekretarisSection extends StatelessWidget {
  final CurriculumVitaeViewmodel viewModel;

  const StepDataSekretarisSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Data Sekretaris'),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaSekretarisController,
          label: 'Nama Sekretaris *',
          helpText: 'Nama lengkap sekretaris sesuai KTP, Contoh: Siti Nurhaliza',
          hint: 'Masukkan nama lengkap sekretaris',
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          icon: Icons.person,
          validator: viewModel.formValidator.validateNamaSekretaris,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.ttlSekretarisController,
          label: 'Tempat Tanggal Lahir *',
          helpText: 'Tempat dan tanggal lahir sekretaris, Contoh: Mojokerto, 12 Februari 2001',
          hint: 'Masukkan tempat dan tanggal lahir sekretaris',
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          icon: Icons.cake,
          validator: viewModel.formValidator.validateTtlSekretaris,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.niaSekretarisController,
          label: 'Nomor Induk Anggota (NIA) *',
          helpText: 'Nomor induk anggota IPNU sekretaris, Contoh: 0987654321. Bila belum punya, isi dengan tanda strip (-)',
          hint: 'Masukkan nomor induk anggota sekretaris',
          textInputAction: TextInputAction.next,
          icon: Icons.badge,
          validator: viewModel.formValidator.validateNiaSekretaris,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.alamatSekretarisController,
          label: 'Alamat *',
          helpText: 'Alamat lengkap sekretaris sesuai KTP, Contoh: Jl. Kenari No. 5, Mojokerto',
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          icon: Icons.home,
          hint: 'Masukkan alamat lengkap sekretaris',
          validator: viewModel.formValidator.validateAlamatSekretaris,
          maxLines: 2,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.mottoSekretarisController,
          label: 'Motto Hidup *',
          helpText: 'Motto hidup sekretaris yang memotivasi, Contoh: Disiplin adalah kunci kesuksesan',
          hint: 'Masukkan motto hidup sekretaris',
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.next,
          icon: Icons.format_quote_rounded,
          validator: viewModel.formValidator.validateMottoSekretaris,
          maxLines: 2,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.nomorHpSekretarisController,
          label: 'Nomor Handphone *',
          helpText: 'Nomor handphone aktif sekretaris, Contoh: 081234567891',
          icon: Icons.phone,
          textInputAction: TextInputAction.next,
          hint: 'Masukkan nomor handphone sekretaris',
          validator: viewModel.formValidator.validateNomorHpSekretaris,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.emailSekretarisController,
          label: 'Email Sekretaris *',
          helpText: 'Email aktif sekretaris, Contoh: siti@example.com',
          hint: 'Masukkan email sekretaris',
          icon: Icons.email,
          textInputAction: TextInputAction.next,
          validator: viewModel.formValidator.validateEmailSekretaris,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        _buildFotoSection(context),
      ],
    );
  }

  Widget _buildFotoSection(BuildContext context) {
    return GetBuilder<CurriculumVitaeViewmodel>(
      builder: (vm) {
        final hasPhoto = vm.formDataManager.fotoSekretarisPath != null;

        return FilePickerWidget(
          label: 'Foto Sekretaris *',
          icon: Icons.photo_camera,
          file: hasPhoto ? File(vm.formDataManager.fotoSekretarisPath!) : null,
          onPick: () async {
            final file = await ImagePickerHelper.pickImage(context);
            if (file != null) {
              vm.setFotoSekretaris(file.path);
            }
          },
          onRemove: vm.removeFotoSekretaris,
        );
      },
    );
  }
}
