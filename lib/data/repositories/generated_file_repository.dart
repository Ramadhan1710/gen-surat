import 'package:gen_surat/data/datasources/local/generated_file_service.dart';
import 'package:gen_surat/data/models/generated_file_model.dart';
import 'package:gen_surat/domain/entities/generated_file_entity.dart';
import 'package:gen_surat/domain/repositories/i_generated_file_repository.dart';

/// Repository implementation untuk Generated Files
/// Data layer - Implements domain interface
class GeneratedFileRepository implements IGeneratedFileRepository {
  final GeneratedFileService _service;

  GeneratedFileRepository(this._service);

  @override
  Future<void> saveFile(GeneratedFileEntity file) async {
    final model = GeneratedFileModel.fromEntity(file);
    await _service.saveGeneratedFile(model);
  }

  @override
  Future<List<GeneratedFileEntity>> getAllFiles() async {
    final models = _service.getAllFiles();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<GeneratedFileEntity?> getFileById(String id) async {
    final model = _service.getFileById(id);
    return model?.toEntity();
  }

  @override
  Future<List<GeneratedFileEntity>> getFilesByType(String fileType) async {
    final models = _service.getFilesByType(fileType);
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<GeneratedFileEntity>> getFilesByLembaga(String lembaga) async {
    final models = _service.getFilesByLembaga(lembaga);
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<String>> getAllFileTypes() async {
    return _service.getAllFileTypes();
  }

  @override
  Future<void> deleteFile(String id) async {
    await _service.deleteFile(id);
  }

  @override
  Future<void> clearAllFiles() async {
    await _service.clearAllFiles();
  }

  @override
  Future<int> getTotalFileCount() async {
    return _service.getTotalFileCount();
  }

  @override
  Future<int> getFileCountByType(String fileType) async {
    return _service.getFileCountByType(fileType);
  }

  @override
  Future<List<GeneratedFileEntity>> searchFiles(String keyword) async {
    final models = _service.searchFiles(keyword);
    return models.map((model) => model.toEntity()).toList();
  }
}
