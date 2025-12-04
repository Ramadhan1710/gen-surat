import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/berita_acara_formatur_pembentukan_pengurus_harian/berita_acara_formatur_pembentukan_pengurus_harian_ippnu_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/berita_acara_formatur_pembentukan_pengurus_harian/enum/berita_acara_formatur_pembentukan_pengurus_harian_form_step.dart';
import 'package:gen_surat/presentation/widgets/review/review_widgets.dart';
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
        ReviewSectionCard(
          title: 'Informasi Lembaga',
          icon: Icons.business,
          color: AppColors.ippnuPrimary,
          onEdit:
              () => viewModel.jumpToStep(
                BeritaAcaraFormaturPembentukanPengurusHarianFormStep
                    .informasiLembaga,
              ),
          children: [
            ReviewInfoRow(
              label: 'Tingkatan Lembaga',
              value: viewModel.formDataManager.jenisLembagaController.text,
            ),
            ReviewInfoRow(
              label: 'Nama Desa/Sekolah',
              value: viewModel.formDataManager.namaLembagaController.text,
            ),
            ReviewInfoRow(
              label: 'Periode Kepengurusan',
              value: viewModel.formDataManager.periodeKepengurusanController.text,
            ),
            ReviewInfoRow(
              label: 'Tingkat Lembaga',
              value: viewModel.formDataManager.tingkatLembagaController.text,
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spaceM),

        // Data Formatur
        ReviewSectionCard(
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
              const ReviewEmptyState(message: 'Belum ada formatur')
            else
              ...viewModel.formDataManager.formatur.asMap().entries.map(
                (entry) => ReviewPersonCard(
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
        ReviewSectionCard(
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
            const ReviewSubHeader(
              title: 'Pelindung:',
              color: AppColors.ippnuPrimaryDark,
            ),
            if (viewModel.formDataManager.pelindung.isEmpty)
              const ReviewEmptyState(message: 'Belum ada pelindung')
            else
              ...viewModel.formDataManager.pelindung.asMap().entries.map(
                (entry) => ReviewBulletPoint(
                  text: '${entry.key + 1}. ${entry.value.namaController.text}',
                ),
              ),
            const SizedBox(height: AppDimensions.spaceM),

            // Pembina
            const ReviewSubHeader(
              title: 'Pembina:',
              color: AppColors.ippnuPrimaryDark,
            ),
            if (viewModel.formDataManager.pembina.isEmpty)
              const ReviewEmptyState(message: 'Belum ada pembina')
            else
              ...viewModel.formDataManager.pembina.asMap().entries.map(
                (entry) => ReviewBulletPoint(
                  text: '${entry.key + 1}. ${entry.value.namaController.text}',
                ),
              ),
          ],
        ),
        const SizedBox(height: AppDimensions.spaceM),

        // Pengurus Inti
        ReviewSectionCard(
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
            const ReviewSubHeader(
              title: 'Ketua',
              color: AppColors.ippnuSecondaryLight,
            ),
            ReviewInfoRow(
              label: 'Nama',
              value: viewModel.formDataManager.namaKetuaController.text,
            ),
            const SizedBox(height: AppDimensions.spaceM),

            // Wakil Ketua
            const ReviewSubHeader(
              title: 'Wakil Ketua',
              color: AppColors.ippnuSecondaryLight,
            ),
            if (viewModel.formDataManager.wakilKetua.isEmpty)
              const ReviewEmptyState(message: 'Belum ada wakil ketua')
            else
              ...viewModel.formDataManager.wakilKetua.map(
                (wakil) => ReviewBulletPoint(
                  text: '${wakil.titleController.text}: ${wakil.namaController.text}',
                ),
              ),
            const SizedBox(height: AppDimensions.spaceM),

            // Sekretaris
            const ReviewSubHeader(
              title: 'Sekretaris',
              color: AppColors.ippnuSecondaryLight,
            ),
            ReviewInfoRow(
              label: 'Nama',
              value: viewModel.formDataManager.namaSekretarisController.text,
            ),
            const SizedBox(height: AppDimensions.spaceM),

            // Wakil Sekretaris (Optional)
            const ReviewSubHeader(
              title: 'Wakil Sekretaris (Opsional)',
              color: AppColors.ippnuSecondaryLight,
            ),
            if (viewModel.formDataManager.wakilSekretaris.isEmpty)
              const ReviewEmptyState(message: 'Tidak ada wakil sekretaris')
            else
              ...viewModel.formDataManager.wakilSekretaris.map(
                (wakil) => ReviewBulletPoint(
                  text: '${wakil.titleController.text}: ${wakil.namaController.text}',
                ),
              ),
            const SizedBox(height: AppDimensions.spaceM),

            // Bendahara
            const ReviewSubHeader(
              title: 'Bendahara',
              color: AppColors.ippnuSecondaryLight,
            ),
            ReviewInfoRow(
              label: 'Nama',
              value: viewModel.formDataManager.namaBendaharaController.text,
            ),
            if (viewModel
                .formDataManager
                .namaWakilBendController
                .text
                .isNotEmpty) ...[
              ReviewInfoRow(
                label: 'Wakil Bendahara',
                value: viewModel.formDataManager.namaWakilBendController.text,
              ),
            ],
          ],
        ),
        const SizedBox(height: AppDimensions.spaceM),

        // Penetapan
        ReviewSectionCard(
          title: 'Penetapan',
          icon: Icons.event,
          color: AppColors.documentTeal,
          onEdit:
              () => viewModel.jumpToStep(
                BeritaAcaraFormaturPembentukanPengurusHarianFormStep.penetapan,
              ),
          children: [
            ReviewInfoRow(
              label: 'Tanggal Penyusunan',
              value: viewModel.formDataManager.tanggalPenyusunanController.text,
            ),
            ReviewInfoRow(
              label: 'Tempat Penyusunan',
              value: viewModel.formDataManager.tempatPenyusunanController.text,
            ),
            ReviewInfoRow(
              label: 'Nama Wilayah',
              value: viewModel.formDataManager.namaWilayahController.text,
            ),
            ReviewInfoRow(
              label: 'Tanggal Hijriah',
              value: viewModel.formDataManager.tanggalHijriahController.text,
            ),
            ReviewInfoRow(
              label: 'Tanggal Masehi',
              value: viewModel.formDataManager.tanggalMasehiController.text,
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spaceXXL),
      ],
    );
  }
}
