import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/viewmodels/surat/kartu_identitas_ipnu/kartu_identitas_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/reset_confirmation_dialog.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/kartu_identitas/widgets/informasi_lembaga_section.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/kartu_identitas/widgets/upload_kartu_identitas_section.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/kartu_identitas/widgets/bottom_action_section.dart';
import 'package:get/get.dart';

class KartuIdentitasIpnuPage extends StatelessWidget {
  const KartuIdentitasIpnuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<KartuIdentitasIpnuViewmodel>();

    return Scaffold(
      appBar: _buildAppBar(context, vm),
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

  AppBar _buildAppBar(BuildContext context, KartuIdentitasIpnuViewmodel vm) {
    return AppBar(
      title: const Text('Kartu Identitas IPNU'),
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
