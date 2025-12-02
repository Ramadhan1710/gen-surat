import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/widgets/reset_confirmation_dialog.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/sertifikat_kaderisasi/widgets/informasi_lembaga_section.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/sertifikat_kaderisasi/widgets/upload_sertifikat_kaderisasi_section.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/sertifikat_kaderisasi/widgets/bottom_action_section.dart';
import 'package:gen_surat/presentation/viewmodels/surat/sertifikat_kaderisasi/sertifikat_kaderisasi_viewmodel.dart';
import 'package:get/get.dart';

class SertifikatKaderisasiPage extends StatelessWidget {
  const SertifikatKaderisasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<SertifikatKaderisasiViewmodel>();

    return Scaffold(
      appBar: _buildAppBar(context, vm),
      body: Form(
        key: vm.formDataManager.formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(AppDimensions.spaceM),
                children: [
                  InformasiLembagaSection(viewModel: vm),
                  const SizedBox(height: AppDimensions.spaceL),
                  UploadKartuIdentitasSection(viewModel: vm),
                ],
              ),
            ),
            BottomActionSection(viewModel: vm),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, SertifikatKaderisasiViewmodel vm) {
    return AppBar(
      title: const Text('Sertifikat Kaderisasi IPNU'),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => ResetConfirmationDialog.show(context, vm.resetForm),
          tooltip: 'Reset Form',
        ),
      ],
    );
  }
}
