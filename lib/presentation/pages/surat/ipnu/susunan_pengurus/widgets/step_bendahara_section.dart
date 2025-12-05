import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/susunan_pengurus/susunan_pengurus_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';

class StepBendaharaSection extends StatelessWidget {
  final SusunanPengurusIpnuViewmodel viewModel;

  const StepBendaharaSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
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
          textInputAction: TextInputAction.next,
          hint: 'Masukkan nama bendahara',
          validator: UiFieldValidators.required('Nama bendahara'),
        ),
        const SizedBox(height: AppDimensions.spaceM),

        CustomTextField(
          controller: viewModel.formDataManager.alamatBendaharaController,
          label: 'Alamat Bendahara *',
          helpText: 'Alamat bendahara, \nContoh: Desa Ngepeh/Dusun Mojosari',
          textCapitalization: TextCapitalization.words,
          focusNode: viewModel.formDataManager.alamatBendaharaFocus,
          textInputAction: TextInputAction.next,
          hint: 'Masukkan alamat bendahara',
          maxLines: 2,
          validator: UiFieldValidators.required('Alamat bendahara'),
        ),

        const SizedBox(height: AppDimensions.spaceM),
        const Divider(),
        const SizedBox(height: AppDimensions.spaceM),

        // ========== WAKIL BENDAHARA SECTION ==========
        const SectionHeader(title: 'Wakil Bendahara (Opsional)'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan data wakil bendahara pimpinan (opsional).',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceM),

        CustomTextField(
          controller: viewModel.formDataManager.namaWakilBendController,
          label: 'Nama Wakil Bendahara',
          helpText: 'Nama lengkap wakil bendahara',
          textCapitalization: TextCapitalization.words,
          hint: 'Masukkan nama wakil bendahara',
        ),
        const SizedBox(height: AppDimensions.spaceM),

        CustomTextField(
          controller: viewModel.formDataManager.alamatWakilBendController,
          label: 'Alamat Wakil Bendahara',
          helpText: 'Alamat wakil bendahara, \nContoh: Desa Ngepeh/Dusun Mojosari',
          textCapitalization: TextCapitalization.words,
          hint: 'Masukkan alamat wakil bendahara',
          maxLines: 2,
        ),

        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }
}
