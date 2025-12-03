import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/viewmodels/surat/kartu_identitas/kartu_identitas_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/sertifikat_kaderisasi/sertifikat_kaderisasi_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/file_picker_widget.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';
import 'package:get/get.dart';

class UploadKartuIdentitasSection extends StatelessWidget {
  final SertifikatKaderisasiIpnuViewmodel viewModel;

  const UploadKartuIdentitasSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Upload Kartu Identitas'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Upload foto kartu identitas untuk ketua, sekretaris, dan bendahara. File harus berformat gambar (JPG, PNG).',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        GetBuilder<SertifikatKaderisasiIpnuViewmodel>(
          builder:
              (vm) => FilePickerWidget(
                label: 'Kartu Identitas Ketua *',
                icon: Icons.person,
                file:
                    vm.formDataManager.sertifikatKaderisasiKetuaPath != null
                        ? File(vm.formDataManager.sertifikatKaderisasiKetuaPath!)
                        : null,
                onPick: () async {
                  final file = await ImagePickerHelper.pickImage(context);
                  if (file != null) {
                    vm.setSertifikatKaderisasiKetua(file.path);
                  }
                },
                onRemove: vm.removeSertifikatKaderisasiKetua,
              ),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        GetBuilder<SertifikatKaderisasiIpnuViewmodel>(
          builder:
              (vm) => FilePickerWidget(
                label: 'Kartu Identitas Sekretaris *',
                icon: Icons.person,
                file:
                    vm.formDataManager.sertifikatKaderisasiSekretarisPath != null
                        ? File(vm.formDataManager.sertifikatKaderisasiSekretarisPath!)
                        : null,
                onPick: () async {
                  final file = await ImagePickerHelper.pickImage(context);
                  if (file != null) {
                    vm.setSertifikatKaderisasiSekretaris(file.path);
                  }
                },
                onRemove: vm.removeSertifikatKaderisasiSekretaris,
              ),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        GetBuilder<SertifikatKaderisasiIpnuViewmodel>(
          builder:
              (vm) => FilePickerWidget(
                label: 'Kartu Identitas Bendahara *',
                icon: Icons.person,
                file:
                    vm.formDataManager.sertifikatKaderisasiBendaharaPath != null
                        ? File(vm.formDataManager.sertifikatKaderisasiBendaharaPath!)
                        : null,
                onPick: () async {
                  final file = await ImagePickerHelper.pickImage(context);
                  if (file != null) {
                    vm.setSertifikatKaderisasiBendahara(file.path);
                  }
                },
                onRemove: vm.removeSertifikatKaderisasiBendahara,
              ),
        ),
      ],
    );
  }
}
