import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_colors.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/berita_acara_penyusunan_pengurus/berita_acara_penyusunan_pengurus_ippnu_viewmodel.dart';
import 'package:gen_surat/presentation/viewmodels/surat/ippnu/berita_acara_penyusunan_pengurus/enum/berita_acara_penyusunan_pengurus_ippnu_form_step.dart';
import 'package:gen_surat/presentation/widgets/review/review_widgets.dart';
import 'package:gen_surat/presentation/widgets/section_header.dart';

class StepReviewSection extends StatelessWidget {
  final BeritaAcaraPenyusunanPengurusIppnuViewmodel viewModel;

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
                color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
        ),
        const SizedBox(height: AppDimensions.spaceL),

        // Informasi Lembaga
        ReviewSectionCard(
          title: 'Informasi Pimpinan',
          icon: Icons.business,
          color: AppColors.ippnuPrimary,
          onEdit:
              () => viewModel.jumpToStep(
                    BeritaAcaraPenyusunanPengurusIppnuFormStep.informasiLembaga,
                  ),
          children: [
            ReviewInfoRow(
              label: 'Jenis Lembaga',
              value: viewModel.formDataManager.jenisLembagaController.text,
            ),
            ReviewInfoRow(
              label: 'Nama Lembaga',
              value: viewModel.formDataManager.namaLembagaController.text,
            ),
            ReviewInfoRow(
              label: 'Periode Kepengurusan',
              value:
                  viewModel.formDataManager.periodeKepengurusanController.text,
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spaceM),

        // Data Pengurus Harian
        ReviewSectionCard(
          title: 'Pengurus Harian',
          icon: Icons.groups,
          color: AppColors.ippnuAccent,
          onEdit:
              () => viewModel.jumpToStep(
                    BeritaAcaraPenyusunanPengurusIppnuFormStep
                        .dataPengurusHarian,
                  ),
          children: [
            if (viewModel.formDataManager.pengurusHarian.isEmpty)
              const ReviewEmptyState(message: 'Belum ada pengurus harian')
            else
              ...viewModel.formDataManager.pengurusHarian.asMap().entries.map(
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
                    BeritaAcaraPenyusunanPengurusIppnuFormStep
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
                    BeritaAcaraPenyusunanPengurusIppnuFormStep.dataPengurusInti,
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
                      text:
                          '${wakil.titleController.text}: ${wakil.namaController.text}',
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
            if (viewModel.formDataManager.wakilSekretaris.isNotEmpty) ...[
              const ReviewSubHeader(
                title: 'Wakil Sekretaris',
                color: AppColors.ippnuSecondaryLight,
              ),
              ...viewModel.formDataManager.wakilSekretaris.map(
                    (wakil) => ReviewBulletPoint(
                      text:
                          '${wakil.titleController.text}: ${wakil.namaController.text}',
                    ),
                  ),
              const SizedBox(height: AppDimensions.spaceM),
            ],

            // Bendahara
            const ReviewSubHeader(
              title: 'Bendahara',
              color: AppColors.ippnuSecondaryLight,
            ),
            ReviewInfoRow(
              label: 'Nama',
              value: viewModel.formDataManager.namaBendaharaController.text,
            ),
            if (viewModel.formDataManager.namaWakilBendController.text.isNotEmpty) ...[
              ReviewInfoRow(
                label: 'Wakil Bendahara',
                value: viewModel.formDataManager.namaWakilBendController.text,
              ),
            ],
          ],
        ),
        const SizedBox(height: AppDimensions.spaceM),

        // Data Departemen
        ReviewSectionCard(
          title: 'Departemen',
          icon: Icons.account_tree,
          color: AppColors.ippnuAccentLight,
          onEdit:
              () => viewModel.jumpToStep(
                    BeritaAcaraPenyusunanPengurusIppnuFormStep.dataDepartemen,
                  ),
          children: [
            if (viewModel.formDataManager.departemen.isEmpty)
              const ReviewEmptyState(message: 'Belum ada departemen')
            else
              ...viewModel.formDataManager.departemen.asMap().entries.map(
                    (entry) {
                      final dept = entry.value;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReviewSubHeader(
                            title:
                                '${entry.key + 1}. ${dept.namaDepartemenController.text}',
                            color: AppColors.ippnuAccent,
                          ),
                          ReviewInfoRow(
                            label: 'Koordinator',
                            value: dept.koordinatorController.text,
                          ),
                          const SizedBox(height: AppDimensions.spaceS),
                          Text(
                            'Anggota:',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.7),
                                ),
                          ),
                          if (dept.anggota.isEmpty)
                            const ReviewEmptyState(
                              message: 'Belum ada anggota',
                            )
                          else
                            ...dept.anggota.asMap().entries.map(
                                  (anggota) => ReviewBulletPoint(
                                    text:
                                        '${anggota.key + 1}. ${anggota.value.namaController.text}',
                                  ),
                                ),
                          if (entry.key <
                              viewModel.formDataManager.departemen.length - 1)
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: AppDimensions.spaceM,
                              ),
                              child: Divider(),
                            ),
                        ],
                      );
                    },
                  ),
          ],
        ),
        const SizedBox(height: AppDimensions.spaceM),

        // Data Lembaga
        ReviewSectionCard(
          title: 'Lembaga',
          icon: Icons.domain,
          color: AppColors.documentLime,
          onEdit:
              () => viewModel.jumpToStep(
                    BeritaAcaraPenyusunanPengurusIppnuFormStep.dataLembaga,
                  ),
          children: [
            if (viewModel.formDataManager.lembaga.isEmpty)
              const ReviewEmptyState(message: 'Belum ada lembaga')
            else
              ...viewModel.formDataManager.lembaga.asMap().entries.map(
                    (entry) {
                      final lembaga = entry.value;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReviewSubHeader(
                            title:
                                '${entry.key + 1}. ${lembaga.namaController.text}',
                            color: AppColors.documentLime,
                          ),
                          ReviewInfoRow(
                            label: 'Direktur',
                            value: lembaga.direkturController.text,
                          ),
                          ReviewInfoRow(
                            label: 'Sekretaris',
                            value: lembaga.sekretarisController.text,
                          ),
                          const SizedBox(height: AppDimensions.spaceS),
                          Text(
                            'Anggota:',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.7),
                                ),
                          ),
                          if (lembaga.anggota.isEmpty)
                            const ReviewEmptyState(
                              message: 'Belum ada anggota',
                            )
                          else
                            ...lembaga.anggota.asMap().entries.map(
                                  (anggota) => ReviewBulletPoint(
                                    text:
                                        '${anggota.key + 1}. ${anggota.value.namaController.text}',
                                  ),
                                ),
                          if (entry.key <
                              viewModel.formDataManager.lembaga.length - 1)
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: AppDimensions.spaceM,
                              ),
                              child: Divider(),
                            ),
                        ],
                      );
                    },
                  ),
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
                    BeritaAcaraPenyusunanPengurusIppnuFormStep.penetapan,
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
              label: 'Hari Penyusunan',
              value: viewModel.formDataManager.hariPenyusunanController.text,
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
