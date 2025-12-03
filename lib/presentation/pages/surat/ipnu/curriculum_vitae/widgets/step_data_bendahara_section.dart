import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/curriculum_vitae/curriculum_vitae_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';
import 'package:gen_surat/presentation/widgets/file_picker_widget.dart';
import 'package:get/get.dart';

class StepDataBendaharaSection extends StatelessWidget {
  final CurriculumVitaeIpnuViewmodel viewModel;

  const StepDataBendaharaSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Data Bendahara'),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaBendaharaController,
          focusNode: viewModel.formDataManager.namaBendaharaFocus,
          label: 'Nama Bendahara',
          hint: 'Masukkan nama lengkap bendahara',
          helpText: 'Nama lengkap bendahara sesuai KTP, Contoh: Rudi Hartono',
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          icon: Icons.person,
          validator: UiFieldValidators.required('Nama Bendahara'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.ttlBendaharaController,
          focusNode: viewModel.formDataManager.ttlBendaharaFocus,
          label: 'Tempat Tanggal Lahir',
          helpText:
              'Tempat dan tanggal lahir bendahara, Contoh: Pasuruan, 8 Maret 1999',
          hint: 'Masukkan tempat dan tanggal lahir',
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          icon: Icons.cake,
          validator: UiFieldValidators.required('Tempat Tanggal Lahir'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.niaBendaharaController,
          focusNode: viewModel.formDataManager.niaBendaharaFocus,
          label: 'Nomor Induk Anggota (NIA)',
          hint: 'Masukkan nomor induk anggota',
          helpText: 'Nomor induk anggota IPNU bendahara, Contoh: 5678901234',
          textInputAction: TextInputAction.next,
          icon: Icons.badge,
          validator: UiFieldValidators.required('Nomor Induk Anggota (NIA)'),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.alamatBendaharaController,
          focusNode: viewModel.formDataManager.alamatBendaharaFocus,
          label: 'Alamat',
          hint: 'Masukkan alamat lengkap bendahara',
          helpText: 'Alamat lengkap bendahara sesuai KTP',
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          icon: Icons.home,
          validator: UiFieldValidators.required('Alamat'),
          maxLines: 2,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.mottoBendaharaController,
          focusNode: viewModel.formDataManager.mottoBendaharaFocus,
          label: 'Motto Hidup',
          helpText:
              'Motto hidup bendahara, Contoh: Kejujuran adalah investasi terbaik',
          icon: Icons.format_quote_rounded,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.sentences,
          hint: 'Masukkan motto hidup bendahara',
          validator: UiFieldValidators.required('Motto Hidup'),
          maxLines: 2,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.nomorHpBendaharaController,
          focusNode: viewModel.formDataManager.nomorHpBendaharaFocus,
          label: 'Nomor Handphone',
          helpText: 'Nomor handphone aktif bendahara, Contoh: 081234567892',
          icon: Icons.phone,
          textInputAction: TextInputAction.next,
          hint: 'Masukkan nomor handphone bendahara',
          validator: UiFieldValidators.required('Nomor Handphone'),
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.emailBendaharaController,
          focusNode: viewModel.formDataManager.emailBendaharaFocus,
          label: 'Email',
          helpText: 'Alamat email aktif bendahara, Contoh: rudi@example.com',
          hint: 'Masukkan email bendahara',
          validator: UiFieldValidators.email('Email'),
          icon: Icons.email,
          textInputAction: TextInputAction.next,
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
        final hasPhoto = vm.formDataManager.fotoBendaharaPath != null;

        return FilePickerWidget(
          label: 'Foto Bendahara *',
          icon: Icons.photo_camera,
          file: hasPhoto ? File(vm.formDataManager.fotoBendaharaPath!) : null,
          onPick: () async {
            final file = await ImagePickerHelper.pickImage(context);
            if (file != null) {
              vm.setFotoBendahara(file.path);
            }
          },
          onRemove: vm.removeFotoBendahara,
        );
      },
    );
  }
}
