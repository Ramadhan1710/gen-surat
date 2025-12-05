enum BeritaAcaraRapatFormaturIpnuFormStep {
  lembaga('Informasi Pimpinan'),
  waktuTempat('Waktu dan Tempat'),
  timFormatur('Tim Formatur');

  final String title;

  const BeritaAcaraRapatFormaturIpnuFormStep(this.title);

  static List<String> get allTitles => values.map((e) => e.title).toList();

  BeritaAcaraRapatFormaturIpnuFormStep? get next =>
      index < values.length - 1 ? values[index + 1] : null;

  BeritaAcaraRapatFormaturIpnuFormStep? get previous =>
      index > 0 ? values[index - 1] : null;

  static int get totalSteps => values.length;
}
