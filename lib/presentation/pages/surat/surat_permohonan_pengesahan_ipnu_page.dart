import 'package:flutter/material.dart';
import 'package:gen_surat/presentation/viewmodels/surat/surat_permohonan_pengesahan_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:gen_surat/presentation/widgets/file_picker_widget.dart';
import 'package:gen_surat/core/themes/app_text_styles.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// Form Page untuk Surat Permohonan Pengesahan IPNU
class SuratPermohonanPengesahanIpnuPage extends StatelessWidget {
  const SuratPermohonanPengesahanIpnuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<SuratPermohonanPengesahanIpnuViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Surat Permohonan Pengesahan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _showResetConfirmation(context, vm);
            },
            tooltip: 'Reset Form',
          ),
        ],
      ),
      body: Form(
        key: vm.formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Section Header
            _buildSectionHeader('Informasi Lembaga'),
            const SizedBox(height: 16),

            // Jenis Lembaga
            CustomTextField(
              controller: vm.jenisLembagaController,
              label: 'Jenis Lembaga *',
              hint: 'Contoh: Pimpinan Ranting',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Jenis lembaga wajib diisi';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Nama Lembaga
            CustomTextField(
              controller: vm.namaLembagaController,
              label: 'Nama Lembaga *',
              hint: 'Contoh: PR IPNU Surabaya',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama lembaga wajib diisi';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Nomor Telepon
            CustomTextField(
              controller: vm.nomorTeleponLembagaController,
              label: 'Nomor Telepon *',
              hint: '081234567890',
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nomor telepon wajib diisi';
                }
                if (!RegExp(r'^[0-9]{10,13}$').hasMatch(value.trim())) {
                  return 'Nomor telepon tidak valid (10-13 digit)';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Email
            CustomTextField(
              controller: vm.emailLembagaController,
              label: 'Email *',
              hint: 'email@ipnu.or.id',
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Email wajib diisi';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value.trim())) {
                  return 'Format email tidak valid';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Alamat
            CustomTextField(
              controller: vm.alamatLembagaController,
              label: 'Alamat Lembaga *',
              hint: 'Alamat lengkap lembaga',
              maxLines: 3,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Alamat lembaga wajib diisi';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            // Section: Informasi Surat
            _buildSectionHeader('Informasi Surat'),
            const SizedBox(height: 16),

            // Nomor Surat
            CustomTextField(
              controller: vm.nomorSuratController,
              label: 'Nomor Surat *',
              hint: '001/IPNU/I/2025',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nomor surat wajib diisi';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Tanggal Rapat
            CustomTextField(
              controller: vm.tanggalRapatController,
              label: 'Tanggal Rapat *',
              hint: 'Pilih tanggal',
              suffixIcon: const Icon(Icons.calendar_today),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Tanggal rapat wajib diisi';
                }
                return null;
              },
              onChanged: (_) {},
            ),
            const SizedBox(height: 16),

            // Tanggal Hijriah
            CustomTextField(
              controller: vm.tanggalHijriahController,
              label: 'Tanggal Hijriah *',
              hint: '15 Rajab 1446',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Tanggal hijriah wajib diisi';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Tanggal Masehi
            CustomTextField(
              controller: vm.tanggalMasehiController,
              label: 'Tanggal Masehi *',
              hint: '15 Januari 2025',
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => _selectDate(context, vm),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Tanggal masehi wajib diisi';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            // Section: Kepengurusan
            _buildSectionHeader('Informasi Kepengurusan'),
            const SizedBox(height: 16),

            // Periode Kepengurusan
            CustomTextField(
              controller: vm.periodeKepengurusanController,
              label: 'Periode Kepengurusan *',
              hint: '2025-2027',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Periode kepengurusan wajib diisi';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Nama Ketua Terpilih
            CustomTextField(
              controller: vm.namaKetuaTerpilihController,
              label: 'Nama Ketua Terpilih *',
              hint: 'Nama lengkap ketua',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama ketua terpilih wajib diisi';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Nama Sekretaris Terpilih
            CustomTextField(
              controller: vm.namaSekretarisTerpilihController,
              label: 'Nama Sekretaris Terpilih *',
              hint: 'Nama lengkap sekretaris',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama sekretaris terpilih wajib diisi';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Jenis Lembaga Induk
            CustomTextField(
              controller: vm.jenisLembagaIndukController,
              label: 'Jenis Lembaga Induk *',
              hint: 'Contoh: Pimpinan Cabang',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Jenis lembaga induk wajib diisi';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            // Section: Tanda Tangan
            _buildSectionHeader('Tanda Tangan'),
            const SizedBox(height: 16),

            // TTD Ketua
            Obx(() => FilePickerWidget(
                  label: 'Tanda Tangan Ketua *',
                  file: vm.ttdKetuaFile.value,
                  onPick: () async {
                    final file = await ImagePickerHelper.pickImage(context);
                    if (file != null) {
                      vm.setTtdKetua(file);
                    }
                  },
                  onRemove: vm.removeTtdKetua,
                )),
            const SizedBox(height: 16),

            // TTD Sekretaris
            Obx(() => FilePickerWidget(
                  label: 'Tanda Tangan Sekretaris *',
                  file: vm.ttdSekretarisFile.value,
                  onPick: () async {
                    final file = await ImagePickerHelper.pickImage(context);
                    if (file != null) {
                      vm.setTtdSekretaris(file);
                    }
                  },
                  onRemove: vm.removeTtdSekretaris,
                )),
            const SizedBox(height: 24),

            // Error Message
            Obx(() {
              if (vm.errorMessage.value != null) {
                return Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error, color: Colors.red),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          vm.errorMessage.value!,
                          style: AppTextStyles.bodyMedium
                              .copyWith(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            }),

            // Generate Button
            Obx(() {
              if (vm.isLoading.value) {
                return Column(
                  children: [
                    LinearProgressIndicator(
                      value: vm.uploadProgress.value,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${(vm.uploadProgress.value * 100).toStringAsFixed(0)}%',
                      style: AppTextStyles.bodySmall,
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: vm.cancelGenerate,
                      child: const Text('Batalkan'),
                    ),
                  ],
                );
              }

              return ElevatedButton(
                onPressed: vm.generateSurat,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Generate Surat'),
              );
            }),

            const SizedBox(height: 16),

            // Generated File Card
            Obx(() {
              if (vm.generatedFile.value != null) {
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 32,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'File Berhasil Di-generate',
                                    style: AppTextStyles.titleSmall.copyWith(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    vm.getFileName(),
                                    style: AppTextStyles.bodySmall,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    vm.getFileSize(),
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // File Path (collapsible)
                        InkWell(
                          onTap: () => _showFileLocationDialog(context, vm),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.folder_outlined,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Lihat lokasi file',
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.chevron_right,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Divider(),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: vm.openGeneratedFile,
                                icon: const Icon(Icons.open_in_new, size: 20),
                                label: const Text('Buka'),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: vm.shareGeneratedFile,
                                icon: const Icon(Icons.share, size: 20),
                                label: const Text('Bagikan'),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            }),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: AppTextStyles.titleMedium,
    );
  }

  Future<void> _selectDate(
    BuildContext context,
    SuratPermohonanPengesahanIpnuViewModel vm,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      final formattedDate = DateFormat('dd MMMM yyyy', 'id_ID').format(picked);
      vm.tanggalMasehiController.text = formattedDate;
    }
  }

  void _showFileLocationDialog(
    BuildContext context,
    SuratPermohonanPengesahanIpnuViewModel vm,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.folder_outlined, color: Colors.blue),
            SizedBox(width: 8),
            Text('Lokasi File'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'File tersimpan di:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
              ),
              child: SelectableText(
                vm.getFilePath(),
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.info_outline, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Tekan dan tahan teks untuk menyalin',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _showResetConfirmation(
    BuildContext context,
    SuratPermohonanPengesahanIpnuViewModel vm,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Form'),
        content: const Text(
          'Apakah Anda yakin ingin mereset semua data form?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              vm.resetForm();
              Navigator.pop(context);
              Get.snackbar(
                'Success',
                'Form berhasil direset',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}
