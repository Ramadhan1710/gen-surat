import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/susunan_pengurus/managers/ipnu/susunan_pengurus_ipnu_form_data_manager.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/susunan_pengurus/susunan_pengurus_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';
import 'package:get/get.dart';

class StepCbpDivisiSection extends StatelessWidget {
  final SusunanPengurusIpnuViewmodel viewModel;

  const StepCbpDivisiSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ========== CBP TOGGLE ==========
          const SectionHeader(title: 'Lembaga CBP (Corp Brigade Pembangunan)'),
          const SizedBox(height: AppDimensions.spaceM),
          Obx(
            () => SwitchListTile(
              title: Text(
                'Apakah memiliki Lembaga CBP?',
                style: AppTextStyles.bodyMedium,
              ),
              subtitle: Text(
                'Aktifkan jika organisasi memiliki lembaga CBP',
                style: AppTextStyles.bodySmall,
              ),
              value: viewModel.formDataManager.hasLembagaCBP.value,
              onChanged: (value) {
                viewModel.formDataManager.hasLembagaCBP.value = value;
              },
              contentPadding: EdgeInsets.zero,
            ),
          ),

          // CBP Form - Conditional
          Obx(() {
            if (!viewModel.formDataManager.hasLembagaCBP.value) {
              return const SizedBox.shrink();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppDimensions.spaceM),
                Container(
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
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
                        Text(
                          'Data Lembaga CBP',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Divider(),
                        const SizedBox(height: AppDimensions.spaceM),

                        CustomTextField(
                          controller:
                              viewModel.formDataManager.komandanController,
                          label: 'Komandan',
                          helpText: 'Nama komandan CBP',
                          textCapitalization: TextCapitalization.words,
                          hint: 'Masukkan nama komandan',
                          validator: UiFieldValidators.required('Komandan'),
                        ),
                        const SizedBox(height: AppDimensions.spaceM),

                        CustomTextField(
                          controller:
                              viewModel
                                  .formDataManager
                                  .alamatKomandanController,
                          label: 'Alamat Komandan',
                          helpText: 'Contoh: Desa Ngepeh/Dusun Krajan',
                          textCapitalization: TextCapitalization.words,
                          hint: 'Masukkan alamat komandan',
                          maxLines: 2,
                          validator: UiFieldValidators.required(
                            'Alamat komandan',
                          ),
                        ),
                        const SizedBox(height: AppDimensions.spaceM),

                        CustomTextField(
                          controller:
                              viewModel.formDataManager.wakilKomandanController,
                          label: 'Wakil Komandan',
                          helpText: 'Nama wakil komandan CBP',
                          textCapitalization: TextCapitalization.words,
                          hint: 'Masukkan nama wakil komandan',
                          validator: UiFieldValidators.required(
                            'Wakil Komandan',
                          ),
                        ),
                        const SizedBox(height: AppDimensions.spaceM),

                        CustomTextField(
                          controller:
                              viewModel
                                  .formDataManager
                                  .alamatWakilKomandanController,
                          label: 'Alamat Wakil Komandan',
                          helpText: 'Contoh: Desa Ngepeh/Dusun Krajan',
                          textCapitalization: TextCapitalization.words,
                          hint: 'Masukkan alamat wakil komandan',
                          validator: UiFieldValidators.required(
                            'Alamat wakil komandan',
                          ),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),

          const SizedBox(height: AppDimensions.spaceXL),

          // ========== DIVISI TOGGLE ==========
          Obx(() {
            if (!viewModel.formDataManager.hasLembagaCBP.value) {
              return const SizedBox.shrink();
            }

            return _buildDivisiSection(context, viewModel);
          }),
          const SizedBox(height: AppDimensions.spaceXXL),
        ],
      ),
    );
  }

  Widget _buildDivisiCard(BuildContext context, DivisiData divisi, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      key: ValueKey('divisi_card_$index'),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spaceM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Divisi ${index + 1}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => viewModel.removeDivisi(index),
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).colorScheme.error,
                  tooltip: 'Hapus Divisi',
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: AppDimensions.spaceM),

            CustomTextField(
              controller: divisi.namaController,
              label: 'Nama Divisi',
              hint: 'Masukkan nama divisi',
              helpText: 'Contoh: Divisi Kesejahteraan Sosial',
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              validator: UiFieldValidators.required('Nama Divisi'),
            ),
            const SizedBox(height: AppDimensions.spaceM),

            CustomTextField(
              controller: divisi.koordinatorController,
              label: 'Koordinator',
              helpText: 'Nama koordinator divisi',
              hint: 'Masukkan nama koordinator',
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              validator: UiFieldValidators.required('Koordinator'),
            ),
            const SizedBox(height: AppDimensions.spaceM),

            CustomTextField(
              controller: divisi.alamatKoordinatorController,
              label: 'Alamat Koordinator',
              hint: 'Masukan alamat koordinator',
              helpText: 'Contoh: Desa Ngepeh/Dusun Mojosari',
              maxLines: 2,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              validator: UiFieldValidators.required('Alamat Koordinator'),
            ),

            const SizedBox(height: AppDimensions.spaceM),
            const Divider(),

            // Anggota Section
            Text(
              'Anggota Divisi',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: AppDimensions.spaceS),

            if (divisi.anggota.isEmpty)
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
                    anggotaIndex < divisi.anggota.length;
                    anggotaIndex++
                  ) ...[
                    _buildAnggotaItem(
                      context,
                      divisi.anggota[anggotaIndex],
                      anggotaIndex,
                      index,
                    ),
                    if (anggotaIndex < divisi.anggota.length - 1)
                      const SizedBox(height: AppDimensions.spaceM),
                  ],
                ],
              ),
            const SizedBox(height: AppDimensions.spaceM),
            OutlinedButton.icon(
              onPressed: () => viewModel.addAnggotaDivisi(index),
              icon: const Icon(Icons.add),
              label: const Text('Tambah Anggota'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnggotaItem(
    BuildContext context,
    AnggotaData anggota,
    int anggotaIndex,
    int divisiIndex,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spaceM,
                  vertical: AppDimensions.spaceS,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Anggota ${anggotaIndex + 1}',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              IconButton(
                onPressed:
                    () => viewModel.removeAnggotaDivisi(
                      divisiIndex,
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
          const SizedBox(height: AppDimensions.spaceM),

          CustomTextField(
            controller: anggota.namaController,
            label: 'Nama Anggota',
            hint: 'Masukkan nama anggota',
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            validator: UiFieldValidators.required('Nama anggota'),
          ),
          const SizedBox(height: AppDimensions.spaceM),

          CustomTextField(
            controller: anggota.alamatController,
            label: 'Alamat Anggota',
            hint: 'Masukkan alamat anggota',
            helpText: 'Contoh: Desa Ngepeh/Dusun Mojosari',
            maxLines: 2,
            textCapitalization: TextCapitalization.words,
            validator: UiFieldValidators.required('Alamat anggota'),
          ),
        ],
      ),
    );
  }

  Widget _buildDivisiSection(
    BuildContext context,
    SusunanPengurusIpnuViewmodel viewModel,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        const SizedBox(height: AppDimensions.spaceXL),
        const SectionHeader(title: 'Divisi CBP'),
        const SizedBox(height: AppDimensions.spaceM),
        Obx(
          () => SwitchListTile(
            title: Text(
              'Apakah Lembaga CBP memiliki Divisi?',
              style: AppTextStyles.bodyMedium,
            ),
            subtitle: Text(
              'Aktifkan jika Lembaga CBP memiliki struktur divisi',
              style: AppTextStyles.bodySmall,
            ),
            value: viewModel.formDataManager.hasDivisi.value,
            onChanged: (value) {
              viewModel.formDataManager.hasDivisi.value = value;
            },
            contentPadding: EdgeInsets.zero,
          ),
        ),

        // Divisi List - Conditional
        Obx(() {
          if (!viewModel.formDataManager.hasDivisi.value) {
            return const SizedBox.shrink();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppDimensions.spaceM),

              Text(
                'Daftar Divisi',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppDimensions.spaceM),

              Obx(() {
                // Trigger rebuild
                final version = viewModel.divisiVersion.value;

                final divisiList = viewModel.formDataManager.divisi;

                if (divisiList.isEmpty) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimensions.spaceL),
                      child: Center(
                        child: Text(
                          'Belum ada divisi. Klik "Tambah Divisi" untuk menambahkan.',
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                }

                return Column(
                  key: ValueKey('divisi_list_$version'),
                  children: [
                    for (int index = 0; index < divisiList.length; index++) ...[
                      _buildDivisiCard(context, divisiList[index], index),
                      if (index < divisiList.length - 1)
                        const SizedBox(height: AppDimensions.spaceM),
                    ],
                  ],
                );
              }),
              const SizedBox(height: AppDimensions.spaceM),
              OutlinedButton.icon(
                onPressed: viewModel.addDivisi,
                icon: const Icon(Icons.add),
                label: const Text('Tambah Divisi'),
              ),
            ],
          );
        }),
      ],
    );
  }
}
