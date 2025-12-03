enum CurriculumVitaeIpnuFormStep {
  lembaga,
  dataKetua,
  organisasiPendidikanKetua,
  dataSekretaris,
  organisasiPendidikanSekretaris,
  dataBendahara,
  organisasiPendidikanBendahara;

  String get title {
    switch (this) {
      case CurriculumVitaeIpnuFormStep.lembaga:
        return 'Informasi Lembaga';
      case CurriculumVitaeIpnuFormStep.dataKetua:
        return 'Data Ketua';
      case CurriculumVitaeIpnuFormStep.organisasiPendidikanKetua:
        return 'Organisasi & Pendidikan Ketua';
      case CurriculumVitaeIpnuFormStep.dataSekretaris:
        return 'Data Sekretaris';
      case CurriculumVitaeIpnuFormStep.organisasiPendidikanSekretaris:
        return 'Organisasi & Pendidikan Sekretaris';
      case CurriculumVitaeIpnuFormStep.dataBendahara:
        return 'Data Bendahara';
      case CurriculumVitaeIpnuFormStep.organisasiPendidikanBendahara:
        return 'Organisasi & Pendidikan Bendahara';
    }
  }

  static int get totalSteps => values.length;

  static List<String> get allTitles => values.map((e) => e.title).toList();
}
