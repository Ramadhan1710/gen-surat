import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/viewmodels/surat/curriculum_vitae/curriculum_vitae_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';
import 'package:gen_surat/presentation/widgets/file_picker_widget.dart';
import 'package:get/get.dart';

class StepDataBendaharaSection extends StatelessWidget {
  final CurriculumVitaeViewmodel viewModel;

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
          label: 'Nama Bendahara',
          hint: 'Masukkan nama lengkap bendahara',
          helpText: 'Nama lengkap bendahara sesuai KTP, Contoh: Rudi Hartono',
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          icon: Icons.person,
          validator: viewModel.formValidator.validateNamaBendahara,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.ttlBendaharaController,
          label: 'Tempat Tanggal Lahir',
          helpText: 'Tempat dan tanggal lahir bendahara, Contoh: Pasuruan, 8 Maret 1999',
          hint: 'Masukkan tempat dan tanggal lahir',
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          icon: Icons.cake,
          validator: viewModel.formValidator.validateTtlBendahara,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.niaBendaharaController,
          label: 'Nomor Induk Anggota (NIA)',
          hint: 'Masukkan nomor induk anggota',
          helpText: 'Nomor induk anggota IPNU bendahara, Contoh: 5678901234',
          textInputAction: TextInputAction.next,
          icon: Icons.badge,
          validator: viewModel.formValidator.validateNiaBendahara,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.alamatBendaharaController,
          label: 'Alamat',
          hint: 'Masukkan alamat lengkap bendahara',
          helpText: 'Alamat lengkap bendahara sesuai KTP',
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          icon: Icons.home,
          validator: viewModel.formValidator.validateAlamatBendahara,
          maxLines: 2,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.mottoBendaharaController,
          label: 'Motto Hidup',
          helpText: 'Motto hidup bendahara, Contoh: Kejujuran adalah investasi terbaik',
          icon: Icons.format_quote_rounded,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.sentences,
          hint: 'Masukkan motto hidup bendahara',
          validator: viewModel.formValidator.validateMottoBendahara,
          maxLines: 2,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.nomorHpBendaharaController,
          label: 'Nomor Handphone',
          helpText: 'Nomor handphone aktif bendahara, Contoh: 081234567892',
          icon: Icons.phone,
          textInputAction: TextInputAction.next,
          hint: 'Masukkan nomor handphone bendahara',
          validator: viewModel.formValidator.validateNomorHpBendahara,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.emailBendaharaController,
          label: 'Email',
          helpText: 'Alamat email aktif bendahara, Contoh: rudi@example.com',
          hint: 'Masukkan email bendahara',
          validator: viewModel.formValidator.validateEmailBendahara,
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
    return GetBuilder<CurriculumVitaeViewmodel>(
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
