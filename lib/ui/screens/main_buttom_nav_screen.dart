import 'package:flutter/material.dart';
import 'package:flutter_application_9/ui/screens/cancelled_task_screen.dart';
import 'package:flutter_application_9/ui/screens/completed_tasks_screen.dart';
import 'package:flutter_application_9/ui/screens/new_tasks_screen.dart';
import 'package:flutter_application_9/ui/screens/progress_tasks_screen.dart';

class MainButtomNavScreen extends StatefulWidget {
  const MainButtomNavScreen({super.key});

  @override
  State<MainButtomNavScreen> createState() => _MainButtomNavScreenState();
}

class _MainButtomNavScreenState extends State<MainButtomNavScreen> {
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
          _selectedIndex = index;
          setState(() {});
        },
        selectedItemColor: Colors.red,
        unselectedItemColor: const Color.fromARGB(255, 67, 67, 67),
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline_sharp), label: 'New'),
          BottomNavigationBarItem(
              icon: Icon(Icons.change_circle_outlined), label: 'In Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Completed'),
          BottomNavigationBarItem(icon: Icon(Icons.close), label: 'Cancelled'),
        ],
      ),
    );
  }
}
