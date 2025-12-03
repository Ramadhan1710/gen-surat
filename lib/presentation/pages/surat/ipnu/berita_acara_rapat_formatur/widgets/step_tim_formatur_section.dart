import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/berita_acara_rapat_formatur/berita_acara_rapat_formatur_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';
import 'package:gen_surat/presentation/widgets/file_picker_widget.dart';
import 'package:get/get.dart';

class StepTimFormaturSection extends StatelessWidget {
  final BeritaAcaraRapatFormaturViewmodel viewModel;

  const StepTimFormaturSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BeritaAcaraRapatFormaturViewmodel>(
      builder:
          (vm) => ListView(
            padding: const EdgeInsets.all(AppDimensions.spaceM),
            children: [
              const SectionHeader(title: 'Tim Formatur'),
              const SizedBox(height: AppDimensions.spaceM),
              ...List.generate(
                vm.formDataManager.timFormaturList.length,
                (index) => _buildTimFormaturCard(context, vm, index),
              ),
              const SizedBox(height: AppDimensions.spaceM),
              OutlinedButton.icon(
                onPressed: vm.addTimFormatur,
                icon: const Icon(Icons.add),
                label: const Text('Tambah Anggota Tim Formatur'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildTimFormaturCard(
    BuildContext context,
    BeritaAcaraRapatFormaturViewmodel vm,
    int index,
  ) {
    final member = vm.formDataManager.timFormaturList[index];

    return Card(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceM),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spaceM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Anggota Tim Formatur #${index + 1}',
                  style: AppTextStyles.titleSmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Hanya tampilkan tombol hapus untuk anggota ke-3 dan seterusnya
                if (vm.formDataManager.timFormaturList.length > 2 && index >= 2)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => vm.removeTimFormatur(index),
                    tooltip: 'Hapus',
                  ),
              ],
            ),
            const SizedBox(height: AppDimensions.spaceM),
            CustomTextField(
              controller: member.namaController,
              label: 'Nama Tim Formatur *',
              hint: 'Masukkan nama tim formatur',
              helpText:
                  'Nama lengkap anggota tim formatur, Contoh: Ahmad Sulaiman',
              icon: Icons.person,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              focusNode: member.namaFocus,
              validator: UiFieldValidators.required('Nama tim formatur'),
            ),
            const SizedBox(height: AppDimensions.spaceM),
            CustomTextField(
              controller: member.jabatanController,
              label: 'Jabatan Tim Formatur *',
              hint: 'Masukkan jabatan',
              focusNode: member.jabatanFocus,
              helpText:
                  index < 2
                      ? 'Jabatan sudah ditentukan secara otomatis'
                      : 'Jabatan anggota tim formatur, Contoh: Ketua Terpilih',
              icon: Icons.badge,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.done,
              readOnly:
                  index < 2, // Jabatan untuk anggota 1 dan 2 tidak bisa diubah
              validator: UiFieldValidators.required('Jabatan tim formatur'),
            ),
            const SizedBox(height: AppDimensions.spaceM),
            _buildTtdSection(context, vm, index, member),
          ],
        ),
      ),
    );
  }

  Widget _buildTtdSection(
    BuildContext context,
    BeritaAcaraRapatFormaturViewmodel vm,
    int index,
    dynamic member,
  ) {
    final hasTtd = member.ttdPath != null;

    return FilePickerWidget(
      label: 'Tanda Tangan Tim Formatur *',
      icon: Icons.draw,
      file: hasTtd ? File(member.ttdPath!) : null,
      onPick: () async {
        final file = await ImagePickerHelper.pickImage(context);
        if (file != null) {
          vm.setTtdTimFormatur(index, file.path);
        }
      },
      onRemove: () => vm.setTtdTimFormatur(index, null),
    );
  }
}
