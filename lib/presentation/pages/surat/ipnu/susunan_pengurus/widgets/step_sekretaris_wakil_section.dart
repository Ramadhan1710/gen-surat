import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/susunan_pengurus/susunan_pengurus_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/susunan_pengurus/managers/ipnu/susunan_pengurus_ipnu_form_data_manager.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';
import 'package:get/get.dart';

class StepSekretarisWakilSection extends StatelessWidget {
  final SusunanPengurusIpnuViewmodel viewModel;

  const StepSekretarisWakilSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        // ========== SEKRETARIS SECTION ==========
        const SectionHeader(title: 'Sekretaris'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan data sekretaris organisasi.',
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
          hint: 'Masukkan nama sekretaris',
          validator: UiFieldValidators.required('Nama sekretaris'),
        ),
        const SizedBox(height: AppDimensions.spaceM),

        CustomTextField(
          controller: viewModel.formDataManager.alamatSekretarisController,
          label: 'Alamat Sekretaris *',
          helpText: 'Alamat lengkap sekretaris',
          textCapitalization: TextCapitalization.words,
          focusNode: viewModel.formDataManager.alamatSekretarisFocus,
          textInputAction: TextInputAction.next,
          hint: 'Masukkan alamat sekretaris',
          maxLines: 2,
          validator: UiFieldValidators.required('Alamat sekretaris'),
        ),

        const SizedBox(height: AppDimensions.spaceXL),
        const Divider(),
        const SizedBox(height: AppDimensions.spaceXL),

        // ========== WAKIL SEKRETARIS SECTION ==========
        const SectionHeader(title: 'Wakil Sekretaris (Opsional)'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan data wakil sekretaris organisasi (opsional).',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceM),

        Obx(() {
          // Trigger rebuild
          viewModel.wakilSekretarisVersion.value;
          final wakilSekreList = viewModel.formDataManager.wakilSekre;

          return Column(
            children: [
              if (wakilSekreList.isEmpty)
                Container(
                  padding: const EdgeInsets.all(AppDimensions.spaceL),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(
                        context,
                      ).colorScheme.outline.withOpacity(0.2),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Belum ada wakil sekretaris. Klik "Tambah Wakil Sekretaris" untuk menambahkan.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.5),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
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
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: viewModel.addWakilSekretaris,
                  icon: const Icon(Icons.add),
                  label: const Text('Tambah Wakil Sekretaris'),
                ),
              ),
            ],
          );
        }),

        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }

  Widget _buildWakilSekretarisCard(
    BuildContext context,
    int index,
    WakilSekretarisData data,
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
                  'Wakil Sekretaris ${index + 1}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => viewModel.removeWakilSekretaris(index),
                  tooltip: 'Hapus wakil sekretaris',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.spaceM),
            CustomTextField(
              controller: data.titleController,
              label: 'Jabatan',
              helpText: 'Contoh: Wakil Sekretaris I, Wakil Sekretaris II',
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
              helpText: 'Nama lengkap wakil sekretaris',
              textCapitalization: TextCapitalization.words,
              hint: 'Masukkan nama',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama wajib diisi';
                }
                return null;
              },
            ),
            const SizedBox(height: AppDimensions.spaceM),
            CustomTextField(
              controller: data.alamatController,
              label: 'Alamat',
              helpText: 'Alamat lengkap wakil sekretaris',
              textCapitalization: TextCapitalization.words,
              hint: 'Masukkan alamat',
              maxLines: 2,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Alamat wajib diisi';
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
