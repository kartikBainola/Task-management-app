import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/config/config.dart';
import 'package:to_do_list/data/data.dart';
import 'package:to_do_list/providers/providers.dart';
import 'package:to_do_list/screens/create_task_screen.dart';
import 'package:to_do_list/utils/utils.dart';
import 'package:to_do_list/widgets/widgets.dart';
import 'package:gap/gap.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceSize = MediaQuery.of(context).size; // Get screen size
    final isTablet = deviceSize.width > 600; // Check if it's a tablet
    final taskState = ref.watch(tasksProvider);
    final inCompletedTasks = _incompltedTask(taskState.tasks, ref);
    final completedTasks = _compltedTask(taskState.tasks, ref);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            AppBackground(
              headerHeight:
                  isTablet ? deviceSize.height * 0.4 : deviceSize.height * 0.3,
              header: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  DisplayWhiteText(
                    text: 'My Task',
                    size: 40,
                  ),
                ],
              ),
            ),
            Positioned.fill(
              top: isTablet ? 150 : 130,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(isTablet ? 30.0 : 20.0),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DisplayListOfTasks(
                      tasks: inCompletedTasks,
                    ),
                    const Gap(20),
                    Text(
                      'Completed',
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(20),
                    DisplayListOfTasks(
                      isCompletedTasks: true,
                      tasks: completedTasks,
                    ),
                    const Gap(20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CreateTaskScreen(),
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
                        text: 'Add New Task',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Task> _incompltedTask(List<Task> tasks, WidgetRef ref) {
    final List<Task> filteredTask = [];
    for (var task in tasks) {
      if (!task.isCompleted) {
        final isTaskDay = Helpers.isTaskFromSelectedDate(task, DateTime.now());
        if (isTaskDay) {
          filteredTask.add(task);
        }
      }
    }
    return filteredTask;
  }

  List<Task> _compltedTask(List<Task> tasks, WidgetRef ref) {
    final List<Task> filteredTask = [];
    for (var task in tasks) {
      if (task.isCompleted) {
        final isTaskDay = Helpers.isTaskFromSelectedDate(task, DateTime.now());
        if (isTaskDay) {
          filteredTask.add(task);
        }
      }
    }
    return filteredTask;
  }
}
