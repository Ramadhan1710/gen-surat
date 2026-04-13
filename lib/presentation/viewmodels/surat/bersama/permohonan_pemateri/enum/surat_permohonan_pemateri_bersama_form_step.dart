enum SuratPermohonanPemateriBersamaFormStep {
  pembuka('Pembuka Surat'),
  isi('Isi Surat'),
  penutup('Penutup Surat');

  final String title;

  const SuratPermohonanPemateriBersamaFormStep(this.title);

  static List<String> get allTitles => values.map((e) => e.title).toList();

  SuratPermohonanPemateriBersamaFormStep? get next => index < values.length - 1 ? values[index + 1] : null; 

  SuratPermohonanPemateriBersamaFormStep? get previous => index > 0 ? values[index-1] : null;

  static int get totalSteps => values.length;
}