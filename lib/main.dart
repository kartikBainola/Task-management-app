import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:permission_handler/permission_handler.dart';
import 'ViewModel/app/app.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Request permission for notifications (for Android 13+)
  await _requestNotificationPermission();
  await _initializeNotifications();

  // // Ensure plugin is initialized
  // await PermissionHandler().request();
  // Test notification after initialization
  await flutterLocalNotificationsPlugin.show(
    0, // Notification ID
    'Test Notification', // Title
    'This is a test notification.', // Body
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'test_channel', // Channel ID
        'Test Notifications', // Channel name
        channelDescription: 'Test notification channel',
        importance: Importance.max,
        priority: Priority.high,
      ),
    ),
  );

  runApp(
    const ProviderScope(
      child: FlutterTaskManagementApp(),
    ),
  );
}

// Request notification permission for Android 13+
Future<void> _requestNotificationPermission() async {
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
}

Future<void> _initializeNotifications() async {
  tz.initializeTimeZones(); // Initialize timezone data
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      // Handle notification tap here
      if (response.payload != null) {
        debugPrint('Notification payload: ${response.payload}');
      }
    },
  );
}
