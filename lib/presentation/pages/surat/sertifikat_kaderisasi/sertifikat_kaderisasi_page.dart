import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/widgets/reset_confirmation_dialog.dart';
import 'package:gen_surat/presentation/pages/surat/sertifikat_kaderisasi/widgets/informasi_lembaga_section.dart';
import 'package:gen_surat/presentation/pages/surat/sertifikat_kaderisasi/widgets/upload_sertifikat_kaderisasi_section.dart';
import 'package:gen_surat/presentation/pages/surat/sertifikat_kaderisasi/widgets/bottom_action_section.dart';
import 'package:gen_surat/presentation/viewmodels/surat/sertifikat_kaderisasi/sertifikat_kaderisasi_viewmodel.dart';
import 'package:get/get.dart';

class SertifikatKaderisasiPage extends StatelessWidget {
  final String lembaga;
  final String endpoint;

  const SertifikatKaderisasiPage({
    super.key,
    required this.lembaga,
    required this.endpoint,
  });

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<SertifikatKaderisasiViewmodel>();

    return Scaffold(
      appBar: _buildAppBar(context, vm, lembaga),
      body: Form(
        key: vm.formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(AppDimensions.spaceM),
                children: [
                  InformasiLembagaSection(viewModel: vm),
                  const SizedBox(height: AppDimensions.spaceL),
                  UploadSertifikatKaderisasiSection(viewModel: vm),
                ],
              ),
            ),
            BottomActionSection(
              viewModel: vm,
              lembaga: lembaga,
              endpoint: endpoint,
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, SertifikatKaderisasiViewmodel vm, String lembaga) {
    return AppBar(
      title: Text('Sertifikat Kaderisasi ${lembaga.toUpperCase()}'),
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
