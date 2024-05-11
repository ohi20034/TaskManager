import 'package:flutter/material.dart';
import 'package:flutter_application_9/ui/widgets/profile_summary_card.dart';
import 'package:flutter_application_9/ui/widgets/summary_card.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({super.key});

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ProfileSummaryCard(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SummaryCard(
                    count: '92',
                    title: 'New',
                  ),
                  SummaryCard(
                    count: '92',
                    title: 'In Progress',
                  ),
                  SummaryCard(
                    count: '92',
                    title: 'Completed',
                  ),
                  SummaryCard(
                    count: '92',
                    title: 'Cancelled',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

