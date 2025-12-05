import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/berita_acara_formatur_pembentukan_pengurus_harian/berita_acara_formatur_pembentukan_pengurus_harian_ippnu_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/berita_acara_formatur_pembentukan_pengurus_harian/managers/berita_acara_formatur_pembentukan_pengurus_harian_ippnu_form_data_manager.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';
import 'package:gen_surat/presentation/widgets/cards/empty_state_container.dart';
import 'package:gen_surat/presentation/widgets/cards/numbered_item_card.dart';
import 'package:gen_surat/presentation/widgets/buttons/add_item_button.dart';
import 'package:get/get.dart';

class StepDataPelindungPembinaSection extends StatelessWidget {
  final BeritaAcaraFormaturPembentukanPengurusHarianIppnuViewmodel viewModel;

  const StepDataPelindungPembinaSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Pelindung Organisasi'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan data pelindung organisasi.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        _buildPelindungSection(context),
        const SizedBox(height: AppDimensions.spaceXL),
        const Divider(),
        const SizedBox(height: AppDimensions.spaceXL),
        const SectionHeader(title: 'Pembina Organisasi'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan data pembina organisasi.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        _buildPembinaSection(context),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }

  Widget _buildPelindungSection(BuildContext context) {
    return Obx(() {
      viewModel.pelindungVersion.value;
      final pelindungList = viewModel.formDataManager.pelindung;

      return Column(
        children: [
          if (pelindungList.isEmpty)
            const EmptyStateContainer(
              message:
                  'Belum ada pelindung. Klik "Tambah Pelindung" untuk menambahkan.',
            )
          else
            ...List.generate(
              pelindungList.length,
              (index) =>
                  _buildPelindungCard(context, index, pelindungList[index]),
            ),
          const SizedBox(height: AppDimensions.spaceM),
          AddItemButton(
            label: 'Tambah Pelindung',
            onPressed: viewModel.addPelindung,
          ),
        ],
      );
    });
  }

  Widget _buildPembinaSection(BuildContext context) {
    return Obx(() {
      viewModel.pembinaVersion.value;
      final pembinaList = viewModel.formDataManager.pembina;

      return Column(
        children: [
          if (pembinaList.isEmpty)
            const EmptyStateContainer(
              message:
                  'Belum ada pembina. Klik "Tambah Pembina" untuk menambahkan.',
            )
          else
            ...List.generate(
              pembinaList.length,
              (index) => _buildPembinaCard(context, index, pembinaList[index]),
            ),
          const SizedBox(height: AppDimensions.spaceM),
          AddItemButton(
            label: 'Tambah Pembina',
            onPressed: viewModel.addPembina,
          ),
        ],
      );
    });
  }

  Widget _buildPelindungCard(
    BuildContext context,
    int index,
    PelindungData data,
  ) {
    return NumberedItemCard(
      number: index + 1,
      label: 'Pelindung',
      onDelete: () => viewModel.removePelindung(index),
      deleteTooltip: 'Hapus pelindung',
      child: CustomTextField(
        controller: data.namaController,
        label: 'Nama Pelindung',
        helpText: 'Nama lengkap pelindung',
        textCapitalization: TextCapitalization.words,
        hint: 'Masukkan nama pelindung',
        validator: UiFieldValidators.required('Nama pelindung'),
        icon: Icons.person,
      ),
    );
  }

  Widget _buildPembinaCard(BuildContext context, int index, PembinaData data) {
    return NumberedItemCard(
      number: index + 1,
      label: 'Pembina',
      onDelete: () => viewModel.removePembina(index),
      deleteTooltip: 'Hapus pembina',
      child: CustomTextField(
        controller: data.namaController,
        label: 'Nama Pembina',
        helpText: 'Nama lengkap pembina',
        textCapitalization: TextCapitalization.words,
        hint: 'Masukkan nama pembina',
        icon: Icons.person,
        validator: UiFieldValidators.required('Nama pembina'),
      ),
    );
  }
}
