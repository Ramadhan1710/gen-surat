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

class StepDataDepartemenSection extends StatelessWidget {
  final BeritaAcaraPenyusunanPengurusIppnuViewmodel viewModel;

  const StepDataDepartemenSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Data Departemen'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan data departemen beserta koordinator dan anggotanya.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        Obx(() {
          viewModel.departemenVersion.value;
          final departemenList = viewModel.formDataManager.departemen;

          return Column(
            children: [
              if (departemenList.isEmpty)
                const EmptyStateContainer(
                  message:
                      'Belum ada departemen. Klik "Tambah Departemen" untuk menambahkan.',
                )
              else
                ...List.generate(
                  departemenList.length,
                  (index) => _buildDepartemenCard(
                    context,
                    index,
                    departemenList[index],
                  ),
                ),
              const SizedBox(height: AppDimensions.spaceM),
              AddItemButton(
                label: 'Tambah Departemen',
                onPressed: viewModel.addDepartemen,
              ),
            ],
          );
        }),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }

  Widget _buildDepartemenCard(
    BuildContext context,
    int index,
    DepartemenData data,
  ) {
    return NumberedItemCard(
      number: index + 1,
      label: 'Departemen',
      onDelete: () => viewModel.removeDepartemen(index),
      deleteTooltip: 'Hapus departemen',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            controller: data.namaDepartemenController,
            label: 'Nama Departemen',
            helpText:
                'Contoh: Pengembangan Organisasi, Pendidikan & Kaderisasi',
            textCapitalization: TextCapitalization.words,
            hint: 'Masukkan nama departemen',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Nama departemen wajib diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: AppDimensions.spaceM),
          CustomTextField(
            controller: data.koordinatorController,
            label: 'Koordinator Departemen',
            helpText: 'Nama lengkap koordinator departemen',
            textCapitalization: TextCapitalization.words,
            hint: 'Masukkan nama koordinator',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Koordinator wajib diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: AppDimensions.spaceL),
          const Divider(),
          const SizedBox(height: AppDimensions.spaceM),
          Text(
            'Anggota Departemen',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: AppDimensions.spaceS),
          _buildAnggotaDepartemenList(context, index, data),
        ],
      ),
    );
  }

  Widget _buildAnggotaDepartemenList(
    BuildContext context,
    int departemenIndex,
    DepartemenData data,
  ) {
    return Obx(() {
      viewModel.departemenVersion.value;
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
                'Belum ada anggota departemen',
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
                child: _buildAnggotaDepartemenCard(
                  context,
                  departemenIndex,
                  anggotaIndex,
                  anggotaList[anggotaIndex],
                ),
              ),
            ),
          const SizedBox(height: AppDimensions.spaceS),
          AddItemButton(
            label: 'Tambah Anggota',
            onPressed: () => viewModel.addAnggotaDepartemen(departemenIndex),
          ),
        ],
      );
    });
  }

  Widget _buildAnggotaDepartemenCard(
    BuildContext context,
    int departemenIndex,
    int anggotaIndex,
    AnggotaDepartemenData data,
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
                viewModel.removeAnggotaDepartemen(departemenIndex, anggotaIndex),
            tooltip: 'Hapus anggota',
          ),
        ],
      ),
    );
  }
}
