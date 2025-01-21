import 'package:flutter/material.dart';
import 'package:to_do_list/ViewModel/utils/extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Model/data/models/task.dart';
import '../../Model/providers/task/tasks_provider.dart';

@immutable
class AppAlerts {
  const AppAlerts._();

  static displaySnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: context.textTheme.bodyMedium,
        ),
        backgroundColor: context.colorScheme.onSecondary,
      ),
    );
  }

  static Future<void> showAlertDeleteDialog({
    required BuildContext context,
    required WidgetRef ref,
    required Task task,
  }) async {
    Widget cancelButton = TextButton(
      child: const Text('NO'),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget deleteButton = TextButton(
      onPressed: () async {
        await ref.read(tasksProvider.notifier).deleteTask(task).then(
          (value) {
            displaySnackbar(
              context,
              'Task deleted successfully',
            );
            Navigator.pop(context);
          },
        );
      },
      child: const Text('YES'),
    );

    AlertDialog alert = AlertDialog(
      title: const Text('Are you sure you want to delete this task?'),
      actions: [
        deleteButton,
        cancelButton,
      ],
    );

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
