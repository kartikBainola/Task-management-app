import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/data/data.dart';
import 'package:to_do_list/providers/providers.dart';
import 'package:to_do_list/providers/task/taskdetail_notifier.dart';

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
