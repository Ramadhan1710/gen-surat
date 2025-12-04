enum SuratKeputusanIppnuFormStep {
  lembaga('Informasi Lembaga'),
  surat('Informasi Surat'),
  timFormatur('Tim Formatur'),
  tandaTangan('Tanda Tangan');

  final String title;

  const SuratKeputusanIppnuFormStep(this.title);

  static List<String> get allTitles => values.map((e) => e.title).toList();

  SuratKeputusanIppnuFormStep? get next =>
      index < values.length - 1 ? values[index + 1] : null;

  SuratKeputusanIppnuFormStep? get previous =>
      index > 0 ? values[index - 1] : null;

  static int get totalSteps => values.length;
}
