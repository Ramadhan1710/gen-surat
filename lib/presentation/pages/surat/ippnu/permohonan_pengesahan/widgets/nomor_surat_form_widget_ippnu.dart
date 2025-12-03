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
    if (_nomorUrutController.text.isEmpty ||
        _jenisLembagaController.text.isEmpty ||
        _nomorPeriodeController.text.isEmpty) {
      setState(() {
        _previewNomorSurat = '';
      });
      widget.nomorSuratController.text = '';
      return;
    }

    // Format: 01/PR/A/7455/X/II/2023
    // atau: 01/PK/A/7455/X/II/2023
    final nomorSurat =
        '${_nomorUrutController.text}/${_jenisLembagaController.text}/A/7455/${_nomorPeriodeController.text}/$_bulanRomawi/$_tahunDuaDigit';

    setState(() {
      _previewNomorSurat = nomorSurat;
    });

    widget.nomorSuratController.text = nomorSurat;
  }

  void _parseNomorSurat(String nomorSurat) {
    final parts = nomorSurat.split('/');
    if (parts.length >= 7) {
      _nomorUrutController.text = parts[0];
      _jenisLembagaController.text = parts[1];
      _nomorPeriodeController.text = parts[4];
      _updateNomorSurat();
    }
  }

  String _convertToRoman(int number) {
    const romanNumerals = [
      ['', 'I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX'],
      ['', 'X', 'XX', 'XXX', 'XL', 'L', 'LX', 'LXX', 'LXXX', 'XC'],
    ];

    if (number < 1 || number > 12) return '';

    int tens = number ~/ 10;
    int ones = number % 10;

    return romanNumerals[1][tens] + romanNumerals[0][ones];
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
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Untuk PR: 01/PR/A/7455/X/II/2023, Untuk PK: 01/PK/A/7455/X/II/2023',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 12),
        CustomTextField(
          controller: _nomorUrutController,
          label: 'Nomor Urut',
          helpText: 'Nomor urut surat, Contoh: 01, 02, 03',
          hint: 'Masukkan nomor urut',
          keyboardType: TextInputType.number,
          validator: UiFieldValidators.required('Nomor urut'),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(2),
          ],
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 12),
        CustomTextField(
          controller: _jenisLembagaController,
          label: 'Tingkatan Lembaga',
          helpText: 'PR untuk Pimpinan Ranting, PK untuk Pimpinan Komisariat',
          hint: 'Pilih tingkatan lembaga',
          validator: UiFieldValidators.required('Tingkatan lembaga'),
          textCapitalization: TextCapitalization.characters,
          textInputAction: TextInputAction.next,
          inputFormatters: [LengthLimitingTextInputFormatter(2)],
        ),
        const SizedBox(height: 12),
        CustomTextField(
          controller: _nomorPeriodeController,
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

        if (_previewNomorSurat.isNotEmpty) ...[
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.ippnuPrimaryLight.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.ippnuPrimaryDark),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Preview Nomor Surat:',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _previewNomorSurat,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.ippnuPrimaryDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildInfoChip(BuildContext context, String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label: ',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.6),
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
