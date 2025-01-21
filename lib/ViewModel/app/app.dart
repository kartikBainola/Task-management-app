import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/ViewModel/app/splash_screen.dart';
import '../../Model/data/datasource/task_datasource.dart';
import '../config/theme/app_theme.dart';

class FlutterTaskManagementApp extends ConsumerStatefulWidget {
  const FlutterTaskManagementApp({super.key});

  @override
  ConsumerState<FlutterTaskManagementApp> createState() =>
      _FlutterTaskManagementAppState();
}

class _FlutterTaskManagementAppState
    extends ConsumerState<FlutterTaskManagementApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TaskDatasource().insertDummyData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: SplashScreen(),
    );
  }
}
