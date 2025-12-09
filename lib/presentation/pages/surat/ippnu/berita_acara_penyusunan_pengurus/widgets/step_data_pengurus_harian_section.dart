import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/berita_acara_penyusunan_pengurus/berita_acara_penyusunan_pengurus_ippnu_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/berita_acara_penyusunan_pengurus/managers/berita_acara_penyusunan_pengurus_ippnu_form_data_manager.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';
import 'package:gen_surat/presentation/widgets/cards/empty_state_container.dart';
import 'package:gen_surat/presentation/widgets/cards/numbered_item_card.dart';
import 'package:gen_surat/presentation/widgets/buttons/add_item_button.dart';
import 'package:gen_surat/presentation/widgets/file_picker_widget.dart';
import 'package:get/get.dart';

class StepDataPengurusHarianSection extends StatelessWidget {
  final BeritaAcaraPenyusunanPengurusIppnuViewmodel viewModel;

  const StepDataPengurusHarianSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Data Pengurus Harian'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan data pengurus harian yang ikut dalam penyusunan pengurus. Urutkan berdasarkan prioritas jabatan (Ketua, Sekretaris, Wakil Ketua, dll.).',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        Obx(() {
          viewModel.pengurusHarianVersion.value;
          final pengurusHarianList = viewModel.formDataManager.pengurusHarian;

          return Column(
            children: [
              if (pengurusHarianList.isEmpty)
                const EmptyStateContainer(
                  message:
                      'Belum ada pengurus harian. Klik "Tambah Pengurus" untuk menambahkan.',
                )
              else
                ...List.generate(
                  pengurusHarianList.length,
                  (index) => _buildPengurusHarianCard(
                    context,
                    index,
                    pengurusHarianList[index],
                  ),
                ),
              const SizedBox(height: AppDimensions.spaceM),
              AddItemButton(
                label: 'Tambah Pengurus Harian',
                onPressed: viewModel.addPengurusHarian,
              ),
            ],
          );
        }),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }

  Widget _buildPengurusHarianCard(
    BuildContext context,
    int index,
    PengurusHarianData data,
  ) {
    return NumberedItemCard(
      number: index + 1,
      label: 'Pengurus',
      onDelete: () => viewModel.removePengurusHarian(index),
      deleteTooltip: 'Hapus pengurus harian',
      child: Column(
        children: [
          CustomTextField(
            controller: data.jabatanController,
            icon: Icons.badge,
            label: 'Jabatan *',
            helpText: 'Contoh: Ketua, Sekretaris, Wakil Ketua I, dll.',
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            hint: 'Masukkan jabatan',
            validator: UiFieldValidators.required('Jabatan'),
          ),
          const SizedBox(height: AppDimensions.spaceM),
          CustomTextField(
            controller: data.namaController,
            label: 'Nama Lengkap *',
            helpText: 'Nama lengkap pengurus harian',
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            icon: Icons.person,
            hint: 'Masukkan nama lengkap',
            validator: UiFieldValidators.required('Nama lengkap'),
          ),
          const SizedBox(height: AppDimensions.spaceM),
          FilePickerWidget(
            label: 'Tanda Tangan (PNG/JPG) *',
            file: data.ttd,
            icon: Icons.image,
            onPick: () async {
              final file = await ImagePickerHelper.pickImage(context);
              if (file != null) {
                viewModel.setPengurusHarianTtd(index, file);
              }
            },
            onRemove:
                data.ttd != null
                    ? () => viewModel.removePengurusHarianTtd(index)
                    : null,
          ),
        ],
      ),
    );
  }
}
