import 'package:gen_surat/domain/entities/generated_file_entity.dart';
import 'package:hive/hive.dart';

part 'generated_file_model.g.dart';

/// Model untuk Hive - Data layer
/// Extends HiveObject untuk Hive functionality
class GeneratedFileModel extends HiveObject {
  String id;
  String fileName;
  String filePath;
  String fileType;
  String lembaga;
  int fileSize;
  DateTime createdAt;
  String? nomorSurat;
  String? namaLembaga;
  String? description;

  GeneratedFileModel({
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

  /// Convert from Entity to Model (Domain -> Data)
  factory GeneratedFileModel.fromEntity(GeneratedFileEntity entity) {
    return GeneratedFileModel(
      id: entity.id,
      fileName: entity.fileName,
      filePath: entity.filePath,
      fileType: entity.fileType,
      lembaga: entity.lembaga,
      fileSize: entity.fileSize,
      createdAt: entity.createdAt,
      nomorSurat: entity.nomorSurat,
      namaLembaga: entity.namaLembaga,
      description: entity.description,
    );
  }

  /// Convert to Entity (Data -> Domain)
  GeneratedFileEntity toEntity() {
    return GeneratedFileEntity(
      id: id,
      fileName: fileName,
      filePath: filePath,
      fileType: fileType,
      lembaga: lembaga,
      fileSize: fileSize,
      createdAt: createdAt,
      nomorSurat: nomorSurat,
      namaLembaga: namaLembaga,
      description: description,
    );
  }
}
