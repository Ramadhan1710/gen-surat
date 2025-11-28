import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';

class NomorSuratFormWidget extends StatefulWidget {
  final TextEditingController nomorSuratController;
  final String? Function(String?)? validator;

  const NomorSuratFormWidget({
    super.key,
    required this.nomorSuratController,
    this.validator,
  });

  @override
  State<NomorSuratFormWidget> createState() => _NomorSuratFormWidgetState();
}

class _NomorSuratFormWidgetState extends State<NomorSuratFormWidget> {
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
      parts.add(_nomorUrutController.text.padLeft(3, '0'));
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

    // 7354 (fixed for IPNU)
    parts.add('7354');

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
            color: AppColors.info.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.info.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              const Icon(Icons.preview, color: AppColors.info, size: 20),
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
                            : AppColors.info,
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
          label: 'Nomor Urut *',
          hint: 'Masukkan nomor urut',
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(3),
          ],
          validator: _requiredValidator('Nomor urut'),
        ),
        const SizedBox(height: 12),
        _buildDropdownField(
          controller: _jenisLembagaController,
          label: 'Jenis Lembaga',
          hint: 'Pilih jenis lembaga',
          items: const ['PR', 'PK'],
          itemLabels: const {'PR': 'PR (Ranting)', 'PK': 'PK (Komisariat)'},
          validator: _requiredValidator('Jenis lembaga'),
        ),
        const SizedBox(height: 12),
        CustomTextField(
          controller: _nomorPeriodeController,
          label: 'Nomor Periode',
          helpText: 'Nomor periode kepengurusan, Contoh: XXV',
          hint: 'Masukkan nomor periode',
          textCapitalization: TextCapitalization.characters,
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
                  _buildInfoChip(context, 'Kode IPNU', '7354'),
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
            'Format: [No.Urut]/[Jenis]/A/[Periode]/7354/[Bulan]/[Tahun]\nContoh: 001/PR/A/XXV/7354/VIII/23',
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
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w500),
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

  String? Function(String?) _requiredValidator(String fieldName) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return '$fieldName wajib diisi';
      }
      return null;
    };
  }
}
