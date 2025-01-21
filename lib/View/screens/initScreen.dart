import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'History page.dart';
import 'home_screen.dart';

const Color inActiveIconColor = Color(0xFFB6B6B6);

class InitScreen extends ConsumerStatefulWidget {
  int currentSelectedIndex = 0;
  InitScreen({required this.currentSelectedIndex, super.key});

  @override
  ConsumerState<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends ConsumerState<InitScreen> {
  void updateCurrentIndex(int index) {
    setState(() {
      widget.currentSelectedIndex = index;
    });
  }

  final pages = [const HomeScreen(), const HistoryPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[widget.currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: updateCurrentIndex,
        currentIndex: widget.currentSelectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox_outlined),
            activeIcon: Icon(Icons.inbox),
            label: "History",
          ),
        ],
      ),
    );
  }
}
