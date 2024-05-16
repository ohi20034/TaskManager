import 'package:flutter/material.dart';
import 'package:flutter_application_9/data/models/task_list_model.dart';
import 'package:flutter_application_9/data/network_caller/network_coller.dart';
import 'package:flutter_application_9/data/network_caller/network_response.dart';
import 'package:flutter_application_9/data/utility/urls.dart';
import 'package:flutter_application_9/ui/widgets/profile_summary_card.dart';
import 'package:flutter_application_9/ui/widgets/task_item_card.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {

   bool getCompletedTaskProgress = false;
  TaskListModel taskListModel = TaskListModel();
  Future<void> getCompletedTaskList() async {
    getCompletedTaskProgress = true;

    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getNewCompleted);

    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    getCompletedTaskProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getCompletedTaskList();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            Expanded(
              child: Visibility(
                visible: getCompletedTaskProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: RefreshIndicator(
                  onRefresh: getCompletedTaskList,
                  child: ListView.builder(
                    itemCount: taskListModel.data?.length ?? 0,
                    itemBuilder: ((context, index) {
                      return TaskItemCard(
                        task: taskListModel.data![index],
                        onStatusChagnel: () {
                          getCompletedTaskList();
                        },
                        showProgress: (inProgress) {
                          getCompletedTaskProgress = inProgress;
                          if (mounted) {
                            setState(() {});
                          }
                        },
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
