import 'package:flutter/material.dart';
import 'package:flutter_application_9/ui/widgets/profile_summary_card.dart';
import 'package:flutter_application_9/ui/widgets/summary_card.dart';
import 'package:flutter_application_9/ui/widgets/task_item_card.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({super.key});

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: [
                    SummaryCard(
                      count: '91',
                      title: 'New',
                    ),
                    SummaryCard(
                      count: '91',
                      title: 'New',
                    ),
                    SummaryCard(
                      count: '91',
                      title: 'New',
                    ),
                    SummaryCard(
                      count: '91',
                      title: 'New',
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: ((context, index) {
                  return const TaskItemCard();
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
