class BaseApiRequestModel<T> {
  final String jenisSurat;
  final String typeSurat;
  final T data;

  BaseApiRequestModel({
    required this.jenisSurat,
    required this.typeSurat,
    required this.data,
  });

  Future<Map<String, dynamic>> toJson(Future<Map<String, dynamic>> Function(T) toJsonData) async {
    final dataMap = await toJsonData(data);
    
    // Field names sesuai API spec
    return {
      "jenis_surat": jenisSurat,
      "type_surat": typeSurat,
      ...dataMap,
    };
  }
}