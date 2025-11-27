class BaseApiRequestModel<T> {
  final String lembaga;
  final String typeSurat;
  final T data;

  BaseApiRequestModel({
    required this.lembaga,
    required this.typeSurat,
    required this.data,
  });

  Future<Map<String, dynamic>> toJson(Future<Map<String, dynamic>> Function(T) toJsonData) async {
    final dataMap = await toJsonData(data);
    
    // Field names sesuai API spec
    return {
      "lembaga_name": lembaga,
      "type_surat": typeSurat,
      ...dataMap,
    };
  }
}