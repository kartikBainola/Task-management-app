import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/Model/data/datasource/task_datasource.dart';

final taskDatasourceProvider = Provider<TaskDatasource>((ref) {
  return TaskDatasource();
});
