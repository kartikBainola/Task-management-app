import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/ViewModel/utils/extensions.dart';
import 'package:to_do_list/ViewModel/widgets/task_details.dart';
import 'package:to_do_list/ViewModel/widgets/taskhistory_tile.dart';

import '../../Model/data/models/task.dart';
import '../../Model/providers/task/tasks_provider.dart';
import '../utils/app_alerts.dart';
import 'common_container.dart';

class DisplayListOfHistoryTasks extends ConsumerWidget {
  const DisplayListOfHistoryTasks({
    super.key,
    required this.tasks,
  });
  final List<Task> tasks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceSize = context.deviceSize;
    final height = deviceSize.height * 0.7;
    final emptyTasksAlert = 'No task are added';

    return CommonContainer(
      height: height,
      child: tasks.isEmpty
          ? Center(
              child: Text(
                emptyTasksAlert,
                style: context.textTheme.headlineSmall,
              ),
            )
          : ListView.separated(
              shrinkWrap: true,
              itemCount: tasks.length,
              padding: EdgeInsets.zero,
              itemBuilder: (ctx, index) {
                final task = tasks[index];

                return InkWell(
                  onLongPress: () async {
                    await AppAlerts.showAlertDeleteDialog(
                      context: context,
                      ref: ref,
                      task: task,
                    );
                  },
                  onTap: () async {
                    await showModalBottomSheet(
                      context: context,
                      builder: (ctx) {
                        return TaskDetails(task: task);
                      },
                    );
                  },
                  child: TaskHistoryTile(
                    task: task,
                    onCompleted: (value) async {
                      await ref
                          .read(tasksProvider.notifier)
                          .updateTask(task)
                          .then((value) {
                        AppAlerts.displaySnackbar(
                          context,
                          task.isCompleted
                              ? 'Task incompleted'
                              : 'Task completed',
                        );
                      });
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(
                thickness: 1.5,
              ),
            ),
    );
  }
}
