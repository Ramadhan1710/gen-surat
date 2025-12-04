enum SusunanPengurusIppnuFormStep {
  lembaga('Informasi Lembaga'),
  pelindungPembina('Pelindung & Pembina'),
  ketuaWakil('Ketua & Wakil'),
  sekretarisWakil('Sekretaris & Wakil'),
  bendahara('Bendahara & Wakil'),
  departemen('Departemen'),
  lembagaInternal('Lembaga Internal');

  final String title;

  const SusunanPengurusIppnuFormStep(this.title);

  static List<String> get allTitles => values.map((e) => e.title).toList();

  SusunanPengurusIppnuFormStep? get next =>
      index < values.length - 1 ? values[index + 1] : null;

  SusunanPengurusIppnuFormStep? get previous =>
      index > 0 ? values[index - 1] : null;

  static int get totalSteps => values.length;
}
