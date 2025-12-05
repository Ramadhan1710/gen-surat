enum SusunanPengurusFormStep {
  lembaga('Informasi Pimpinan'),
  pelindungPembina('Pelindung & Pembina'),
  ketuaWakil('Ketua & Wakil'),
  sekretarisWakil('Sekretaris & Wakil'),
  bendahara('Bendahara & Wakil'),
  departemen('Departemen'),
  lembagaInternal('Lembaga Internal'),
  cbpDivisi('CBP & Divisi');

  final String title;

  const SusunanPengurusFormStep(this.title);

  static List<String> get allTitles => values.map((e) => e.title).toList();

  SusunanPengurusFormStep? get next =>
      index < values.length - 1 ? values[index + 1] : null;

  SusunanPengurusFormStep? get previous => index > 0 ? values[index - 1] : null;

  static int get totalSteps => values.length;
}
