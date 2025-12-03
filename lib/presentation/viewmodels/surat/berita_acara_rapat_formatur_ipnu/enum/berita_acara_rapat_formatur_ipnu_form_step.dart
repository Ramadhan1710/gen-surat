enum BeritaAcaraRapatFormaturFormStep {
  lembaga('Informasi Lembaga'),
  waktuTempat('Waktu dan Tempat'),
  timFormatur('Tim Formatur');

  final String title;

  const BeritaAcaraRapatFormaturFormStep(this.title);

  static List<String> get allTitles => values.map((e) => e.title).toList();

  BeritaAcaraRapatFormaturFormStep? get next =>
      index < values.length - 1 ? values[index + 1] : null;

  BeritaAcaraRapatFormaturFormStep? get previous =>
      index > 0 ? values[index - 1] : null;

  static int get totalSteps => values.length;
}
