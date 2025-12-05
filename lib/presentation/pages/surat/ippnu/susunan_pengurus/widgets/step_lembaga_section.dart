import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/susunan_pengurus/managers/susunan_pengurus_ippnu_form_data_manager.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/susunan_pengurus/susunan_pengurus_ippnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/cards/expandable_item_card.dart';
import 'package:gen_surat/presentation/widgets/buttons/add_item_button.dart';
import 'package:get/get.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/susunan_pengurus/widgets/lembaga_ipnu_info_dialog.dart';

class StepLembagaSection extends StatelessWidget {
  final SusunanPengurusIppnuViewmodel viewModel;

  const StepLembagaSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Lembaga Internal',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                onPressed: () => LembagaIpnuInfoDialog.show(context),
                icon: const Icon(Icons.info_outline, size: 20),
                style: IconButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.spaceM,
                    vertical: AppDimensions.spaceS,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceS),
          Text(
            'Kelola lembaga-lembaga internal yang ada di kepengurusan. Lembaga Pers dan Penerbitan wajib ada.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: AppDimensions.spaceM),

          Obx(() {
            // Trigger rebuild
            final version = viewModel.lembagaVersion.value;

            final lembagaList = viewModel.formDataManager.lembaga;

            if (lembagaList.isEmpty) {
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.spaceL),
                  child: Center(
                    child: Text(
                      'Belum ada lembaga internal. Klik "Tambah Lembaga" untuk menambahkan.',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }

            return Column(
              key: ValueKey('lembaga_list_$version'),
              children: [
                for (int index = 0; index < lembagaList.length; index++) ...[
                  _buildLembagaCard(context, lembagaList[index], index),
                  if (index < lembagaList.length - 1)
                    const SizedBox(height: AppDimensions.spaceM),
                ],
              ],
            );
          }),
          const SizedBox(height: AppDimensions.spaceM),
          AddItemButton(
            label: 'Tambah Lembaga',
            onPressed: viewModel.addLembaga,
            fullWidth: false,
          ),
        ],
      ),
    );
  }

  Widget _buildLembagaCard(
    BuildContext context,
    LembagaData lembaga,
    int index,
  ) {
    return ExpandableItemCard(
      cardKey: ValueKey('lembaga_card_$index'),
      title: 'Lembaga ${index + 1}',
      onDelete: () => viewModel.removeLembaga(index),
      deleteTooltip: 'Hapus Lembaga',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            controller: lembaga.namaController,
            label: 'Nama lembaga',
            helpText: 'Nama lengkap lembaga, Contoh Pers dan Penerbitan',
            hint: 'Masukkan nama lembaga',
            validator: UiFieldValidators.required('Nama lembaga'),
            textCapitalization: TextCapitalization.words,
            icon: Icons.business,
          ),
          const SizedBox(height: AppDimensions.spaceM),

          CustomTextField(
            controller: lembaga.direkturController,
            label: 'Direktur Lembaga',
            helpText: 'Nama direktur lembaga, Contoh: Ahmad Suharto',
            hint: 'Masukkan nama direktur',
            validator: UiFieldValidators.required('Direktur lembaga'),
            textCapitalization: TextCapitalization.words,
            icon: Icons.person,
          ),
          const SizedBox(height: AppDimensions.spaceM),

          CustomTextField(
            controller: lembaga.sekretarisController,
            label: 'Sekretaris Lembaga',
            helpText: 'Nama sekretaris lembaga, Contoh: Budi Santoso',
            hint: 'Masukkan nama sekretaris',
            validator: UiFieldValidators.required('Sekretaris lembaga'),
            textCapitalization: TextCapitalization.words,
            icon: Icons.person,
          ),
          const SizedBox(height: AppDimensions.spaceM),
          const Divider(),

          // Anggota Section
          Text(
            'Anggota Lembaga',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: AppDimensions.spaceM),

          if (lembaga.anggota.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.spaceM,
              ),
              child: Text(
                'Belum ada anggota. Klik "Tambah Anggota" untuk menambahkan.',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
            )
          else
            Column(
              children: [
                for (
                  int anggotaIndex = 0;
                  anggotaIndex < lembaga.anggota.length;
                  anggotaIndex++
                ) ...[
                  _buildAnggotaItem(
                    context,
                    lembaga.anggota[anggotaIndex],
                    anggotaIndex,
                    index,
                  ),
                  if (anggotaIndex < lembaga.anggota.length - 1) ...[
                    const SizedBox(height: AppDimensions.spaceS),
                    const Divider(),
                    const SizedBox(height: AppDimensions.spaceS),
                  ],
                ],
              ],
            ),
          const SizedBox(height: AppDimensions.spaceM),
          AddItemButton(
            label: 'Tambah Anggota',
            onPressed: () => viewModel.addAnggotaLembaga(index),
            fullWidth: false,
          ),
        ],
      ),
    );
  }

  Widget _buildAnggotaItem(
    BuildContext context,
    AnggotaLembagaData anggota,
    int anggotaIndex,
    int lembagaIndex,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.spaceXS,
                horizontal: AppDimensions.spaceS,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Anggota ${anggotaIndex + 1}',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            IconButton(
              onPressed:
                  () => viewModel.removeAnggotaLembaga(
                    lembagaIndex,
                    anggotaIndex,
                  ),
              icon: const Icon(Icons.delete, size: 20),
              color: Theme.of(context).colorScheme.error,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              tooltip: 'Hapus Anggota',
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spaceXS),
        CustomTextField(
          controller: anggota.namaController,
          label: 'Nama Anggota',
          hint: 'Masukkan nama anggota',
          validator: UiFieldValidators.required('Nama anggota'),
          textCapitalization: TextCapitalization.words,
          icon: Icons.person,
        ),
      ],
    );
  }
}
