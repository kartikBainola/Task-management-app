import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/ViewModel/utils/extensions.dart';

import '../../Model/data/models/task.dart';
import '../../Model/providers/date_provider.dart';
import '../../Model/providers/task/tasks_provider.dart';
import '../../ViewModel/utils/helpers.dart';
import '../../ViewModel/widgets/app_background.dart';
import '../../ViewModel/widgets/display_list_of_history_tasks.dart';
import '../../ViewModel/widgets/display_white_text.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceSize = context.deviceSize;
    final date = ref.watch(dateProvider);
    final taskState = ref.watch(tasksProvider);
    final tasksHistory = _taskHistory(taskState.tasks, ref);
    return Scaffold(
      body: Stack(
        children: [
          AppBackground(
            headerHeight: deviceSize.height * 0.3,
            header: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => Helpers.selectDate(context, ref),
                    child: DisplayWhiteText(
                      text: Helpers.dateFormatter(date),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const DisplayWhiteText(text: 'Task History', size: 40),
                ],
              ),
            ),
          ),
          Positioned(
            top: 130,
            left: 0,
            right: 0,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DisplayListOfHistoryTasks(
                      tasks: tasksHistory,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Task> _taskHistory(List<Task> tasks, WidgetRef ref) {
    final date = ref.watch(dateProvider); // The currently selected date
    final List<Task> taskHistoryList = [];

    for (var task in tasks) {
      // Print task details for debugging
      print(
          'Task: ${task.title}, Is Completed: ${task.isCompleted}, Date: ${task.date}');

      // Add the task to the history list regardless of completion status
      final isTaskDay = Helpers.isTaskFromSelectedDate(task, date);
      if (isTaskDay) {
        taskHistoryList.add(task);
      }
    }

    // Optional: Sort tasks by date if needed (e.g., oldest to newest)
    taskHistoryList.sort((a, b) => a.date.compareTo(b.date));

    return taskHistoryList;
  }
}
