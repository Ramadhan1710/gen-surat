import 'package:flutter/material.dart';
import '../../../../../../core/themes/app_dimensions.dart';
import '../../../../../../core/validator/ui_field_validators.dart';
import '../../../../../../presentation/widgets/custom_text_field.dart';
import '../../../../../../presentation/widgets/section_header.dart';
import '../../../../../../presentation/widgets/dynamic_list_card.dart';
import '../../../../../viewmodels/surat/ippnu/susunan_pengurus/susunan_pengurus_ippnu_viewmodel.dart';
import 'package:get/get.dart';

class StepPengurusHarianSection extends StatelessWidget {
  final SusunanPengurusIppnuViewmodel viewModel;

  const StepPengurusHarianSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Pengurus Harian'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan data pengurus harian yang terpilih.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceL),

        // Ketua
        CustomTextField(
          controller: viewModel.formDataManager.namaKetuaController,
          label: 'Nama Ketua Terpilih *',
          helpText: 'Contoh: Siti Fatimah',
          textCapitalization: TextCapitalization.words,
          focusNode: viewModel.formDataManager.namaKetuaFocus,
          textInputAction: TextInputAction.next,
          hint: 'Masukkan nama ketua',
          validator: UiFieldValidators.required('Nama ketua'),
        ),
        const SizedBox(height: AppDimensions.spaceM),

        // Wakil Ketua
        _buildWakilKetuaSection(context),
        const SizedBox(height: AppDimensions.spaceM),

        // Sekretaris
        CustomTextField(
          controller: viewModel.formDataManager.namaSekretarisController,
          label: 'Nama Sekretaris Terpilih *',
          helpText: 'Contoh: Lina Marlina',
          textCapitalization: TextCapitalization.words,
          focusNode: viewModel.formDataManager.namaSekretarisFocus,
          textInputAction: TextInputAction.next,
          hint: 'Masukkan nama sekretaris',
          validator: UiFieldValidators.required('Nama sekretaris'),
        ),
        const SizedBox(height: AppDimensions.spaceM),

        // Wakil Sekretaris
        _buildWakilSekretarisSection(context),
        const SizedBox(height: AppDimensions.spaceM),

        // Bendahara
        CustomTextField(
          controller: viewModel.formDataManager.namaBendaharaController,
          label: 'Nama Bendahara Terpilih *',
          helpText: 'Contoh: Fadilatun Nafia',
          textCapitalization: TextCapitalization.words,
          focusNode: viewModel.formDataManager.namaBendaharaFocus,
          textInputAction: TextInputAction.next,
          hint: 'Masukkan nama bendahara',
          validator: UiFieldValidators.required('Nama bendahara'),
        ),
        const SizedBox(height: AppDimensions.spaceM),

        // Wakil Bendahara
        CustomTextField(
          controller: viewModel.formDataManager.namaWakilBendController,
          label: 'Nama Wakil Bendahara Terpilih',
          helpText: 'Opsional',
          textCapitalization: TextCapitalization.words,
          focusNode: viewModel.formDataManager.namaWakilBendFocus,
          textInputAction: TextInputAction.done,
          hint: 'Masukkan nama wakil bendahara',
        ),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }

  Widget _buildWakilKetuaSection(BuildContext context) {
    return Obx(() {
      viewModel.wakilKetuaVersion.value; // Trigger rebuild
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Wakil Ketua *',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              TextButton.icon(
                onPressed: viewModel.addWakilKetua,
                icon: const Icon(Icons.add),
                label: const Text('Tambah'),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceS),
          if (viewModel.wakilKetua.isEmpty)
            Text(
              'Belum ada wakil ketua. Tekan "Tambah" untuk menambahkan.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            )
          else
            ...viewModel.wakilKetua.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return DynamicListCard(
                title: 'Wakil Ketua ${index + 1}',
                onRemove: () => viewModel.removeWakilKetua(index),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: item.titleController,
                      label: 'Jabatan *',
                      helpText: 'Contoh: Wakil Ketua I, Wakil Ketua II',
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      hint: 'Masukkan jabatan',
                      validator: UiFieldValidators.required('Jabatan'),
                    ),
                    const SizedBox(height: AppDimensions.spaceM),
                    CustomTextField(
                      controller: item.namaController,
                      label: 'Nama Lengkap *',
                      helpText: 'Nama lengkap wakil ketua',
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.done,
                      hint: 'Masukkan nama lengkap',
                      validator: UiFieldValidators.required('Nama'),
                    ),
                  ],
                ),
              );
            }).toList(),
        ],
      );
    });
  }

  Widget _buildWakilSekretarisSection(BuildContext context) {
    return Obx(() {
      viewModel.wakilSekreVersion.value; // Trigger rebuild
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Wakil Sekretaris (Opsional)',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              TextButton.icon(
                onPressed: viewModel.addWakilSekretaris,
                icon: const Icon(Icons.add),
                label: const Text('Tambah'),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceS),
          if (viewModel.wakilSekre.isEmpty)
            Text(
              'Tidak ada wakil sekretaris.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            )
          else
            ...viewModel.wakilSekre.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return DynamicListCard(
                title: 'Wakil Sekretaris ${index + 1}',
                onRemove: () => viewModel.removeWakilSekretaris(index),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: item.titleController,
                      label: 'Jabatan',
                      helpText: 'Contoh: Wakil Sekretaris I',
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      hint: 'Masukkan jabatan',
                    ),
                    const SizedBox(height: AppDimensions.spaceM),
                    CustomTextField(
                      controller: item.namaController,
                      label: 'Nama Lengkap',
                      helpText: 'Nama lengkap wakil sekretaris',
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.done,
                      hint: 'Masukkan nama lengkap',
                    ),
                  ],
                ),
              );
            }).toList(),
        ],
      );
    });
  }
}
