import 'package:flutter/material.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/susunan_pengurus/managers/susunan_pengurus_ippnu_form_data_manager.dart';
import '../../../../../../core/themes/app_dimensions.dart';
import '../../../../../../presentation/widgets/custom_text_field.dart';
import '../../../../../../presentation/widgets/section_header.dart';
import '../../../../../../presentation/widgets/cards/empty_state_container.dart';
import '../../../../../../presentation/widgets/cards/numbered_item_card.dart';
import '../../../../../../presentation/widgets/buttons/add_item_button.dart';
import '../../../../../viewmodels/surat/ippnu/susunan_pengurus/susunan_pengurus_ippnu_viewmodel.dart';
import 'package:get/get.dart';

class StepPelindungPembinaSection extends StatelessWidget {
  final SusunanPengurusIppnuViewmodel viewModel;

  const StepPelindungPembinaSection({super.key, required this.viewModel});

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

        // Pelindung
        _buildPelindungSection(context),
        const SizedBox(height: AppDimensions.spaceXL),
        // ========== PEMBINA SECTION ==========
        const SectionHeader(title: 'Pembina Organisasi'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan data pembina organisasi.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        // Pembina
        _buildPembinaSection(context),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }

  Widget _buildPelindungSection(BuildContext context) {
    return Obx(() {
      viewModel.pelindungVersion.value;
      final pelindungList =
          viewModel.formDataManager.pelindung; // Trigger rebuild

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
      // Trigger rebuild
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
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Nama pelindung wajib diisi';
          }
          return null;
        },
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
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Nama pembina wajib diisi';
          }
          return null;
        },
      ),
    );
  }
}
