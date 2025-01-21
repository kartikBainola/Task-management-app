import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/utils/utils.dart';

final categoryProvider = StateProvider.autoDispose<TaskCategory>((ref) {
  return TaskCategory.others;
});
