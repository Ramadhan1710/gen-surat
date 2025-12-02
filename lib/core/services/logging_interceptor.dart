import 'dart:developer' as developer;
import 'package:dio/dio.dart';

/// Custom Logging Interceptor untuk melihat detail data yang dikirim ke server
/// 
/// Interceptor ini akan mencatat semua request dan response dengan format yang mudah dibaca
/// 
/// Fitur:
/// - Log semua request dengan detail: Method, URL, Headers, Query Parameters, dan Body
/// - Log FormData dengan detail fields dan files (nama, size, content-type)
/// - Log response dengan detail: Status, Headers, dan Body
/// - Log error dengan detail: Error Type, Message, Response, dan Stack Trace
/// - Truncate data yang terlalu panjang untuk menjaga log tetap readable
/// 
/// Cara melihat log:
/// 1. Run aplikasi dalam mode Debug
/// 2. Buka DevTools / Debug Console di VS Code
/// 3. Filter log dengan nama:
///    - 'HTTP_REQUEST' untuk melihat request yang dikirim
///    - 'HTTP_RESPONSE' untuk melihat response dari server
///    - 'HTTP_ERROR' untuk melihat error yang terjadi
/// 
/// Contoh filter di VS Code Debug Console:
///    - Ketik "HTTP_REQUEST" di search box untuk filter request saja
///    - Ketik "HTTP_RESPONSE" untuk filter response saja
///    - Ketik "HTTP_ERROR" untuk filter error saja
/// 
/// Log Format:
/// ```
/// ┌─────────────────────────────────────────────────────────────────
/// │ REQUEST
/// │ Method: POST
/// │ URL: https://api.example.com/generate
/// │ Time: 2025-12-01T10:30:45.123
/// │
/// │ HEADERS:
/// │   Accept: */*
/// │   Content-Type: multipart/form-data
/// │
/// │ REQUEST DATA:
/// │ Type: FormData (Multipart)
/// │
/// │ FORM FIELDS:
/// │   lembaga_name: IPNU
/// │   type_surat: Surat Keputusan
/// │   ...
/// │
/// │ FORM FILES:
/// │   ttd_ketua:
/// │     - Filename: signature.png
/// │     - Content-Type: image/png
/// │     - Length: 12345 bytes
/// └─────────────────────────────────────────────────────────────────
/// ```
class CustomLoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestTime = DateTime.now();
    
    developer.log(
      '┌─────────────────────────────────────────────────────────────────',
      name: 'HTTP_REQUEST',
    );
    developer.log('│ REQUEST', name: 'HTTP_REQUEST');
    developer.log('│ Method: ${options.method}', name: 'HTTP_REQUEST');
    developer.log('│ URL: ${options.baseUrl}${options.path}', name: 'HTTP_REQUEST');
    developer.log('│ Time: ${requestTime.toIso8601String()}', name: 'HTTP_REQUEST');
    
    // Log Headers
    if (options.headers.isNotEmpty) {
      developer.log('│', name: 'HTTP_REQUEST');
      developer.log('│ HEADERS:', name: 'HTTP_REQUEST');
      options.headers.forEach((key, value) {
        developer.log('│   $key: $value', name: 'HTTP_REQUEST');
      });
    }
    
    // Log Query Parameters
    if (options.queryParameters.isNotEmpty) {
      developer.log('│', name: 'HTTP_REQUEST');
      developer.log('│ QUERY PARAMETERS:', name: 'HTTP_REQUEST');
      options.queryParameters.forEach((key, value) {
        developer.log('│   $key: $value', name: 'HTTP_REQUEST');
      });
    }
    
    // Log Request Body/Data
    if (options.data != null) {
      developer.log('│', name: 'HTTP_REQUEST');
      developer.log('│ REQUEST DATA:', name: 'HTTP_REQUEST');
      
      if (options.data is FormData) {
        final formData = options.data as FormData;
        developer.log('│ Type: FormData (Multipart)', name: 'HTTP_REQUEST');
        developer.log('│', name: 'HTTP_REQUEST');
        developer.log('│ FORM FIELDS:', name: 'HTTP_REQUEST');
        
        for (var field in formData.fields) {
          // Truncate nilai yang terlalu panjang
          final value = field.value.length > 200 
              ? '${field.value.substring(0, 200)}... (truncated, length: ${field.value.length})'
              : field.value;
          developer.log('│   ${field.key}: $value', name: 'HTTP_REQUEST');
        }
        
        if (formData.files.isNotEmpty) {
          developer.log('│', name: 'HTTP_REQUEST');
          developer.log('│ FORM FILES:', name: 'HTTP_REQUEST');
          for (var file in formData.files) {
            developer.log('│   ${file.key}:', name: 'HTTP_REQUEST');
            developer.log('│     - Filename: ${file.value.filename}', name: 'HTTP_REQUEST');
            developer.log('│     - Content-Type: ${file.value.contentType}', name: 'HTTP_REQUEST');
            developer.log('│     - Length: ${file.value.length} bytes', name: 'HTTP_REQUEST');
          }
        }
      } else if (options.data is Map) {
        _logMap(options.data as Map, '│   ');
      } else {
        developer.log('│   ${options.data}', name: 'HTTP_REQUEST');
      }
    }
    
    developer.log(
      '└─────────────────────────────────────────────────────────────────',
      name: 'HTTP_REQUEST',
    );
    
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final responseTime = DateTime.now();
    
    developer.log(
      '┌─────────────────────────────────────────────────────────────────',
      name: 'HTTP_RESPONSE',
    );
    developer.log('│ RESPONSE', name: 'HTTP_RESPONSE');
    developer.log('│ Method: ${response.requestOptions.method}', name: 'HTTP_RESPONSE');
    developer.log('│ URL: ${response.requestOptions.baseUrl}${response.requestOptions.path}', name: 'HTTP_RESPONSE');
    developer.log('│ Status: ${response.statusCode} ${response.statusMessage ?? ''}', name: 'HTTP_RESPONSE');
    developer.log('│ Time: ${responseTime.toIso8601String()}', name: 'HTTP_RESPONSE');
    
    // Log Response Headers
    if (response.headers.map.isNotEmpty) {
      developer.log('│', name: 'HTTP_RESPONSE');
      developer.log('│ RESPONSE HEADERS:', name: 'HTTP_RESPONSE');
      response.headers.map.forEach((key, value) {
        developer.log('│   $key: ${value.join(', ')}', name: 'HTTP_RESPONSE');
      });
    }
    
    // Log Response Data
    if (response.data != null) {
      developer.log('│', name: 'HTTP_RESPONSE');
      
      if (response.data is List<int>) {
        // Jika response adalah bytes (file download)
        final bytes = response.data as List<int>;
        developer.log('│ RESPONSE DATA: Binary file (${bytes.length} bytes)', name: 'HTTP_RESPONSE');
        
        // Log content-disposition jika ada
        final contentDisposition = response.headers.value('content-disposition');
        if (contentDisposition != null) {
          developer.log('│ File Name: $contentDisposition', name: 'HTTP_RESPONSE');
        }
      } else if (response.data is Map) {
        developer.log('│ RESPONSE DATA:', name: 'HTTP_RESPONSE');
        _logMap(response.data as Map, '│   ');
      } else {
        final dataStr = response.data.toString();
        final truncatedData = dataStr.length > 500 
            ? '${dataStr.substring(0, 500)}... (truncated, length: ${dataStr.length})'
            : dataStr;
        developer.log('│ RESPONSE DATA: $truncatedData', name: 'HTTP_RESPONSE');
      }
    }
    
    developer.log(
      '└─────────────────────────────────────────────────────────────────',
      name: 'HTTP_RESPONSE',
    );
    
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final errorTime = DateTime.now();
    
    developer.log(
      '┌─────────────────────────────────────────────────────────────────',
      name: 'HTTP_ERROR',
    );
    developer.log('│ ERROR', name: 'HTTP_ERROR');
    developer.log('│ Method: ${err.requestOptions.method}', name: 'HTTP_ERROR');
    developer.log('│ URL: ${err.requestOptions.baseUrl}${err.requestOptions.path}', name: 'HTTP_ERROR');
    developer.log('│ Time: ${errorTime.toIso8601String()}', name: 'HTTP_ERROR');
    developer.log('│ Error Type: ${err.type}', name: 'HTTP_ERROR');
    developer.log('│ Error Message: ${err.message}', name: 'HTTP_ERROR');
    
    if (err.response != null) {
      developer.log('│', name: 'HTTP_ERROR');
      developer.log('│ ERROR RESPONSE:', name: 'HTTP_ERROR');
      developer.log('│ Status: ${err.response?.statusCode}', name: 'HTTP_ERROR');
      developer.log('│ Status Message: ${err.response?.statusMessage}', name: 'HTTP_ERROR');
      
      if (err.response?.data != null) {
        developer.log('│', name: 'HTTP_ERROR');
        developer.log('│ ERROR DATA:', name: 'HTTP_ERROR');
        if (err.response?.data is Map) {
          _logMap(err.response?.data as Map, '│   ');
        } else {
          developer.log('│   ${err.response?.data}', name: 'HTTP_ERROR');
        }
      }
    }
    
    // Log stack trace (5 baris pertama)
    developer.log('│', name: 'HTTP_ERROR');
    developer.log('│ STACK TRACE:', name: 'HTTP_ERROR');
    final stackLines = err.stackTrace.toString().split('\n');
    for (var line in stackLines.take(5)) { // Tampilkan 5 baris pertama saja
      developer.log('│   $line', name: 'HTTP_ERROR');
    }
    
    developer.log(
      '└─────────────────────────────────────────────────────────────────',
      name: 'HTTP_ERROR',
    );
    
    super.onError(err, handler);
  }
  
  /// Helper method untuk log Map dengan indent
  void _logMap(Map map, String indent) {
    map.forEach((key, value) {
      if (value is Map) {
        developer.log('$indent$key:', name: 'HTTP_REQUEST');
        _logMap(value, '$indent  ');
      } else if (value is List) {
        if (value.isEmpty) {
          developer.log('$indent$key: []', name: 'HTTP_REQUEST');
        } else if (value.first is Map) {
          developer.log('$indent$key: [', name: 'HTTP_REQUEST');
          for (var i = 0; i < value.length; i++) {
            developer.log('$indent  [$i]:', name: 'HTTP_REQUEST');
            _logMap(value[i] as Map, '$indent    ');
          }
          developer.log('$indent]', name: 'HTTP_REQUEST');
        } else {
          developer.log('$indent$key: $value', name: 'HTTP_REQUEST');
        }
      } else {
        // Truncate nilai string yang terlalu panjang
        final valueStr = value.toString();
        final displayValue = valueStr.length > 200 
            ? '${valueStr.substring(0, 200)}... (truncated, length: ${valueStr.length})'
            : valueStr;
        developer.log('$indent$key: $displayValue', name: 'HTTP_REQUEST');
      }
    });
  }
}
