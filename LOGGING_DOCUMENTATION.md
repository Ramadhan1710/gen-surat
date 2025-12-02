# Logging System Documentation

## Overview
Sistem logging ini menggunakan **Custom Logging Interceptor** yang mencatat semua HTTP request dan response dengan detail lengkap. Sangat berguna untuk debugging dan monitoring komunikasi dengan server.

## Fitur Logging

### 1. **Request Logging** (`HTTP_REQUEST`)
Mencatat detail request yang dikirim ke server:
- HTTP Method (GET, POST, PUT, DELETE, etc.)
- URL endpoint lengkap
- Request Headers
- Query Parameters
- Request Body/Data:
  - FormData (Multipart) dengan detail fields dan files
  - JSON data
  - Raw data

### 2. **Response Logging** (`HTTP_RESPONSE`)
Mencatat detail response dari server:
- HTTP Status Code dan Message
- Response Headers
- Response Body/Data:
  - Binary file (dengan ukuran file)
  - JSON data
  - Raw data

### 3. **Error Logging** (`HTTP_ERROR`)
Mencatat detail error yang terjadi:
- Error Type (ConnectionTimeout, BadResponse, dll)
- Error Message
- Error Response dari server
- Stack Trace (5 baris pertama)

## Cara Melihat Log

### Di VS Code Debug Console

1. **Jalankan aplikasi dalam mode Debug**
   ```bash
   flutter run
   ```

2. **Buka Debug Console**
   - View → Debug Console
   - Atau tekan `Ctrl+Shift+Y` (Windows/Linux) / `Cmd+Shift+Y` (Mac)

3. **Filter Log**
   
   Gunakan search box di Debug Console untuk filter log:
   
   - **Melihat Request saja:**
     ```
     HTTP_REQUEST
     ```
   
   - **Melihat Response saja:**
     ```
     HTTP_RESPONSE
     ```
   
   - **Melihat Error saja:**
     ```
     HTTP_ERROR
     ```

### Di Terminal/Command Line

Jika run dari terminal, log akan muncul dengan format:
```
[log] ┌─────────────────────────────────────────────────────────────────
[log] │ REQUEST
[log] │ Method: POST
[log] │ URL: https://api.example.com/generate-surat
...
```

## Format Log

### Request Log Example

```
┌─────────────────────────────────────────────────────────────────
│ REQUEST
│ Method: POST
│ URL: https://api.gen-surat.com/api/surat/generate/ipnu/surat-keputusan
│ Time: 2025-12-01T10:30:45.123456
│
│ HEADERS:
│   Accept: */*
│   Content-Type: multipart/form-data; boundary=----WebKitFormBoundary...
│
│ REQUEST DATA:
│ Type: FormData (Multipart)
│
│ FORM FIELDS:
│   lembaga_name: IPNU
│   type_surat: Surat Keputusan
│   jenis_lembaga: Pimpinan Ranting
│   nama_lembaga: Desa Ngepeh
│   periode_kepengurusan: 2025-2027
│   ketua_terpilih: Ahmad Fauzi
│   nomor_surat: 001/PR/A/XXV/7354/XII/25
│   ...
│
│ FORM FILES:
│   ttd_ketua:
│     - Filename: signature_ketua.png
│     - Content-Type: image/png
│     - Length: 45678 bytes
│   ttd_sekretaris:
│     - Filename: signature_sekretaris.png
│     - Content-Type: image/png
│     - Length: 42345 bytes
└─────────────────────────────────────────────────────────────────
```

### Response Log Example

```
┌─────────────────────────────────────────────────────────────────
│ RESPONSE
│ Method: POST
│ URL: https://api.gen-surat.com/api/surat/generate/ipnu/surat-keputusan
│ Status: 200 OK
│ Time: 2025-12-01T10:30:50.123456
│
│ RESPONSE HEADERS:
│   content-type: application/pdf
│   content-disposition: attachment; filename="SK_IPNU_2025.pdf"
│   content-length: 125678
│
│ RESPONSE DATA: Binary file (125678 bytes)
│ File Name: attachment; filename="SK_IPNU_2025.pdf"
└─────────────────────────────────────────────────────────────────
```

### Error Log Example

```
┌─────────────────────────────────────────────────────────────────
│ ERROR
│ Method: POST
│ URL: https://api.gen-surat.com/api/surat/generate/ipnu/surat-keputusan
│ Time: 2025-12-01T10:30:45.123456
│ Error Type: DioExceptionType.badResponse
│ Error Message: Http status error [400]
│
│ ERROR RESPONSE:
│ Status: 400
│ Status Message: Bad Request
│
│ ERROR DATA:
│   error: Validation Error
│   message: Field 'nomor_surat' is required
│   details:
│     nomor_surat: This field is required
│
│ STACK TRACE:
│   #0      DioMixin._dispatchRequest (package:dio/src/dio_mixin.dart:145:7)
│   #1      DioMixin.request (package:dio/src/dio_mixin.dart:71:5)
│   #2      BaseRemoteDatasource.post (package:gen_surat/...)
│   #3      SuratDatasource.generateSurat (package:gen_surat/...)
│   #4      SuratRepository.generateSurat (package:gen_surat/...)
└─────────────────────────────────────────────────────────────────
```

## Truncation

Untuk menjaga log tetap readable, data yang terlalu panjang akan di-truncate:
- String value > 200 karakter: Ditampilkan 200 karakter pertama + info length
- Response data > 500 karakter: Ditampilkan 500 karakter pertama + info length

Example:
```
│   alamat_lengkap: Jl. Raya No. 123, RT 01 RW 02, Dusun Sono, Desa Ngepeh... (truncated, length: 350)
```

## Tips Debugging

### 1. Melihat Data yang Dikirim
Filter dengan `HTTP_REQUEST` dan perhatikan section:
- **FORM FIELDS**: Lihat semua field yang dikirim beserta nilainya
- **FORM FILES**: Lihat file yang di-upload (nama, size, type)

### 2. Melihat Response dari Server
Filter dengan `HTTP_RESPONSE` dan perhatikan:
- **Status Code**: 200 (sukses), 400 (bad request), 500 (server error), dll
- **RESPONSE DATA**: Data yang diterima dari server

### 3. Debugging Error
Filter dengan `HTTP_ERROR` dan perhatikan:
- **Error Type**: Jenis error (timeout, connection, bad response, dll)
- **ERROR DATA**: Detail error dari server
- **STACK TRACE**: Lokasi error terjadi

### 4. Verifikasi Data Sebelum Dikirim
Sebelum generate surat, check log `HTTP_REQUEST` untuk memastikan:
- Semua field terisi dengan benar
- Nama file signature benar
- Ukuran file tidak terlalu besar
- Format data sesuai yang diharapkan API

## Implementation

### File Location
- **Interceptor**: `lib/core/services/logging_interceptor.dart`
- **DioClient**: `lib/data/datasources/remote/dio_client.dart`

### Kode Implementation

```dart
// Di DioClient
dio.interceptors.add(CustomLoggingInterceptor());
```

Interceptor otomatis aktif untuk semua HTTP request yang menggunakan Dio client.

## Disable Logging (Production)

Untuk disable logging di production, tambahkan condition di DioClient:

```dart
import 'package:flutter/foundation.dart'; // untuk kIsInDebugMode

DioClient()
  : dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrlApi,
        // ...
      ),
    ) {
  // Hanya aktif di mode Debug
  if (kDebugMode) {
    dio.interceptors.add(CustomLoggingInterceptor());
  }
}
```

## Troubleshooting

### Log tidak muncul?
1. Pastikan aplikasi dijalankan dalam mode Debug
2. Pastikan Debug Console terbuka
3. Check filter di search box (hapus jika ada)

### Log terlalu banyak?
1. Gunakan filter: `HTTP_REQUEST`, `HTTP_RESPONSE`, atau `HTTP_ERROR`
2. Clear console: Klik icon "Clear Console" di Debug Console

### Tidak bisa melihat detail FormData?
1. Check log `HTTP_REQUEST` → section `FORM FIELDS`
2. Jika value ter-truncate, check file original atau tambah breakpoint

## Related Files

- `lib/core/services/logging_interceptor.dart` - Custom logging interceptor
- `lib/data/datasources/remote/dio_client.dart` - Dio client configuration
- `lib/data/datasources/remote/base_remote_datasource.dart` - Base datasource
- `lib/data/datasources/remote/surat_datasource.dart` - Surat datasource
- `lib/data/repositories/surat_repository.dart` - Surat repository

## Support

Jika ada pertanyaan atau issue, silakan check:
1. Log `HTTP_ERROR` untuk detail error
2. Log `HTTP_REQUEST` untuk verifikasi data yang dikirim
3. Documentation API server untuk format yang benar
