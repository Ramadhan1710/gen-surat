import 'package:flutter/material.dart';
import 'package:gen_surat/core/models/form_field_model.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/utils/mixins/focus_scroll_mixin.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/permohonan_pengesahan/fields/step_permohonan_pengesahan_fields.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/permohonan_pengesahan/surat_permohonan_pengesahan_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/focus_form_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';

/// Widget untuk step 3: Informasi Kepengurusan
class StepKepengurusanSection extends StatefulWidget {
  final SuratPermohonanPengesahanIpnuViewmodel viewModel;

  const StepKepengurusanSection({super.key, required this.viewModel});

  @override
  State<StepKepengurusanSection> createState() => _StepKepengurusanSectionState();
}

class _StepKepengurusanSectionState extends State<StepKepengurusanSection> with FocusScrollMixin {
  late final ScrollController _scrollController;
  late final List<FormFieldModel> fields;

  @override
  void initState() {
    _scrollController = ScrollController();
    fields = StepPermohonanPengesahanFields.buildKepengurusanField(widget.viewModel);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: _scrollController,
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Informasi Kepengurusan'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Masukkan informasi tentang kepengurusan yang akan disahkan.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ), 
        ),
        const SizedBox(height: AppDimensions.spaceL),
        FocusFormField(
          fields: fields,
          onNext: goNextField,
        ),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }
}
