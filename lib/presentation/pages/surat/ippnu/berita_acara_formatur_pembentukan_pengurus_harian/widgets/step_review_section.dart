import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/berita_acara_formatur_pembentukan_pengurus_harian/berita_acara_formatur_pembentukan_pengurus_harian_ippnu_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/berita_acara_formatur_pembentukan_pengurus_harian/enum/berita_acara_formatur_pembentukan_pengurus_harian_form_step.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';

class StepReviewSection extends StatelessWidget {
  final BeritaAcaraFormaturPembentukanPengurusHarianIppnuViewmodel viewModel;

  const StepReviewSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      children: [
        const SectionHeader(title: 'Review Data'),
        const SizedBox(height: AppDimensions.spaceS),
        Text(
          'Silakan periksa kembali semua data yang telah Anda masukkan sebelum generate dokumen.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceL),

        // Informasi Lembaga
        _buildSectionCard(
          context: context,
          title: 'Informasi Lembaga',
          icon: Icons.business,
          color: AppColors.ippnuPrimary,
          onEdit:
              () => viewModel.jumpToStep(
                BeritaAcaraFormaturPembentukanPengurusHarianFormStep
                    .informasiLembaga,
              ),
          children: [
            _buildInfoRow(
              'Tingkatan Lembaga',
              viewModel.formDataManager.jenisLembagaController.text,
              context,
            ),
            _buildInfoRow(
              'Nama Desa/Sekolah',
              viewModel.formDataManager.namaLembagaController.text,
              context,
            ),
            _buildInfoRow(
              'Periode Kepengurusan',
              viewModel.formDataManager.periodeKepengurusanController.text,
              context,
            ),
            _buildInfoRow(
              'Tingkat Lembaga',
              viewModel.formDataManager.tingkatLembagaController.text,
              context,
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spaceM),

        // Data Formatur
        _buildSectionCard(
          context: context,
          title: 'Tim Formatur',
          icon: Icons.groups,
          color: AppColors.ippnuAccent,
          onEdit:
              () => viewModel.jumpToStep(
                BeritaAcaraFormaturPembentukanPengurusHarianFormStep
                    .dataFormatur,
              ),
          children: [
            if (viewModel.formDataManager.formatur.isEmpty)
              _buildEmptyState('Belum ada formatur')
            else
              ...viewModel.formDataManager.formatur.asMap().entries.map(
                (entry) => _buildPersonCard(
                  context: context,
                  number: entry.key + 1,
                  name: entry.value.namaController.text,
                  role: entry.value.jabatanController.text,
                  hasSignature: entry.value.ttd != null,
                ),
              ),
          ],
        ),
        const SizedBox(height: AppDimensions.spaceM),

        // Pelindung & Pembina
        _buildSectionCard(
          context: context,
          title: 'Pelindung & Pembina',
          icon: Icons.shield,
          color: AppColors.ippnuPrimaryLight,
          onEdit:
              () => viewModel.jumpToStep(
                BeritaAcaraFormaturPembentukanPengurusHarianFormStep
                    .dataPelindungPembina,
              ),
          children: [
            // Pelindung
            Padding(
              padding: const EdgeInsets.only(bottom: AppDimensions.spaceS),
              child: Text(
                'Pelindung:',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.ippnuPrimaryDark,
                ),
              ),
            ),
            if (viewModel.formDataManager.pelindung.isEmpty)
              _buildEmptyState('Belum ada pelindung')
            else
              ...viewModel.formDataManager.pelindung.asMap().entries.map(
                (entry) => _buildBulletPoint(
                  context,
                  '${entry.key + 1}. ${entry.value.namaController.text}',
                ),
              ),
            const SizedBox(height: AppDimensions.spaceM),

            // Pembina
            Padding(
              padding: const EdgeInsets.only(bottom: AppDimensions.spaceS),
              child: Text(
                'Pembina:',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.ippnuPrimaryDark,
                ),
              ),
            ),
            if (viewModel.formDataManager.pembina.isEmpty)
              _buildEmptyState('Belum ada pembina')
            else
              ...viewModel.formDataManager.pembina.asMap().entries.map(
                (entry) => _buildBulletPoint(
                  context,
                  '${entry.key + 1}. ${entry.value.namaController.text}',
                ),
              ),
          ],
        ),
        const SizedBox(height: AppDimensions.spaceM),

        // Pengurus Inti
        _buildSectionCard(
          context: context,
          title: 'Pengurus Inti',
          icon: Icons.people,
          color: AppColors.ippnuSecondary,
          onEdit:
              () => viewModel.jumpToStep(
                BeritaAcaraFormaturPembentukanPengurusHarianFormStep
                    .dataPengurusInti,
              ),
          children: [
            // Ketua
            _buildSubHeader(context, 'Ketua', AppColors.ippnuSecondaryLight),
            _buildInfoRow(
              'Nama',
              viewModel.formDataManager.namaKetuaController.text,
              context,
            ),
            const SizedBox(height: AppDimensions.spaceM),

            // Wakil Ketua
            _buildSubHeader(
              context,
              'Wakil Ketua',
              AppColors.ippnuSecondaryLight,
            ),
            if (viewModel.formDataManager.wakilKetua.isEmpty)
              _buildEmptyState('Belum ada wakil ketua')
            else
              ...viewModel.formDataManager.wakilKetua.map(
                (wakil) => _buildBulletPoint(
                  context,
                  '${wakil.titleController.text}: ${wakil.namaController.text}',
                ),
              ),
            const SizedBox(height: AppDimensions.spaceM),

            // Sekretaris
            _buildSubHeader(
              context,
              'Sekretaris',
              AppColors.ippnuSecondaryLight,
            ),
            _buildInfoRow(
              'Nama',
              viewModel.formDataManager.namaSekretarisController.text,
              context,
            ),
            const SizedBox(height: AppDimensions.spaceM),

            // Wakil Sekretaris (Optional)
            _buildSubHeader(
              context,
              'Wakil Sekretaris (Opsional)',
              AppColors.ippnuSecondaryLight,
            ),
            if (viewModel.formDataManager.wakilSekretaris.isEmpty)
              _buildEmptyState('Tidak ada wakil sekretaris')
            else
              ...viewModel.formDataManager.wakilSekretaris.map(
                (wakil) => _buildBulletPoint(
                  context,
                  '${wakil.titleController.text}: ${wakil.namaController.text}',
                ),
              ),
            const SizedBox(height: AppDimensions.spaceM),

            // Bendahara
            _buildSubHeader(
              context,
              'Bendahara',
              AppColors.ippnuSecondaryLight,
            ),
            _buildInfoRow(
              'Nama',
              viewModel.formDataManager.namaBendaharaController.text,
              context,
            ),
            if (viewModel
                .formDataManager
                .namaWakilBendController
                .text
                .isNotEmpty) ...[
              _buildInfoRow(
                'Wakil Bendahara',
                viewModel.formDataManager.namaWakilBendController.text,
                context,
              ),
            ],
          ],
        ),
        const SizedBox(height: AppDimensions.spaceM),

        // Penetapan
        _buildSectionCard(
          context: context,
          title: 'Penetapan',
          icon: Icons.event,
          color: AppColors.documentTeal,
          onEdit:
              () => viewModel.jumpToStep(
                BeritaAcaraFormaturPembentukanPengurusHarianFormStep.penetapan,
              ),
          children: [
            _buildInfoRow(
              'Tanggal Penyusunan',
              viewModel.formDataManager.tanggalPenyusunanController.text,
              context,
            ),
            _buildInfoRow(
              'Tempat Penyusunan',
              viewModel.formDataManager.tempatPenyusunanController.text,
              context,
            ),
            _buildInfoRow(
              'Nama Wilayah',
              viewModel.formDataManager.namaWilayahController.text,
              context,
            ),
            _buildInfoRow(
              'Tanggal Hijriah',
              viewModel.formDataManager.tanggalHijriahController.text,
              context,
            ),
            _buildInfoRow(
              'Tanggal Masehi',
              viewModel.formDataManager.tanggalMasehiController.text,
              context,
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }

  Widget _buildSectionCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onEdit,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color.withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spaceM,
              vertical: AppDimensions.spaceS,
            ),
            child: Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: AppDimensions.spaceS),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onEdit,
                  icon: Icon(Icons.edit, color: color, size: 20),
                  tooltip: 'Edit $title',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(AppDimensions.spaceM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.spaceS),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: AppTextStyles.labelMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          Text(
            ':',
            style: AppTextStyles.labelMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: AppDimensions.spaceS),
          Expanded(
            flex: 3,
            child: Text(
              value.isEmpty ? '-' : value,
              style: AppTextStyles.labelMedium.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonCard({
    required BuildContext context,
    required int number,
    required String name,
    required String role,
    required bool hasSignature,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceS),
      padding: const EdgeInsets.all(AppDimensions.spaceS),
      decoration: BoxDecoration(
        color: AppColors.ippnuAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.ippnuAccent.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.ippnuAccent,
            radius: 16,
            child: Text(
              '$number',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: AppDimensions.spaceS),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  role,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
          Icon(
            hasSignature ? Icons.check_circle : Icons.cancel,
            color: hasSignature ? AppColors.success : AppColors.error,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }

  Widget _buildSubHeader(BuildContext context, String title, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.spaceS),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.spaceS),
      child: Text(
        message,
        style: TextStyle(
          color: Colors.grey.shade600,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
