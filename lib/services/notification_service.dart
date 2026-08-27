import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  static const String _channelId = 'study_reminders_channel';
  static const String _channelName = 'Daily Study Reminders';
  static const String _channelDescription =
      'Daily notifications to practice and keep your learning streak alive';
  static const int _dailyReminderId = 1001;
  static const int _freezeAlertId = 1002;

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      tz.initializeTimeZones();

      const AndroidInitializationSettings androidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const DarwinInitializationSettings darwinSettings =
          DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      const InitializationSettings initSettings = InitializationSettings(
        android: androidSettings,
        iOS: darwinSettings,
        macOS: darwinSettings,
      );

      await _notificationsPlugin.initialize(
        initSettings,
        onDidReceiveNotificationResponse: (details) {
          debugPrint('Notification tapped with payload: ${details.payload}');
        },
      );

      // Create Android Notification Channel
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        _channelId,
        _channelName,
        description: _channelDescription,
        importance: Importance.high,
        enableVibration: true,
      );

      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      _isInitialized = true;
    } catch (e) {
      debugPrint('NotificationService initialization notice: $e');
    }
  }

  Future<bool> requestPermissions() async {
    try {
      final androidImplementation =
          _notificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      if (androidImplementation != null) {
        final granted = await androidImplementation.requestNotificationsPermission();
        return granted ?? true;
      }
      return true;
    } catch (e) {
      debugPrint('Notice requesting notification permissions: $e');
      return true;
    }
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> scheduleDailyReminder({
    required int hour,
    required int minute,
    int currentStreak = 1,
    String targetLanguage = 'Spanish',
  }) async {
    await initialize();
    await requestPermissions();

    try {
      final scheduledDate = _nextInstanceOfTime(hour, minute);

      final String title = currentStreak > 1
          ? 'Keep your $currentStreak-day streak blazing! 🔥'
          : 'Ready for your daily practice? ⚡';

      final String body =
          'Just 3 minutes of $targetLanguage practice today will keep your momentum strong!';

      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDescription,
        importance: Importance.high,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      );

      const NotificationDetails platformDetails = NotificationDetails(
        android: androidDetails,
        iOS: DarwinNotificationDetails(
          sound: 'default',
        ),
      );

      await _notificationsPlugin.zonedSchedule(
        _dailyReminderId,
        title,
        body,
        scheduledDate,
        platformDetails,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );

      debugPrint('Daily study reminder scheduled for $hour:${minute.toString().padLeft(2, '0')}');
    } catch (e) {
      debugPrint('Notice scheduling daily reminder: $e');
    }
  }

  Future<void> cancelDailyReminder() async {
    try {
      await _notificationsPlugin.cancel(_dailyReminderId);
      debugPrint('Daily study reminder cancelled.');
    } catch (e) {
      debugPrint('Notice cancelling reminder: $e');
    }
  }

  Future<void> showStreakSavedNotification({required int savedStreak}) async {
    await initialize();
    try {
      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      );

      const NotificationDetails platformDetails = NotificationDetails(
        android: androidDetails,
        iOS: DarwinNotificationDetails(sound: 'default'),
      );

      await _notificationsPlugin.show(
        _freezeAlertId,
        '🧊 Streak Freeze Activated!',
        'Your $savedStreak-day streak has been shielded. Keep up the great work today!',
        platformDetails,
      );
    } catch (e) {
      debugPrint('Notice showing streak saved notification: $e');
    }
  }
}
