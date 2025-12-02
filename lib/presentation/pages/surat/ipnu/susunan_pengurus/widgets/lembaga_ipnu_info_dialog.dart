import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';

/// Dialog informasi untuk menampilkan daftar lembaga IPNU beserta strukturnya
class LembagaIpnuInfoDialog extends StatelessWidget {
  const LembagaIpnuInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusL)),
      insetPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spaceL,
        vertical: AppDimensions.spaceL,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context),
          Flexible(child: _buildContent(context)),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spaceL),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: theme.colorScheme.onPrimaryContainer,
            size: 28,
          ),
          const SizedBox(width: AppDimensions.spaceM),
          Expanded(
            child: Text(
              'Informasi Lembaga IPNU',
              style: AppTextStyles.titleLarge.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.close,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.radiusM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIntroductionSection(context),
          const SizedBox(height: AppDimensions.spaceL),
          _buildMandatorySection(context),
          const SizedBox(height: AppDimensions.spaceL),
          _buildLembagaList(context),
        ],
      ),
    );
  }

  Widget _buildIntroductionSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      decoration: BoxDecoration(
        color: AppColors.info.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.info.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline, color: AppColors.info, size: 20),
              const SizedBox(width: AppDimensions.spaceS),
              Text(
                'Tentang Lembaga IPNU',
                style: AppTextStyles.titleSmall.copyWith(
                  color: AppColors.info,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceS),
          Text(
            'Lembaga adalah unit organisasi di IPNU yang memiliki fungsi khusus sesuai bidangnya. Setiap lembaga dipimpin oleh seorang Direktur dan dibantu oleh Sekretaris serta anggota-anggota.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.9),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMandatorySection(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      decoration: BoxDecoration(
        color: isDark ? AppColors.warning.withOpacity(0.3) : AppColors.warning.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
        border: Border.all(color: isDark ? AppColors.warning.withOpacity(0.6) : AppColors.warning.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.star, color: AppColors.warning, size: 20),
          const SizedBox(width: AppDimensions.spaceS),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lembaga Wajib',
                  style: AppTextStyles.titleSmall.copyWith(
                    color: AppColors.warning,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppDimensions.spaceS),
                Text(
                  'Lembaga Pers dan Penerbitan adalah lembaga yang wajib ada. Lembaga lainnya bersifat opsional sesuai kebutuhan.',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.9),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLembagaList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Daftar Lembaga di IPNU',
          style: AppTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimensions.spaceM),
        _buildLembagaCard(
          context,
          title: '1. Lembaga Pers dan Penerbitan',
          isMandatory: true,
          structure: [
            'Direktur: Memimpin kegiatan pers dan penerbitan',
            'Sekretaris: Membantu administrasi lembaga',
            'Anggota: Minimal 1 orang, maksimal 6 orang',
          ],
        ),
        const SizedBox(height: AppDimensions.spaceM),
        _buildLembagaCard(
          context,
          title: '2. Lembaga Ekonomi, Kewirausahaan dan Koperasi (LEKAS)',
          isMandatory: false,
          structure: [
            'Direktur: Memimpin kegiatan ekonomi dan kewirausahaan',
            'Sekretaris: Membantu administrasi lembaga',
            'Anggota: Bersifat opsional',
          ],
        ),
        const SizedBox(height: AppDimensions.spaceM),
        _buildLembagaCard(
          context,
          title: '3. Lembaga Corp Brigade Pembangunan (CBP)',
          isMandatory: false,
          structure: [
            'Komandan: Memimpin lembaga',
            'Wakil Komandan: Dapat lebih dari satu orang',
            'Divisi-divisi: Administrasi, Pendidikan & Pelatihan, Kemanusiaan',
            'Koordinator & Anggota: Setiap divisi memiliki koordinator dan anggota',
          ],
          note:
              'Lembaga CBP memiliki struktur khusus dengan sistem komando dan divisi.',
        ),
      ],
    );
  }

  Widget _buildLembagaCard(
    BuildContext context, {
    required String title,
    required bool isMandatory,
    required List<String> structure,
    String? note,
  }) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color:
              isMandatory
                  ? AppColors.warning.withOpacity(0.5)
                  : theme.colorScheme.outline.withOpacity(0.3),
          width: isMandatory ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.titleSmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
              if (isMandatory)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.spaceS,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.warning,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'WAJIB',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceS),
          const Divider(),
          const SizedBox(height: AppDimensions.spaceS),
          Text(
            'Struktur:',
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          ...structure.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_right_rounded,
                    size: 16,
                    color: theme.colorScheme.onSurface.withOpacity(0.8),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.spaceS),
          if (note != null) ...[
            const SizedBox(height: 4),
            Text(
              note,
              style: AppTextStyles.bodySmall.copyWith(
                fontStyle: FontStyle.italic,
                color: AppColors.info,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spaceL),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: theme.colorScheme.outline.withOpacity(0.2)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FilledButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.check),
            label: const Text('Mengerti'),
          ),
        ],
      ),
    );
  }

  /// Static method untuk menampilkan dialog
  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => const LembagaIpnuInfoDialog(),
    );
  }
}
