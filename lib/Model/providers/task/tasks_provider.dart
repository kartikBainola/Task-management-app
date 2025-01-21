import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/Model/providers/task/task_notifier.dart';
import 'package:to_do_list/Model/providers/task/task_state.dart';
import 'package:to_do_list/Model/providers/task/taskdetail_notifier.dart';

import '../../data/models/task.dart';
import '../../data/repositories/task_repository_provider.dart';

final tasksProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return TaskNotifier(repository);
});

final updateTaskDetailProvider =
    StateNotifierProvider.family<UpdateTaskDetailNotifier, Task, String>(
        (ref, taskId) {
  final taskState = ref.watch(tasksProvider); // Watch the entire task state
  final task = taskState.tasks
      .firstWhere((task) => task.id == taskId); // Access tasks list from state
  final repository = ref.watch(taskRepositoryProvider);
  return UpdateTaskDetailNotifier(repository, task);
});
