import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/viewmodels/surat/curriculum_vitae_ipnu/curriculum_vitae_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';
import 'package:gen_surat/core/validator/field_validator.dart';
import 'package:get/get.dart';

class StepOrganisasiPendidikanSekretarisSection extends StatelessWidget {
  final CurriculumVitaeIpnuViewmodel viewModel;

  const StepOrganisasiPendidikanSekretarisSection({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Pengalaman Organisasi & Pendidikan Sekretaris'),
        const SizedBox(height: AppDimensions.spaceL),

        // Organisasi Section
        _buildOrganisasiSection(context),
        const SizedBox(height: AppDimensions.spaceL),

        // Pendidikan Section
        _buildPendidikanSection(context),
      ],
    );
  }

  Widget _buildOrganisasiSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pengalaman Organisasi',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Obx(() {
          // Trigger rebuild when switch toggled
          viewModel.organisasiSekretarisVersion.value;

          return SwitchListTile(
            value: viewModel.formDataManager.hasNoOrganizationSekretaris,
            onChanged: viewModel.toggleNoOrganizationSekretaris,
            // title: const Text('Tidak ada pengalaman organisasi'),
            subtitle: Text(
              'Aktifkan jika sekretaris belum memiliki pengalaman organisasi',
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            contentPadding: EdgeInsets.zero,
          );
        }),
        const SizedBox(height: AppDimensions.spaceM),
        Obx(() {
          // Trigger rebuild when version changes
          viewModel.organisasiSekretarisVersion.value;

          final organisasiList = viewModel.formDataManager.organisasiSekretarisList;
          final hasNoOrganization =
              viewModel.formDataManager.hasNoOrganizationSekretaris;
          if (hasNoOrganization) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
              padding: const EdgeInsets.all(AppDimensions.spaceM),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: AppDimensions.spaceS),
                    Text(
                      'Tidak ada pengalaman organisasi',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (organisasiList.isEmpty) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
              padding: const EdgeInsets.all(AppDimensions.spaceM),
              child: Center(
                child: Text(
                  'Belum ada data organisasi.\nKlik tombol "Tambah" untuk menambahkan.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ),
            );
          }

          return Column(
            children: List.generate(
              organisasiList.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: AppDimensions.spaceM),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimensions.spaceM),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Organisasi ${index + 1}',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                            IconButton(
                              onPressed:
                                  () => viewModel.removeOrganisasiKetua(index),
                              icon: const Icon(Icons.delete_outline),
                              color: Theme.of(context).colorScheme.error,
                              tooltip: 'Hapus',
                            ),
                          ],
                        ),
                        const SizedBox(height: AppDimensions.spaceS),
                        CustomTextField(
                          controller: organisasiList[index]['nama']!,
                          label: 'Nama Organisasi',
                          helpText: 'Contoh: Sekretaris IPNU Kecamatan Mojosari',
                          icon: Icons.business, 
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.done,
                          hint: 'Masukkan nama organisasi',
                          validator:
                              (value) => FieldValidator.validateRequired(
                                value,
                                'Nama organisasi',
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
        const SizedBox(height: AppDimensions.spaceM),
        Obx(() {
          viewModel.organisasiSekretarisVersion.value;
          if (viewModel.formDataManager.hasNoOrganizationSekretaris) {
            return SizedBox.shrink();
          }
          return OutlinedButton.icon(
            onPressed: viewModel.addOrganisasiSekretaris,
            icon: const Icon(Icons.add),
            label: const Text('Tambah Organisasi'),
          );
        }),
      ],
    );
  }

  Widget _buildPendidikanSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Riwayat Pendidikan',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        Obx(() {
          // Trigger rebuild when version changes
          viewModel.pendidikanSekretarisVersion.value;

          final pendidikanList = viewModel.formDataManager.pendidikanSekretarisList;

          if (pendidikanList.isEmpty) {
            return Container(
              padding: const EdgeInsets.all(AppDimensions.spaceL),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
              child: Center(
                child: Text(
                  'Belum ada data pendidikan.\nKlik tombol "Tambah" untuk menambahkan.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ),
            );
          }

          return Column(
            children: List.generate(
              pendidikanList.length,
              (index) => Container(
                margin: const EdgeInsets.only(bottom: AppDimensions.spaceM),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.spaceM),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Pendidikan ${index + 1}',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                          IconButton(
                            onPressed:
                                () => viewModel.removePendidikanSekretaris(index),
                            icon: const Icon(Icons.delete_outline),
                            color: Theme.of(context).colorScheme.error,
                            tooltip: 'Hapus',
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimensions.spaceS),
                      CustomTextField(
                        controller: pendidikanList[index]['tingkat']!,
                        label: 'Tingkat Pendidikan',
                        helpText: 'Tingkat pendidikan seperti SD, SMA, S1, S2',
                        hint: 'Masukkan tingkat pendidikan',
                        icon: Icons.school,
                        textCapitalization: TextCapitalization.characters,
                        textInputAction: TextInputAction.next,
                        validator:
                            (value) => FieldValidator.validateRequired(
                              value,
                              'Tingkat pendidikan',
                            ),
                      ),
                      const SizedBox(height: AppDimensions.spaceM),
                      CustomTextField(
                        controller: pendidikanList[index]['nama']!,
                        label: 'Nama Institusi',
                        helpText: 'Contoh: SMA Negeri 1 Mojosari',
                        hint: 'Masukkan nama institusi',
                        icon: Icons.location_city,
                        textInputAction: TextInputAction.done,
                        textCapitalization: TextCapitalization.words,
                        validator:
                            (value) => FieldValidator.validateRequired(
                              value,
                              'Nama institusi',
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
        const SizedBox(height: AppDimensions.spaceM),
        Obx(() {
          viewModel.pendidikanSekretarisVersion.value;
          return OutlinedButton.icon(
            onPressed: viewModel.addPendidikanSekretaris,
            icon: const Icon(Icons.add),
            label: const Text('Tambah Pendidikan'),
          );
        }),
      ],
    );
  }
}
