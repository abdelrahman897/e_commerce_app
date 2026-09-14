import 'dart:async';
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract interface class LocalNotificationInterface {
  Future<void> initialize();
  Future<bool?> requestPermissions();
  Future<void> showOrderNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  });
  Future<void> cancelNotification(int id);
  Future<void> cancelAllNotifications();
  Future<NotificationAppLaunchDetails?> getLaunchDetails();
  Stream<NotificationResponse> watchNotificationTaps();
}

class LocalNotificationImp implements LocalNotificationInterface {
  final FlutterLocalNotificationsPlugin _plugin;
  final StreamController<NotificationResponse> _tapController =
      StreamController<NotificationResponse>.broadcast();

  LocalNotificationImp({required FlutterLocalNotificationsPlugin plugin})
    : _plugin = plugin;

  // Channel settings (importance/sound) are locked by Android after first
  // creation on a device - bump the id (e.g. 'calls_channel_v2') if these
  // ever need to change for users who already have the app installed.

  static const AndroidNotificationChannel _ordersChannel =
      AndroidNotificationChannel(
        'orders_channel',
        'Orders',
        description: 'Order and payment status notifications',
        importance: Importance.high,
      );

  @override
  Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const darwinSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
    );

    await _plugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: _tapController.add,
      onDidReceiveBackgroundNotificationResponse:
          localNotificationBackgroundTapHandler,
    );

    final androidPlugin = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await androidPlugin?.createNotificationChannel(_ordersChannel);
  }

  @override
  Future<bool?> requestPermissions() async {
    if (Platform.isIOS) {
      return await _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    }
    if (Platform.isAndroid) {
      return await _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
    }
    return null;
  }

  @override
  Future<void> showOrderNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'orders_channel',
        'Orders',
        channelDescription: 'Order and payment status notifications',
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
    await _plugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: details,
      payload: payload,
    );
  }

  @override
  Future<void> cancelNotification(int id) async {
    await _plugin.cancel(id: id);
  }

  @override
  Future<void> cancelAllNotifications() async {
    await _plugin.cancelAll();
  }

  @override
  Future<NotificationAppLaunchDetails?> getLaunchDetails() async {
    return _plugin.getNotificationAppLaunchDetails();
  }

  @override
  Stream<NotificationResponse> watchNotificationTaps() {
    return _tapController.stream;
  }
}

/// Must stay a top-level (or static) function annotated with
/// @pragma('vm:entry-point') - required by flutter_local_notifications for
/// taps received while the app is terminated, and cannot live inside
/// LocalNotificationInterface/Imp. Runs in its own isolate, same
/// constraint as firebaseMessagingBackgroundHandler.
@pragma('vm:entry-point')
void localNotificationBackgroundTapHandler(NotificationResponse response) {}
