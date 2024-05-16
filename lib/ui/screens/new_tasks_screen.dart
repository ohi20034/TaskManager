import 'package:flutter/material.dart';
import 'package:flutter_application_9/data/models/task_count.dart';
import 'package:flutter_application_9/data/models/task_list_model.dart';
import 'package:flutter_application_9/data/models/task_sum_count_list_model.dart';
import 'package:flutter_application_9/data/network_caller/network_coller.dart';
import 'package:flutter_application_9/data/network_caller/network_response.dart';
import 'package:flutter_application_9/data/utility/urls.dart';
import 'package:flutter_application_9/ui/screens/add_new_task_screen.dart';
import 'package:flutter_application_9/ui/widgets/profile_summary_card.dart';
import 'package:flutter_application_9/ui/widgets/summary_card.dart';
import 'package:flutter_application_9/ui/widgets/task_item_card.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({super.key});

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  bool getNewTaskInProgress = false;
  bool getTaskCountSumInProgress = true;
  TaskListModel taskListModel = TaskListModel();
  TaskSumCountListModel taskSumCountListModel = TaskSumCountListModel();

  Future<void> getNewTaskList() async {
    getNewTaskInProgress = true;

    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getNewTask);

    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    getNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getTaskCountSumList() async {
    getTaskCountSumInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getTaskStatusCount);

    if (response.isSuccess) {
      taskSumCountListModel =
          TaskSumCountListModel.fromJson(response.jsonResponse);
    }
    getTaskCountSumInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getNewTaskList();
    getTaskCountSumList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTaskScreen(),
            ),
          );
        },
        child: const Icon(
          Icons.add_task,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            Visibility(
              visible: getTaskCountSumInProgress == false &&
                  (taskSumCountListModel.data?.isNotEmpty ?? false),
              replacement: const LinearProgressIndicator(),
              child: SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: taskSumCountListModel.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    TaskCount taskCount = taskSumCountListModel.data![index];
                    return FittedBox(
                      child: SummaryCard(
                        count: taskCount.sum.toString(),
                        title: taskCount.sId ?? '',
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Visibility(
                visible: getNewTaskInProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: RefreshIndicator(
                  onRefresh: getNewTaskList,
                  child: ListView.builder(
                    itemCount: taskListModel.data?.length ?? 0,
                    itemBuilder: ((context, index) {
                      return TaskItemCard(
                        task: taskListModel.data![index],
                        onStatusChagnel: () {
                          getNewTaskList();
                        },
                        showProgress: (inProgress) {
                          getNewTaskInProgress = inProgress;
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
