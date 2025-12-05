enum BeritaAcaraPenyusunanPengurusIppnuFormStep {
  informasiLembaga('Informasi Pimpinan'),
  dataPengurusHarian('Data Pengurus Harian'),
  dataPelindungPembina('Data Pelindung & Pembina'),
  dataPengurusInti('Data Pengurus Inti'),
  dataDepartemen('Data Departemen'),
  dataLembaga('Data Lembaga'),
  penetapan('Penetapan'),
  review('Review');

  final String title;

  const BeritaAcaraPenyusunanPengurusIppnuFormStep(this.title);

  static List<String> get allTitles => values.map((e) => e.title).toList();

  BeritaAcaraPenyusunanPengurusIppnuFormStep? get next =>
      index < values.length - 1 ? values[index + 1] : null;

  BeritaAcaraPenyusunanPengurusIppnuFormStep? get previous =>
      index > 0 ? values[index - 1] : null;

  static int get totalSteps => values.length;
}
