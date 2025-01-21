import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/data/data.dart';
import 'package:to_do_list/providers/providers.dart';
import 'package:to_do_list/screens/initScreen.dart';
import 'package:to_do_list/utils/utils.dart';
import 'package:to_do_list/widgets/widgets.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/providers/task/taskdetail_notifier.dart';

class UpdateTaskScreen extends ConsumerStatefulWidget {
  final Task? task;
  const UpdateTaskScreen({super.key, this.task});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends ConsumerState<UpdateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      // Populate the fields if a task is provided
      _titleController.text = widget.task!.title;
      _noteController.text = widget.task!.note;

      // Delay the provider state updates
      Future.delayed(Duration.zero, () {
        ref.read(categoryProvider.notifier).state = widget.task!.category;
        ref.read(dateProvider.notifier).state =
            DateFormat.yMMMd().parse(widget.task!.date);
        ref.read(timeProvider.notifier).state =
            Helpers.stringToTime(widget.task!.time);
      });
    }
  }

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
        title: DisplayWhiteText(
          text: widget.task == null ? 'Add New Task' : 'Update Task',
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
                  _updateTask();
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
                  text: 'update',
                ),
              ),
              const Gap(30),
            ],
          ),
        ),
      ),
    );
  }

  void _updateTask() async {
    final title = _titleController.text.trim();
    final note = _noteController.text.trim();
    final time = ref.watch(timeProvider);
    final date = ref.watch(dateProvider);
    final category = ref.watch(categoryProvider);

    // Ensure title is not empty before proceeding
    if (title.isNotEmpty) {
      try {
        // Create a copy of the task with updated fields
        final updatedTask = widget.task!.copyWith(
          title: title.isNotEmpty ? title : widget.task!.title, // Update title
          note: note.isNotEmpty ? note : widget.task!.note, // Update note
          category: category != widget.task!.category
              ? category
              : widget.task!.category, // Update category
          time: time != widget.task!.time
              ? Helpers.timeToString(time)
              : widget.task!.time, // Update time
          date: date != widget.task!.date
              ? DateFormat.yMMMd().format(date)
              : widget.task!.date, // Update date
          isCompleted:
              widget.task!.isCompleted, // Keep the completion status the same
        );

        // Call the updateTask method to save the updated task
        final taskNotifier = ref.read(tasksProvider.notifier);
        await taskNotifier.updateTask(updatedTask);

        // Show success message and navigate back
        AppAlerts.displaySnackbar(context, 'Task updated successfully');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => InitScreen(currentSelectedIndex: 0)),
        );
      } catch (e) {
        AppAlerts.displaySnackbar(
            context, 'Error updating task: ${e.toString()}');
      }
    } else {
      AppAlerts.displaySnackbar(context, 'Title cannot be empty');
    }
  }
}
