import 'package:flutter/material.dart';
import 'package:flutter_application_9/data/models/task_list_model.dart';
import 'package:flutter_application_9/data/network_caller/network_coller.dart';
import 'package:flutter_application_9/data/network_caller/network_response.dart';
import 'package:flutter_application_9/data/utility/urls.dart';
import 'package:flutter_application_9/ui/widgets/profile_summary_card.dart';
import 'package:flutter_application_9/ui/widgets/task_item_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool getCancelTaskProgress = false;
  TaskListModel taskListModel = TaskListModel();
  Future<void> getProgressTaskList() async {
    getCancelTaskProgress = true;

    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getNewCancel);

    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    getCancelTaskProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getProgressTaskList();
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
                visible: getCancelTaskProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: RefreshIndicator(
                  onRefresh: getProgressTaskList,
                  child: ListView.builder(
                    itemCount: taskListModel.data?.length ?? 0,
                    itemBuilder: ((context, index) {
                      return TaskItemCard(
                        task: taskListModel.data![index],
                        onStatusChagnel: () {
                          getProgressTaskList();
                        },
                        showProgress: (inProgress) {
                          getCancelTaskProgress = inProgress;
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
