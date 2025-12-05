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
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
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
            icon: Icons.business,
            textInputAction: TextInputAction.next,
            validator: UiFieldValidators.required('Nama departemen'),
          ),
          const SizedBox(height: AppDimensions.spaceM),
          CustomTextField(
            controller: data.koordinatorController,
            label: 'Koordinator Departemen',
            helpText: 'Nama lengkap koordinator departemen',
            icon: Icons.person,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            hint: 'Masukkan nama koordinator',
            validator: UiFieldValidators.required('Koordinator departemen'),
          ),
          const SizedBox(height: AppDimensions.spaceL),
          const Divider(),
          const SizedBox(height: AppDimensions.spaceM),
          Text(
            'Anggota Departemen',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
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
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(AppDimensions.radiusS),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spaceS,
                vertical: AppDimensions.spaceXS,
              ),
              child: Text(
                'Anggota ${anggotaIndex + 1}',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            IconButton(
              onPressed:
                  () => viewModel.removeAnggotaDepartemen(
                    departemenIndex,
                    anggotaIndex,
                  ),
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.delete, size: 20),
              color: Theme.of(context).colorScheme.error,
              tooltip: 'Hapus Anggota',
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spaceXS),
        CustomTextField(
          controller: data.namaController,
          label: 'Nama Anggota',
          hint: 'Nama anggota',
          textCapitalization: TextCapitalization.words,
          icon: Icons.person,
          validator: UiFieldValidators.required('Nama anggota'),
        ),
      ],
    );
  }
}
