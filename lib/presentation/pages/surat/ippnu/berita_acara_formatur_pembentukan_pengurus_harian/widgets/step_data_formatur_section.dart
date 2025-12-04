import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/berita_acara_formatur_pembentukan_pengurus_harian/berita_acara_formatur_pembentukan_pengurus_harian_ippnu_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/berita_acara_formatur_pembentukan_pengurus_harian/managers/berita_acara_formatur_pembentukan_pengurus_harian_ippnu_form_data_manager.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';
import 'package:gen_surat/presentation/widgets/cards/empty_state_container.dart';
import 'package:gen_surat/presentation/widgets/cards/numbered_item_card.dart';
import 'package:gen_surat/presentation/widgets/buttons/add_item_button.dart';
import 'package:gen_surat/presentation/widgets/file_picker_widget.dart';
import 'package:get/get.dart';

class StepDataFormaturSection extends StatelessWidget {
  final BeritaAcaraFormaturPembentukanPengurusHarianIppnuViewmodel viewModel;

  const StepDataFormaturSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Data Formatur'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan data formatur yang bertugas membentuk pengurus harian.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        Obx(() {
          viewModel.formaturVersion.value;
          final formaturList = viewModel.formDataManager.formatur;

          return Column(
            children: [
              if (formaturList.isEmpty)
                const EmptyStateContainer(
                  message:
                      'Belum ada formatur. Klik "Tambah Formatur" untuk menambahkan.',
                )
              else
                ...List.generate(
                  formaturList.length,
                  (index) =>
                      _buildFormaturCard(context, index, formaturList[index]),
                ),
              const SizedBox(height: AppDimensions.spaceM),
              AddItemButton(
                label: 'Tambah Formatur',
                onPressed: viewModel.addFormatur,
              ),
            ],
          );
        }),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }

  Widget _buildFormaturCard(
    BuildContext context,
    int index,
    FormaturData data,
  ) {
    return NumberedItemCard(
      number: index + 1,
      label: 'Formatur',
      onDelete: () => viewModel.removeFormatur(index),
      deleteTooltip: 'Hapus formatur',
      child: Column(
        children: [
          CustomTextField(
            controller: data.namaController,
            label: 'Nama Formatur',
            helpText: 'Nama lengkap formatur',
            textCapitalization: TextCapitalization.words,
            hint: 'Masukkan nama formatur',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Nama formatur wajib diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: AppDimensions.spaceM),
          CustomTextField(
            controller: data.jabatanController,
            label: 'Jabatan',
            helpText: 'Jabatan formatur dalam kepengurusan',
            textCapitalization: TextCapitalization.words,
            hint: 'Masukkan jabatan',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Jabatan wajib diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: AppDimensions.spaceM),
          FilePickerWidget(
            label: 'Tanda Tangan Formatur (PNG/JPG)',
            file: data.ttd,
            icon: Icons.image,
            onPick: () async {
              final file = await ImagePickerHelper.pickImage(context);
              if (file != null) {
                data.ttd = file;
                viewModel.formaturVersion.value++;
              }
            },
            onRemove:
                data.ttd != null
                    ? () {
                      data.ttd = null;
                      viewModel.formaturVersion.value++;
                    }
                    : null,
          ),
        ],
      ),
    );
  }
}
