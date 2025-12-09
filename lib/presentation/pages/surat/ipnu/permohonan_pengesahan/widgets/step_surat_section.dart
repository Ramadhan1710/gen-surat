import 'package:flutter/material.dart';
import 'package:gen_surat/core/models/form_field_model.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/utils/mixins/focus_scroll_mixin.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/permohonan_pengesahan/fields/step_permohonan_pengesahan_fields.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/permohonan_pengesahan/surat_permohonan_pengesahan_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/focus_form_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/permohonan_pengesahan/widgets/nomor_surat_form_widget.dart';

/// Widget untuk step 2: Informasi Surat
class StepSuratSection extends StatefulWidget {
  final SuratPermohonanPengesahanIpnuViewmodel viewModel;

  const StepSuratSection({
    super.key,
    required this.viewModel,
  });

  @override
  State<StepSuratSection> createState() => _StepSuratSectionState();
}

class _StepSuratSectionState extends State<StepSuratSection> with FocusScrollMixin {
  late final ScrollController _scrollController;
  late final List<FormFieldModel> fields;

  @override
  void initState() {
    _scrollController = ScrollController();
    fields = StepPermohonanPengesahanFields.buildSuratField(widget.viewModel);  
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: _scrollController,
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Informasi Surat'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan informasi terkait surat permohonan pengesahan dan tanggal rapat.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
        ),
        const SizedBox(height: AppDimensions.spaceL),
        NomorSuratFormWidget(
          nomorSuratController: widget.viewModel.formDataManager.nomorSuratController,
          validator: UiFieldValidators.required('Nomor surat'),
        ),
        FocusFormField(
          fields: fields,
          onNext: goNextField,
        ),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }
}
