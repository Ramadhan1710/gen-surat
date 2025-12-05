enum BeritaAcaraPemilihanKetuaFormStep {
  lembaga('Informasi Pimpinan'),
  pemilihanKetua('Waktu & Tempat Pemilihan'),
  pencalonanKetua('Data Pencalonan Ketua'),
  pemilihan('Data Pemilihan Ketua'),
  ketuaTerpilih('Ketua Terpilih'),
  formatur('Tim Formatur'),
  penetapan('Informasi Penetapan'),
  tandaTangan('Tanda Tangan');

  final String title;

  const BeritaAcaraPemilihanKetuaFormStep(this.title);

  static List<String> get allTitles => values.map((e) => e.title).toList();

  BeritaAcaraPemilihanKetuaFormStep? get next =>
      index < values.length - 1 ? values[index + 1] : null;

  BeritaAcaraPemilihanKetuaFormStep? get previous =>
      index > 0 ? values[index - 1] : null;

  static int get totalSteps => values.length;
}
