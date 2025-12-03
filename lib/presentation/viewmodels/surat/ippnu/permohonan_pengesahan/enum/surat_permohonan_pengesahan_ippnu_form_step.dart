enum SuratPermohonanPengesahanIppnuFormStep {
  lembaga('Informasi Lembaga'),
  surat('Informasi Surat'),
  kepengurusan('Informasi Kepengurusan'),
  tandaTangan('Tanda Tangan');

  final String title;

  const SuratPermohonanPengesahanIppnuFormStep(this.title);

  static List<String> get allTitles => values.map((e) => e.title).toList();

  SuratPermohonanPengesahanIppnuFormStep? get next =>
      index < values.length - 1 ? values[index + 1] : null;

  SuratPermohonanPengesahanIppnuFormStep? get previous =>
      index > 0 ? values[index - 1] : null;

  static int get totalSteps => values.length;
}
