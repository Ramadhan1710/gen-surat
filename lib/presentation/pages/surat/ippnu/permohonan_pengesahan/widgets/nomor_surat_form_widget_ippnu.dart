import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';
import 'package:gen_surat/core/validator/ui_field_validators.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';

class NomorSuratFormWidgetIppnu extends StatefulWidget {
  final TextEditingController nomorSuratController;
  final String? Function(String?)? validator;

  const NomorSuratFormWidgetIppnu({
    super.key,
    required this.nomorSuratController,
    this.validator,
  });

  @override
  State<NomorSuratFormWidgetIppnu> createState() =>
      _NomorSuratFormWidgetIppnuState();
}

class _NomorSuratFormWidgetIppnuState extends State<NomorSuratFormWidgetIppnu> {
  final _nomorUrutController = TextEditingController();
  final _jenisLembagaController = TextEditingController();
  final _nomorPeriodeController = TextEditingController();

  String _bulanRomawi = '';
  String _tahunDuaDigit = '';
  String _previewNomorSurat = '';

  @override
  void initState() {
    super.initState();
    _initializeAutoFields();
    _setupListeners();

    // Parse existing nomor surat if any
    if (widget.nomorSuratController.text.isNotEmpty) {
      _parseNomorSurat(widget.nomorSuratController.text);
    }
  }

  void _initializeAutoFields() {
    final now = DateTime.now();
    _bulanRomawi = _convertToRoman(now.month);
    _tahunDuaDigit = (now.year % 100).toString().padLeft(2, '0');
  }

  void _setupListeners() {
    _nomorUrutController.addListener(_updateNomorSurat);
    _jenisLembagaController.addListener(_updateNomorSurat);
    _nomorPeriodeController.addListener(_updateNomorSurat);
  }

  void _updateNomorSurat() {
    final parts = <String>[];

    // Nomor Urut
    if (_nomorUrutController.text.isNotEmpty) {
      parts.add(_nomorUrutController.text.padLeft(2, '0'));
    }

    // Jenis Lembaga
    if (_jenisLembagaController.text.isNotEmpty) {
      parts.add(_jenisLembagaController.text.toUpperCase());
    }

    // A (fixed)
    parts.add('A');

    // Nomor Periode
    if (_nomorPeriodeController.text.isNotEmpty) {
      parts.add(_nomorPeriodeController.text.toUpperCase());
    }

    // 7455 (fixed for IPPNU)
    parts.add('7455');

    // Bulan (auto)
    parts.add(_bulanRomawi);

    // Tahun (auto)
    parts.add(_tahunDuaDigit);

    setState(() {
      _previewNomorSurat = parts.join('/');
      widget.nomorSuratController.text = _previewNomorSurat;
    });
  }

  void _parseNomorSurat(String nomorSurat) {
    final parts = nomorSurat.split('/');
    if (parts.length >= 7) {
      _nomorUrutController.text = parts[0];
      _jenisLembagaController.text = parts[1];
      _nomorPeriodeController.text = parts[3];
    }
  }

  String _convertToRoman(int month) {
    const romanNumerals = [
      'I',
      'II',
      'III',
      'IV',
      'V',
      'VI',
      'VII',
      'VIII',
      'IX',
      'X',
      'XI',
      'XII',
    ];
    return month >= 1 && month <= 12 ? romanNumerals[month - 1] : '';
  }

  @override
  void dispose() {
    _nomorUrutController.dispose();
    _jenisLembagaController.dispose();
    _nomorPeriodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nomor Surat *',
          style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),

        // Preview Nomor Surat
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.ippnuPrimaryLight.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.ippnuPrimaryLight.withValues(alpha: 0.5),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.preview, color: AppColors.ippnuPrimaryDark, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _previewNomorSurat.isEmpty
                      ? 'Preview nomor surat akan muncul di sini'
                      : _previewNomorSurat,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color:
                        _previewNomorSurat.isEmpty
                            ? AppColors.grey
                            : AppColors.ippnuPrimaryDark,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Form Fields
        CustomTextField(
          controller: _nomorUrutController,
          helpText: 'Nomor urut surat, Contoh: 001',
          icon: Icons.format_list_numbered,
          label: 'Nomor Urut *',
          hint: 'Masukkan nomor urut',
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(2),
          ],
          validator: UiFieldValidators.required('Nomor urut'),
        ),
        const SizedBox(height: 12),
        _buildDropdownField(
          controller: _jenisLembagaController,
          label: 'Tingkatan Pimpinan *',
          hint: 'Pilih Tingkatan Pimpinan',
          items: const ['PR', 'PK'],
          itemLabels: const {'PR': 'PR (Ranting)', 'PK': 'PK (Komisariat)'},
          validator: UiFieldValidators.required('Tingkatan pimpinan'),
        ),
        const SizedBox(height: 12),
        CustomTextField(
          controller: _nomorPeriodeController,
          icon: Icons.confirmation_number,
          label: 'Nomor Periode',
          helpText: 'Nomor periode kepengurusan, Contoh: XXV',
          hint: 'Masukkan nomor periode',
          validator: UiFieldValidators.required('Nomor periode'),
          textCapitalization: TextCapitalization.characters,
          textInputAction: TextInputAction.done,
          inputFormatters: [LengthLimitingTextInputFormatter(5)],
        ),
        const SizedBox(height: 12),

        // Auto-filled fields (read-only display)
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: theme.colorScheme.onSurface,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Terisi Otomatis',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: [
                  _buildInfoChip(context, 'Kategori', 'A (Internal)'),
                  _buildInfoChip(context, 'Kode IPPNU', '7455'),
                  _buildInfoChip(context, 'Bulan', _bulanRomawi),
                  _buildInfoChip(context, 'Tahun', _tahunDuaDigit),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // Format explanation
        Container(
          padding: const EdgeInsets.all(8),
          child: Text(
            'Format: [No.Urut]/[Jenis]/A/[Periode]/7455/[Bulan]/[Tahun]\nContoh: 01/PR/A/XXV/7455/VIII/23',
            style: AppTextStyles.bodySmall.copyWith(
              color: theme.colorScheme.onSurface,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required List<String> items,
    required Map<String, String> itemLabels,
    required String? Function(String?)? validator,
    IconData? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          value: controller.text.isEmpty ? null : controller.text,
          style: AppTextStyles.bodyMedium,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          items:
              items.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(
                    itemLabels[item] ?? item,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                );
              }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                controller.text = value;
              });
            }
          },
        ),
      ],
    );
  }

  Widget _buildInfoChip(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label: ',
              style: AppTextStyles.bodySmall.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            TextSpan(
              text: value,
              style: AppTextStyles.bodySmall.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
