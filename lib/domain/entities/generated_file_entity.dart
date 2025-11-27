/// Entity untuk file yang sudah di-generate
/// Domain layer - Pure Dart, no external dependencies
class GeneratedFileEntity {
  final String id;
  final String fileName;
  final String filePath;
  final String fileType;
  final String lembaga;
  final int fileSize;
  final DateTime createdAt;
  final String? nomorSurat;
  final String? namaLembaga;
  final String? description;

  GeneratedFileEntity({
    required this.id,
    required this.fileName,
    required this.filePath,
    required this.fileType,
    required this.lembaga,
    required this.fileSize,
    required this.createdAt,
    this.nomorSurat,
    this.namaLembaga,
    this.description,
  });

  /// Copy with method
  GeneratedFileEntity copyWith({
    String? id,
    String? fileName,
    String? filePath,
    String? fileType,
    String? lembaga,
    int? fileSize,
    DateTime? createdAt,
    String? nomorSurat,
    String? namaLembaga,
    String? description,
  }) {
    return GeneratedFileEntity(
      id: id ?? this.id,
      fileName: fileName ?? this.fileName,
      filePath: filePath ?? this.filePath,
      fileType: fileType ?? this.fileType,
      lembaga: lembaga ?? this.lembaga,
      fileSize: fileSize ?? this.fileSize,
      createdAt: createdAt ?? this.createdAt,
      nomorSurat: nomorSurat ?? this.nomorSurat,
      namaLembaga: namaLembaga ?? this.namaLembaga,
      description: description ?? this.description,
    );
  }
}
