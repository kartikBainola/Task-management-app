import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/data/data.dart';
import 'package:to_do_list/providers/providers.dart';
import 'package:to_do_list/utils/utils.dart';
import 'package:to_do_list/widgets/widgets.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../main.dart';
import 'initScreen.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class CreateTaskScreen extends ConsumerStatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  // Check if it's a tablet

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final deviceSize = MediaQuery.of(context).size;
    final isTablet = deviceSize.width > 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.primary,
        title: const DisplayWhiteText(
          text: 'Add New Task',
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CommonTextField(
                hintText: 'Task Title',
                title: 'Task Title',
                controller: _titleController,
              ),
              const Gap(30),
              const CategoriesSelection(),
              const Gap(30),
              const SelectDateTime(),
              const Gap(30),
              CommonTextField(
                hintText: 'Notes',
                title: 'Notes',
                maxLines: 6,
                controller: _noteController,
              ),
              const Gap(30),
              ElevatedButton(
                onPressed: () {
                  _createTask();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => InitScreen(currentSelectedIndex: 0),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .primary, // Button background
                  foregroundColor: Colors.white, // Text color
                  padding: EdgeInsets.all(isTablet ? 12.0 : 8.0),
                ),
                child: const DisplayWhiteText(
                  text: 'Save',
                ),
              ),
              const Gap(30),
            ],
          ),
        ),
      ),
    );
  }

  void _createTask() async {
    final title = _titleController.text.trim();
    final note = _noteController.text.trim();
    final time = ref.watch(timeProvider);
    final date = ref.watch(dateProvider);
    final category = ref.watch(categoryProvider);

    if (title.isNotEmpty) {
      final task = Task(
        title: title,
        category: category,
        time: Helpers.timeToString(time),
        date: DateFormat.yMMMd().format(date),
        note: note,
        isCompleted: false,
      );

      await ref
          .read(tasksProvider.notifier)
          .createTask(task)
          .then((value) async {
        // Schedule a notification
        await _scheduleNotification(task.title, date, time);

        AppAlerts.displaySnackbar(context, 'Task created successfully');
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => InitScreen(currentSelectedIndex: 0)));
      });
    } else {
      AppAlerts.displaySnackbar(context, 'Title cannot be empty');
    }
  }

  Future<void> _scheduleNotification(
      String title, DateTime date, TimeOfDay time) async {
    final scheduledDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    if (scheduledDateTime.isAfter(DateTime.now())) {
      final tz.TZDateTime tzScheduledDateTime =
          tz.TZDateTime.from(scheduledDateTime, tz.local);

      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'task_reminder_channel', // Unique ID for the notification channel
        'Task Reminders', // Channel name
        channelDescription: 'Reminders for your tasks',
        importance: Importance.max,
        priority: Priority.high,
      );

      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.zonedSchedule(
        0, // Notification ID
        'Task Reminder',
        'Reminder: $title',
        tzScheduledDateTime,
        platformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    }
  }
}
