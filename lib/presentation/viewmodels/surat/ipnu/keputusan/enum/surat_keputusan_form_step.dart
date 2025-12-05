enum SuratKeputusanFormStep {
  lembaga('Informasi Pimpinan'),
  surat('Informasi Surat'),
  timFormatur('Informasi Tim Formatur'),
  tandaTangan('Tanda Tangan');

  final String title;

  const SuratKeputusanFormStep(this.title);

  static List<String> get allTitles => values.map((e) => e.title).toList();

  SuratKeputusanFormStep? get next =>
      index < values.length - 1 ? values[index + 1] : null;

  SuratKeputusanFormStep? get previous => index > 0 ? values[index - 1] : null;

  static int get totalSteps => values.length;
}
