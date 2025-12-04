import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/susunan_pengurus/susunan_pengurus_ippnu_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/susunan_pengurus/managers/susunan_pengurus_ippnu_form_data_manager.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';
import 'package:get/get.dart';

class StepKetuaWakilSection extends StatelessWidget {
  final SusunanPengurusIppnuViewmodel viewModel;

  const StepKetuaWakilSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        // ========== KETUA SECTION ==========
        const SectionHeader(title: 'Ketua'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan data ketua organisasi.',
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
          textInputAction: TextInputAction.next,
          hint: 'Masukkan nama ketua',
          validator: UiFieldValidators.required('Nama ketua'),
        ),

        const SizedBox(height: AppDimensions.spaceXL),
        const Divider(),
        const SizedBox(height: AppDimensions.spaceXL),

        // ========== WAKIL KETUA SECTION ==========
        const SectionHeader(title: 'Wakil Ketua'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan data wakil ketua organisasi.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
        ),
        const SizedBox(height: AppDimensions.spaceM),

        Obx(() {
          // Trigger rebuild
          viewModel.wakilKetuaVersion.value;
          final wakilKetuaList = viewModel.formDataManager.wakilKetua;

          return Column(
            children: [
              if (wakilKetuaList.isEmpty)
                Container(
                  padding: const EdgeInsets.all(AppDimensions.spaceL),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(context)
                          .colorScheme
                          .outline
                          .withOpacity(0.2),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Belum ada wakil ketua. Klik "Tambah Wakil Ketua" untuk menambahkan.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.5),
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              else
                ...List.generate(
                  wakilKetuaList.length,
                  (index) => _buildWakilKetuaCard(
                    context,
                    index,
                    wakilKetuaList[index],
                  ),
                ),
              const SizedBox(height: AppDimensions.spaceM),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: viewModel.addWakilKetua,
                  icon: const Icon(Icons.add),
                  label: const Text('Tambah Wakil Ketua'),
                ),
              ),
            ],
          );
        }),

        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }

  Widget _buildWakilKetuaCard(
    BuildContext context,
    int index,
    WakilKetuaData data,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceM),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Wakil Ketua ${index + 1}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => viewModel.removeWakilKetua(index),
                  tooltip: 'Hapus wakil ketua',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.spaceM),
            CustomTextField(
              controller: data.titleController,
              label: 'Jabatan',
              helpText: 'Contoh: Wakil Ketua I, Wakil Ketua II',
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
            CustomTextField(
              controller: data.namaController,
              label: 'Nama',
              helpText: 'Nama lengkap wakil ketua',
              textCapitalization: TextCapitalization.words,
              hint: 'Masukkan nama',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama wajib diisi';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
