import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class DownloadNotificationService {
  static final DownloadNotificationService _instance =
      DownloadNotificationService._internal();

  factory DownloadNotificationService() => _instance;

  DownloadNotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;
  int _lastProgress = -1;
  DateTime? _lastUpdateTime;

  Future<void> initialize() async {
    if (_isInitialized) return;

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const initSettings = InitializationSettings(android: androidSettings);

    await _notifications.initialize(initSettings);
    _isInitialized = true;
  }

  Future<void> showDownloadProgress({
    required int id,
    required String fileName,
    required int progress,
    required int maxProgress,
  }) async {
    // Throttle updates - hanya update jika progress berubah atau sudah lewat 500ms
    final now = DateTime.now();
    if (_lastProgress == progress) return;
    if (_lastUpdateTime != null &&
        now.difference(_lastUpdateTime!).inMilliseconds < 500 &&
        progress < 100) {
      return;
    }

    _lastProgress = progress;
    _lastUpdateTime = now;

    final androidDetails = AndroidNotificationDetails(
      'download_channel',
      'Downloads',
      channelDescription: 'Menampilkan progress download file',
      importance: Importance.low,
      priority: Priority.low,
      showProgress: true,
      maxProgress: maxProgress,
      progress: progress,
      onlyAlertOnce: true,
      playSound: false,
      enableVibration: false,
    );

    final notificationDetails = NotificationDetails(android: androidDetails);

    await _notifications.show(
      id,
      'Mengunduh File',
      '$fileName ($progress%)',
      notificationDetails,
    );
  }

  Future<void> showDownloadComplete({
    required int id,
    required String fileName,
  }) async {
    // Cancel progress notification terlebih dahulu
    await _notifications.cancel(id);

    // Delay kecil untuk memastikan cancel selesai
    await Future.delayed(const Duration(milliseconds: 100));

    // Reset tracking
    _lastProgress = -1;
    _lastUpdateTime = null;

    const androidDetails = AndroidNotificationDetails(
      'download_complete_channel',
      'Download Selesai',
      channelDescription: 'Notifikasi download selesai',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      onlyAlertOnce: false,
      autoCancel: true,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await _notifications.show(
      id,
      'Download Selesai',
      fileName,
      notificationDetails,
    );
  }

  Future<void> showDownloadError({
    required int id,
    required String fileName,
    required String error,
  }) async {
    // Cancel progress notification terlebih dahulu
    await _notifications.cancel(id);

    // Delay kecil untuk memastikan cancel selesai
    await Future.delayed(const Duration(milliseconds: 100));

    // Reset tracking
    _lastProgress = -1;
    _lastUpdateTime = null;

    const androidDetails = AndroidNotificationDetails(
      'download_error_channel',
      'Download Error',
      channelDescription: 'Notifikasi download gagal',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      autoCancel: true,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await _notifications.show(
      id,
      'Download Gagal',
      '$fileName - $error',
      notificationDetails,
    );
  }

  Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }
}
