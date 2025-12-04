import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/susunan_pengurus/susunan_pengurus_ippnu_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/susunan_pengurus/managers/susunan_pengurus_ippnu_form_data_manager.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';
import 'package:gen_surat/presentation/widgets/cards/empty_state_container.dart';
import 'package:gen_surat/presentation/widgets/cards/item_card.dart';
import 'package:gen_surat/presentation/widgets/buttons/add_item_button.dart';
import 'package:get/get.dart';

class StepSekretarisWakilSection extends StatelessWidget {
  final SusunanPengurusIppnuViewmodel viewModel;

  const StepSekretarisWakilSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        // ========== SEKRETARIS SECTION ==========
        const SectionHeader(title: 'Sekretaris'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan data sekretaris organisasi.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceM),

        CustomTextField(
          controller: viewModel.formDataManager.namaSekretarisController,
          label: 'Nama Sekretaris *',
          helpText: 'Nama lengkap sekretaris',
          textCapitalization: TextCapitalization.words,
          focusNode: viewModel.formDataManager.namaSekretarisFocus,
          textInputAction: TextInputAction.next,
          hint: 'Masukkan nama sekretaris',
          validator: UiFieldValidators.required('Nama sekretaris'),
        ),

        const SizedBox(height: AppDimensions.spaceXL),
        const Divider(),
        const SizedBox(height: AppDimensions.spaceXL),

        // ========== WAKIL SEKRETARIS SECTION ==========
        const SectionHeader(title: 'Wakil Sekretaris'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan data wakil sekretaris organisasi (opsional).',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceM),

        Obx(() {
          // Trigger rebuild
          viewModel.wakilSekreVersion.value;
          final wakilSekreList = viewModel.formDataManager.wakilSekre;

          return Column(
            children: [
              if (wakilSekreList.isEmpty)
                const EmptyStateContainer(
                  message:
                      'Belum ada wakil sekretaris. Klik "Tambah Wakil Sekretaris" untuk menambahkan.',
                )
              else
                ...List.generate(
                  wakilSekreList.length,
                  (index) => _buildWakilSekretarisCard(
                    context,
                    index,
                    wakilSekreList[index],
                  ),
                ),
              const SizedBox(height: AppDimensions.spaceM),
              AddItemButton(
                label: 'Tambah Wakil Sekretaris',
                onPressed: viewModel.addWakilSekretaris,
              ),
            ],
          );
        }),

        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }

  Widget _buildWakilSekretarisCard(
    BuildContext context,
    int index,
    WakilSekretarisData data,
  ) {
    return ItemCard(
      title: 'Wakil Sekretaris ${index + 1}',
      onDelete: () => viewModel.removeWakilSekretaris(index),
      deleteTooltip: 'Hapus wakil sekretaris',
      child: Column(
        children: [
          CustomTextField(
            controller: data.titleController,
            label: 'Jabatan',
            helpText: 'Contoh: Wakil Sekretaris I, Wakil Sekretaris II',
            textCapitalization: TextCapitalization.words,
            hint: 'Masukkan jabatan',
          ),
          const SizedBox(height: AppDimensions.spaceM),
          CustomTextField(
            controller: data.namaController,
            label: 'Nama',
            helpText: 'Nama lengkap wakil sekretaris',
            textCapitalization: TextCapitalization.words,
            hint: 'Masukkan nama',
          ),
        ],
      ),
    );
  }
}
