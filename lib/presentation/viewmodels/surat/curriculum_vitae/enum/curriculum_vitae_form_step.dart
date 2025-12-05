enum CurriculumVitaeFormStep {
  lembaga,
  dataKetua,
  organisasiPendidikanKetua,
  dataSekretaris,
  organisasiPendidikanSekretaris,
  dataBendahara,
  organisasiPendidikanBendahara;

  String get title {
    switch (this) {
      case CurriculumVitaeFormStep.lembaga:
        return 'Informasi Pimpinan';
      case CurriculumVitaeFormStep.dataKetua:
        return 'Data Ketua';
      case CurriculumVitaeFormStep.organisasiPendidikanKetua:
        return 'Organisasi & Pendidikan Ketua';
      case CurriculumVitaeFormStep.dataSekretaris:
        return 'Data Sekretaris';
      case CurriculumVitaeFormStep.organisasiPendidikanSekretaris:
        return 'Organisasi & Pendidikan Sekretaris';
      case CurriculumVitaeFormStep.dataBendahara:
        return 'Data Bendahara';
      case CurriculumVitaeFormStep.organisasiPendidikanBendahara:
        return 'Organisasi & Pendidikan Bendahara';
    }
  }

  static int get totalSteps => values.length;

  static List<String> get allTitles => values.map((e) => e.title).toList();
}
