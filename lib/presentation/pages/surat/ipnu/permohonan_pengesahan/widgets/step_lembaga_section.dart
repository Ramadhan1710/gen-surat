import 'package:flutter/material.dart';
import 'package:gen_surat/core/models/form_field_model.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/utils/mixins/focus_scroll_mixin.dart';
import 'package:gen_surat/presentation/pages/surat/ipnu/permohonan_pengesahan/fields/step_permohonan_pengesahan_fields.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ipnu/permohonan_pengesahan/surat_permohonan_pengesahan_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/focus_form_field.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';

class StepLembagaSection extends StatefulWidget {
  final SuratPermohonanPengesahanIpnuViewmodel viewModel;

  const StepLembagaSection({super.key, required this.viewModel});

  @override
  State<StepLembagaSection> createState() => _StepLembagaSectionState();
}

class _StepLembagaSectionState extends State<StepLembagaSection>
    with FocusScrollMixin {
  late final ScrollController _scrollController;
  late final List<FormFieldModel> fields;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    fields = StepPermohonanPengesahanFields.buildLembagaField(widget.viewModel);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      controller: _scrollController,
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Informasi Pimpinan'),
        const SizedBox(height: AppDimensions.spaceS),

        Text(
          'Masukkan informasi lengkap tentang pimpinan yang mengajukan surat permohonan pengesahan.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),

        const SizedBox(height: AppDimensions.spaceL),

        FocusFormField(fields: fields, onNext: goNextField),

        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }
}
