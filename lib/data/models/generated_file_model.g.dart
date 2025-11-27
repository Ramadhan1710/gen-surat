part of 'generated_file_model.dart';

class GeneratedFileModelAdapter extends TypeAdapter<GeneratedFileModel> {
  @override
  final int typeId = 0;

  @override
  GeneratedFileModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GeneratedFileModel(
      id: fields[0] as String,
      fileName: fields[1] as String,
      filePath: fields[2] as String,
      fileType: fields[3] as String,
      lembaga: fields[4] as String,
      fileSize: fields[5] as int,
      createdAt: fields[6] as DateTime,
      nomorSurat: fields[7] as String?,
      namaLembaga: fields[8] as String?,
      description: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GeneratedFileModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.fileName)
      ..writeByte(2)
      ..write(obj.filePath)
      ..writeByte(3)
      ..write(obj.fileType)
      ..writeByte(4)
      ..write(obj.lembaga)
      ..writeByte(5)
      ..write(obj.fileSize)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.nomorSurat)
      ..writeByte(8)
      ..write(obj.namaLembaga)
      ..writeByte(9)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeneratedFileModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
