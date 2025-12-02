import 'package:flutter/material.dart';
import 'package:gen_surat/core/themes/app_dimensions.dart';
import 'package:gen_surat/presentation/viewmodels/surat/susunan_pengurus/susunan_pengurus_ipnu_viewmodel.dart';
import 'package:gen_surat/presentation/widgets/custom_text_field.dart';
import 'package:get/get.dart';

class StepLembagaSection extends StatelessWidget {
  final SusunanPengurusIpnuViewmodel viewModel;

  const StepLembagaSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.spaceM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informasi Lembaga',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppDimensions.spaceM),
          
          CustomTextField(
            controller: viewModel.formDataManager.jenisLembagaController,
            label: 'Tingkatan Lembaga',
            helpText: 'Contoh: Pimpinan Ranting, Pimpinan Komisariat, dll.',
            textCapitalization: TextCapitalization.words,
            hint: 'Masukkan tingkatan lembaga',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Tingkatan lembaga tidak boleh kosong';
              }
              return null;
            },
          ),
          const SizedBox(height: AppDimensions.spaceM),
          
          CustomTextField(
            controller: viewModel.formDataManager.namaLembagaController,
            label: 'Nama Desa/Sekolah',
            helpText: 'Contoh: Desa Ngepeh, Madrasah Aliyah Nahdlatul Ulama, dll.',
            textCapitalization: TextCapitalization.words,
            hint: 'Masukkan nama lembaga',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Nama lembaga tidak boleh kosong';
              }
              return null;
            },
          ),
          const SizedBox(height: AppDimensions.spaceM),
          
          CustomTextField(
            controller: viewModel.formDataManager.alamatLembagaController,
            label: 'Alamat Lembaga',
            helpText: 'Contoh: Jl. Raya Ngepeh No. 10, Desa Ngepeh, Kec. Mojosari, Kab. Mojokerto.',
            textCapitalization: TextCapitalization.words,
            hint: 'Masukkan alamat lengkap lembaga',
            maxLines: 2,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Alamat lembaga tidak boleh kosong';
              }
              return null;
            },
          ),
          const SizedBox(height: AppDimensions.spaceM),
          
          CustomTextField(
            controller: viewModel.formDataManager.nomorTeleponLembagaController,
            label: 'Nomor Telepon Lembaga',
            helpText: 'Contoh: 081234567890, Nomor telepon atau WhatsApp lembaga.',
            hint: 'Contoh: 081234567890',
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Nomor telepon tidak boleh kosong';
              }
              if (!RegExp(r'^[0-9]+$').hasMatch(value.trim())) {
                return 'Nomor telepon hanya boleh angka';
              }
              return null;
            },
          ),
          const SizedBox(height: AppDimensions.spaceM),
          
          CustomTextField(
            controller: viewModel.formDataManager.emailLembagaController,
            label: 'Email Lembaga',
            helpText: 'Contoh: email@lembaga.com, Alamat email lembaga.',
            hint: 'Masukkan email lembaga',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Email tidak boleh kosong';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value.trim())) {
                return 'Format email tidak valid';
              }
              return null;
            },
          ),
          const SizedBox(height: AppDimensions.spaceM),
          
          CustomTextField(
            controller: viewModel.formDataManager.periodeKepengurusanController,
            label: 'Periode Kepengurusan',
            helpText: 'Contoh: 2024-2026, Periode kepengurusan pengurus harian.',
            keyboardType: TextInputType.datetime,
            hint: 'Masukkan periode kepengurusan',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Periode kepengurusan tidak boleh kosong';
              }
              return null;
            },
          ),
          const SizedBox(height: AppDimensions.spaceXL),
        ],
      ),
    );
  }
}
