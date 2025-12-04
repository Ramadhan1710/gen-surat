enum BeritaAcaraFormaturPembentukanPengurusHarianFormStep {
  informasiLembaga('Informasi Lembaga'),
  dataFormatur('Data Tim Formatur'),
  dataPelindungPembina('Data Pelindung & Pembina'),
  dataPengurusInti('Data Pengurus Inti'),
  penetapan('Penetapan'),
  review('Review');

  final String title;

  const BeritaAcaraFormaturPembentukanPengurusHarianFormStep(this.title);

  static List<String> get allTitles => values.map((e) => e.title).toList();

  BeritaAcaraFormaturPembentukanPengurusHarianFormStep? get next =>
      index < values.length - 1 ? values[index + 1] : null;

  BeritaAcaraFormaturPembentukanPengurusHarianFormStep? get previous =>
      index > 0 ? values[index - 1] : null;

  static int get totalSteps => values.length;
}
