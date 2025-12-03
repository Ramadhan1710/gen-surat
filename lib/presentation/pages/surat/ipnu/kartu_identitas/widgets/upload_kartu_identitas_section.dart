import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/viewmodels/surat/kartu_identitas/kartu_identitas_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/file_picker_widget.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';
import 'package:get/get.dart';

class UploadKartuIdentitasSection extends StatelessWidget {
  final KartuIdentitasIpnuViewmodel viewModel;

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
        GetBuilder<KartuIdentitasIpnuViewmodel>(
          builder:
              (vm) => FilePickerWidget(
                label: 'Kartu Identitas Ketua *',
                icon: Icons.person,
                file:
                    vm.formDataManager.kartuIdentitasKetuaPath != null
                        ? File(vm.formDataManager.kartuIdentitasKetuaPath!)
                        : null,
                onPick: () async {
                  final file = await ImagePickerHelper.pickImage(context);
                  if (file != null) {
                    vm.setKartuIdentitasKetua(file.path);
                  }
                },
                onRemove: vm.removeKartuIdentitasKetua,
              ),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        GetBuilder<KartuIdentitasIpnuViewmodel>(
          builder:
              (vm) => FilePickerWidget(
                label: 'Kartu Identitas Sekretaris *',
                icon: Icons.person,
                file:
                    vm.formDataManager.kartuIdentitasSekretarisPath != null
                        ? File(vm.formDataManager.kartuIdentitasSekretarisPath!)
                        : null,
                onPick: () async {
                  final file = await ImagePickerHelper.pickImage(context);
                  if (file != null) {
                    vm.setKartuIdentitasSekretaris(file.path);
                  }
                },
                onRemove: vm.removeKartuIdentitasSekretaris,
              ),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        GetBuilder<KartuIdentitasIpnuViewmodel>(
          builder:
              (vm) => FilePickerWidget(
                label: 'Kartu Identitas Bendahara *',
                icon: Icons.person,
                file:
                    vm.formDataManager.kartuIdentitasBendaharaPath != null
                        ? File(vm.formDataManager.kartuIdentitasBendaharaPath!)
                        : null,
                onPick: () async {
                  final file = await ImagePickerHelper.pickImage(context);
                  if (file != null) {
                    vm.setKartuIdentitasBendahara(file.path);
                  }
                },
                onRemove: vm.removeKartuIdentitasBendahara,
              ),
        ),
      ],
    );
  }
}
