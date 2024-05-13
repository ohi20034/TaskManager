import 'package:flutter/material.dart';
import 'package:flutter_application_9/ui/screens/cancelled_task_screen.dart';
import 'package:flutter_application_9/ui/screens/completed_tasks_screen.dart';
import 'package:flutter_application_9/ui/screens/new_tasks_screen.dart';
import 'package:flutter_application_9/ui/screens/progress_tasks_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  final List<Widget> _screens = const [
    NewTasksScreen(),
    ProgressTasksScreen(),
    CompletedTasksScreen(),
    CancelledTaskScreen(),
  ];

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.note_alt_outlined), label: 'New'),
          BottomNavigationBarItem(
              icon: Icon(Icons.restart_alt_rounded), label: 'In-progress'),
          BottomNavigationBarItem(
              icon: Icon(Icons.download_done_rounded), label: 'Completed'),
          BottomNavigationBarItem(
              icon: Icon(Icons.cancel_rounded), label: 'Cancelled'),
        ],
      ),
    );
  }
}
