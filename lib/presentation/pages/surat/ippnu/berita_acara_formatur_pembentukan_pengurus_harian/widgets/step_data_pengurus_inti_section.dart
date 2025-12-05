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

class StepDataPengurusIntiSection extends StatelessWidget {
  final BeritaAcaraFormaturPembentukanPengurusHarianIppnuViewmodel viewModel;

  const StepDataPengurusIntiSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        // ========== KETUA SECTION ==========
        const SectionHeader(title: 'Ketua'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan data ketua pimpinan.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaKetuaController,
          label: 'Nama Ketua *',
          helpText: 'Nama lengkap ketua',
          textCapitalization: TextCapitalization.words,
          focusNode: viewModel.formDataManager.namaKetuaFocus,
          icon: Icons.person,
          textInputAction: TextInputAction.next,
          hint: 'Masukkan nama ketua',
          validator: UiFieldValidators.required('Nama ketua'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        const Divider(),
        const SizedBox(height: AppDimensions.spaceM),

        // ========== WAKIL KETUA SECTION ==========
        const SectionHeader(title: 'Wakil Ketua'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan data wakil ketua pimpinan.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        _buildWakilKetuaSection(context),
        const SizedBox(height: AppDimensions.spaceM),
        const Divider(),
        const SizedBox(height: AppDimensions.spaceM),

        // ========== SEKRETARIS SECTION ==========
        const SectionHeader(title: 'Sekretaris'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan data sekretaris pimpinan.',
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
          icon: Icons.person,
          hint: 'Masukkan nama sekretaris',
          validator: UiFieldValidators.required('Nama sekretaris'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        _buildWakilSekretarisSection(context),
        const SizedBox(height: AppDimensions.spaceM),
        const Divider(),
        const SizedBox(height: AppDimensions.spaceM),

        // ========== BENDAHARA SECTION ==========
        const SectionHeader(title: 'Bendahara'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan data bendahara pimpinan.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaBendaharaController,
          label: 'Nama Bendahara *',
          helpText: 'Nama lengkap bendahara',
          textCapitalization: TextCapitalization.words,
          focusNode: viewModel.formDataManager.namaBendaharaFocus,
          icon: Icons.person,
          textInputAction: TextInputAction.next,
          hint: 'Masukkan nama bendahara',
          validator: UiFieldValidators.required('Nama bendahara'),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: viewModel.formDataManager.namaWakilBendController,
          label: 'Nama Wakil Bendahara',
          helpText: 'Nama lengkap wakil bendahara (opsional)',
          textCapitalization: TextCapitalization.words,
          focusNode: viewModel.formDataManager.namaWakilBendFocus,
          icon: Icons.person,
          textInputAction: TextInputAction.done,
          hint: 'Masukkan nama wakil bendahara',
        ),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }

  Widget _buildWakilKetuaSection(BuildContext context) {
    return Obx(() {
      viewModel.wakilKetuaVersion.value;
      final wakilKetuaList = viewModel.formDataManager.wakilKetua;

      return Column(
        children: [
          if (wakilKetuaList.isEmpty)
            const EmptyStateContainer(
              message:
                  'Belum ada wakil ketua. Klik "Tambah Wakil Ketua" untuk menambahkan.',
            )
          else
            ...List.generate(
              wakilKetuaList.length,
              (index) =>
                  _buildWakilKetuaCard(context, index, wakilKetuaList[index]),
            ),
          const SizedBox(height: AppDimensions.spaceM),
          AddItemButton(
            label: 'Tambah Wakil Ketua',
            onPressed: viewModel.addWakilKetua,
          ),
        ],
      );
    });
  }

  Widget _buildWakilSekretarisSection(BuildContext context) {
    return Obx(() {
      viewModel.wakilSekretarisVersion.value;
      final wakilSekreList = viewModel.formDataManager.wakilSekretaris;

      return Column(
        children: [
          if (wakilSekreList.isEmpty)
            const EmptyStateContainer(
              message:
                  'Belum ada wakil sekretaris. Klik "Tambah Wakil Sekretaris" untuk menambahkan (opsional).',
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
    });
  }

  Widget _buildWakilKetuaCard(
    BuildContext context,
    int index,
    WakilKetuaData data,
  ) {
    return NumberedItemCard(
      number: index + 1,
      label: 'Wakil Ketua',
      onDelete: () => viewModel.removeWakilKetua(index),
      deleteTooltip: 'Hapus wakil ketua',
      child: Column(
        children: [
          CustomTextField(
            controller: data.titleController,
            label: 'Jabatan',
            helpText: 'Contoh: Wakil Ketua I, Wakil Ketua II',
            textCapitalization: TextCapitalization.words,
            hint: 'Masukkan jabatan',
            icon: Icons.work,
            validator: UiFieldValidators.required('Jabatan wakil ketua'),
          ),
          const SizedBox(height: AppDimensions.spaceM),
          CustomTextField(
            controller: data.namaController,
            label: 'Nama',
            helpText: 'Nama lengkap wakil ketua',
            textCapitalization: TextCapitalization.words,
            hint: 'Masukkan nama',
            icon: Icons.person,
            validator: UiFieldValidators.required('Nama wakil ketua'),
          ),
        ],
      ),
    );
  }

  Widget _buildWakilSekretarisCard(
    BuildContext context,
    int index,
    WakilSekretarisData data,
  ) {
    return NumberedItemCard(
      number: index + 1,
      label: 'Wakil Sekretaris',
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
            icon: Icons.work,
            validator: UiFieldValidators.required('Jabatan wakil sekretaris'),
          ),
          const SizedBox(height: AppDimensions.spaceM),
          CustomTextField(
            controller: data.namaController,
            label: 'Nama',
            helpText: 'Nama lengkap wakil sekretaris',
            textCapitalization: TextCapitalization.words,
            hint: 'Masukkan nama',
            icon: Icons.person,
            validator: UiFieldValidators.required('Nama wakil sekretaris'),
          ),
        ],
      ),
    );
  }
}
