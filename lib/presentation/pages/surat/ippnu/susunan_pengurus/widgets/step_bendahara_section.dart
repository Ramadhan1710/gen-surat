import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/susunan_pengurus/susunan_pengurus_ippnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';

class StepBendaharaSection extends StatelessWidget {
  final SusunanPengurusIppnuViewmodel viewModel;

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
          icon: Icons.person,
          textCapitalization: TextCapitalization.words,
          focusNode: viewModel.formDataManager.namaBendaharaFocus,
          textInputAction: TextInputAction.next,
          hint: 'Masukkan nama bendahara',
          validator: UiFieldValidators.required('Nama bendahara'),
        ),

        const SizedBox(height: AppDimensions.spaceM),
        const Divider(),
        const SizedBox(height: AppDimensions.spaceM),

        // ========== WAKIL BENDAHARA SECTION ==========
        const SectionHeader(title: 'Wakil Bendahara'),
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
          helpText: 'Nama lengkap wakil bendahara (opsional)',
          icon: Icons.person,
          textCapitalization: TextCapitalization.words,
          focusNode: viewModel.formDataManager.namaWakilBendFocus,
          textInputAction: TextInputAction.done,
          hint: 'Masukkan nama wakil bendahara',
        ),

        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }
}
