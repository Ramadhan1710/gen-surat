import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/berita_acara_penyusunan_pengurus/berita_acara_penyusunan_pengurus_ippnu_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/berita_acara_penyusunan_pengurus/managers/berita_acara_penyusunan_pengurus_ippnu_form_data_manager.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';
import 'package:gen_surat/presentation/widgets/cards/empty_state_container.dart';
import 'package:gen_surat/presentation/widgets/cards/numbered_item_card.dart';
import 'package:gen_surat/presentation/widgets/buttons/add_item_button.dart';
import 'package:get/get.dart';

class StepDataLembagaSection extends StatelessWidget {
  final BeritaAcaraPenyusunanPengurusIppnuViewmodel viewModel;

  const StepDataLembagaSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Data Lembaga'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan data lembaga beserta direktur, sekretaris, dan anggotanya.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        Obx(() {
          viewModel.lembagaVersion.value;
          final lembagaList = viewModel.formDataManager.lembaga;

          return Column(
            children: [
              if (lembagaList.isEmpty)
                const EmptyStateContainer(
                  message:
                      'Belum ada lembaga. Klik "Tambah Lembaga" untuk menambahkan.',
                )
              else
                ...List.generate(
                  lembagaList.length,
                  (index) =>
                      _buildLembagaCard(context, index, lembagaList[index]),
                ),
              const SizedBox(height: AppDimensions.spaceM),
              AddItemButton(
                label: 'Tambah Lembaga',
                onPressed: viewModel.addLembaga,
              ),
            ],
          );
        }),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }

  Widget _buildLembagaCard(
    BuildContext context,
    int index,
    LembagaData data,
  ) {
    return NumberedItemCard(
      number: index + 1,
      label: 'Lembaga',
      onDelete: () => viewModel.removeLembaga(index),
      deleteTooltip: 'Hapus lembaga',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            controller: data.namaController,
            label: 'Nama Lembaga',
            helpText: 'Contoh: Lembaga Pendidikan dan Kaderisasi',
            textCapitalization: TextCapitalization.words,
            hint: 'Masukkan nama lembaga',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Nama lembaga wajib diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: AppDimensions.spaceM),
          CustomTextField(
            controller: data.direkturController,
            label: 'Direktur Lembaga',
            helpText: 'Nama lengkap direktur lembaga',
            textCapitalization: TextCapitalization.words,
            hint: 'Masukkan nama direktur',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Direktur wajib diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: AppDimensions.spaceM),
          CustomTextField(
            controller: data.sekretarisController,
            label: 'Sekretaris Lembaga',
            helpText: 'Nama lengkap sekretaris lembaga',
            textCapitalization: TextCapitalization.words,
            hint: 'Masukkan nama sekretaris',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Sekretaris wajib diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: AppDimensions.spaceL),
          const Divider(),
          const SizedBox(height: AppDimensions.spaceM),
          Text(
            'Anggota Lembaga',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: AppDimensions.spaceS),
          _buildAnggotaLembagaList(context, index, data),
        ],
      ),
    );
  }

  Widget _buildAnggotaLembagaList(
    BuildContext context,
    int lembagaIndex,
    LembagaData data,
  ) {
    return Obx(() {
      viewModel.lembagaVersion.value;
      final anggotaList = data.anggota;

      return Column(
        children: [
          if (anggotaList.isEmpty)
            Container(
              padding: const EdgeInsets.all(AppDimensions.spaceM),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              ),
              child: Text(
                'Belum ada anggota lembaga',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.6),
                    ),
              ),
            )
          else
            ...List.generate(
              anggotaList.length,
              (anggotaIndex) => Padding(
                padding: const EdgeInsets.only(bottom: AppDimensions.spaceS),
                child: _buildAnggotaLembagaCard(
                  context,
                  lembagaIndex,
                  anggotaIndex,
                  anggotaList[anggotaIndex],
                ),
              ),
            ),
          const SizedBox(height: AppDimensions.spaceS),
          AddItemButton(
            label: 'Tambah Anggota',
            onPressed: () => viewModel.addAnggotaLembaga(lembagaIndex),
          ),
        ],
      );
    });
  }

  Widget _buildAnggotaLembagaCard(
    BuildContext context,
    int lembagaIndex,
    int anggotaIndex,
    AnggotaLembagaData data,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            padding: const EdgeInsets.all(AppDimensions.spaceS),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppDimensions.radiusM),
                bottomLeft: Radius.circular(AppDimensions.radiusM),
              ),
            ),
            child: Center(
              child: Text(
                '${anggotaIndex + 1}',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spaceM,
                vertical: AppDimensions.spaceS,
              ),
              child: CustomTextField(
                controller: data.namaController,
                label: '',
                hint: 'Nama anggota',
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama anggota wajib diisi';
                  }
                  return null;
                },
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            color: Theme.of(context).colorScheme.error,
            onPressed: () =>
                viewModel.removeAnggotaLembaga(lembagaIndex, anggotaIndex),
            tooltip: 'Hapus anggota',
          ),
        ],
      ),
    );
  }
}
