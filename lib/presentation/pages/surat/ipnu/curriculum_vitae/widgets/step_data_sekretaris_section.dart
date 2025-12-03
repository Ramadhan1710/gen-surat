import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/curriculum_vitae/curriculum_vitae_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';
import 'package:gen_surat/presentation/widgets/file_picker_widget.dart';
import 'package:get/get.dart';

class StepDataSekretarisSection extends StatelessWidget {
  final CurriculumVitaeIpnuViewmodel viewModel;

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
          focusNode: viewModel.formDataManager.namaSekretarisFocus,
          label: 'Nama Sekretaris *',
          helpText:
              'Nama lengkap sekretaris sesuai KTP, Contoh: Siti Nurhaliza',
          hint: 'Masukkan nama lengkap sekretaris',
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          icon: Icons.person,
          validator: UiFieldValidators.required('Nama Sekretaris'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.ttlSekretarisController,
          focusNode: viewModel.formDataManager.ttlSekretarisFocus,
          label: 'Tempat Tanggal Lahir *',
          helpText:
              'Tempat dan tanggal lahir sekretaris, Contoh: Mojokerto, 12 Februari 2001',
          hint: 'Masukkan tempat dan tanggal lahir sekretaris',
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          icon: Icons.cake,
          validator: UiFieldValidators.required('Tempat Tanggal Lahir'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.niaSekretarisController,
          focusNode: viewModel.formDataManager.niaSekretarisFocus,
          label: 'Nomor Induk Anggota (NIA) *',
          helpText:
              'Nomor induk anggota IPNU sekretaris, Contoh: 0987654321. Bila belum punya, isi dengan tanda strip (-)',
          hint: 'Masukkan nomor induk anggota sekretaris',
          textInputAction: TextInputAction.next,
          icon: Icons.badge,
          validator: UiFieldValidators.required('Nomor Induk Anggota (NIA)'),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.alamatSekretarisController,
          focusNode: viewModel.formDataManager.alamatSekretarisFocus,
          label: 'Alamat *',
          helpText:
              'Alamat lengkap sekretaris sesuai KTP, Contoh: Jl. Kenari No. 5, Mojokerto',
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          icon: Icons.home,
          hint: 'Masukkan alamat lengkap sekretaris',
          validator: UiFieldValidators.required('Alamat'),
          maxLines: 2,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.mottoSekretarisController,
          focusNode: viewModel.formDataManager.mottoSekretarisFocus,
          label: 'Motto Hidup *',
          helpText:
              'Motto hidup sekretaris yang memotivasi, Contoh: Disiplin adalah kunci kesuksesan',
          hint: 'Masukkan motto hidup sekretaris',
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.next,
          icon: Icons.format_quote_rounded,
          validator: UiFieldValidators.required('Motto Hidup'),
          maxLines: 2,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.nomorHpSekretarisController,
          focusNode: viewModel.formDataManager.nomorHpSekretarisFocus,
          label: 'Nomor Handphone *',
          helpText: 'Nomor handphone aktif sekretaris, Contoh: 081234567891',
          icon: Icons.phone,
          textInputAction: TextInputAction.next,
          hint: 'Masukkan nomor handphone sekretaris',
          validator: UiFieldValidators.required('Nomor Handphone'),
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.emailSekretarisController,
          focusNode: viewModel.formDataManager.emailSekretarisFocus,
          label: 'Email Sekretaris *',
          helpText: 'Email aktif sekretaris, Contoh: siti@example.com',
          hint: 'Masukkan email sekretaris',
          icon: Icons.email,
          textInputAction: TextInputAction.next,
          validator: UiFieldValidators.email('Email Sekretaris'),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        _buildFotoSection(context),
      ],
    );
  }

  Widget _buildFotoSection(BuildContext context) {
    return GetBuilder<CurriculumVitaeIpnuViewmodel>(
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
