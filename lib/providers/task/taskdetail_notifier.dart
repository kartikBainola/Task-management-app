import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/task.dart';
import '../../data/repositories/task_repository.dart';
import '../../utils/task_category.dart';

class UpdateTaskDetailNotifier extends StateNotifier<Task> {
  final TaskRepository _repository;

  UpdateTaskDetailNotifier(this._repository, Task task) : super(task);

  Future<void> updateTaskDetails({
    required String title,
    required String note,
    required TaskCategory category, // or whatever type your category is
    required String time,
    required String date,
  }) async {
    try {
      final updatedTask = state.copyWith(
        title: title,
        note: note,
        category: category, // Make sure category is handled correctly
        time: time,
        date: date,
      );

      // Update the task in the repository
      await _repository.updateTask(updatedTask);

      // Optionally, update the state with the new task details
      state = updatedTask;
    } catch (e) {
      debugPrint('Error updating task: ${e.toString()}');
    }
  }
}
