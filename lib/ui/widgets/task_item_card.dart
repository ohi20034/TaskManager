import 'package:flutter/material.dart';
import 'package:flutter_application_9/data/models/task.dart';
import 'package:flutter_application_9/data/network_caller/network_coller.dart';
import 'package:flutter_application_9/data/utility/urls.dart';

enum TaskStatus {
  New,
  Progress,
  Completed,
  Cancel,
}

class TaskItemCard extends StatefulWidget {
  const TaskItemCard({
    super.key,
    required this.task,
    required this.onStatusChagnel,
    required this.showProgress,
  });
  final Task task;

  final VoidCallback onStatusChagnel;
  final Function(bool) showProgress;

  @override
  State<TaskItemCard> createState() => _TaskItemCardState();
}

class _TaskItemCardState extends State<TaskItemCard> {
  Future<void> updateTaskStatus(String status) async {
    widget.showProgress(true);
    final response = await NetworkCaller()
        .getRequest(Urls.updateTaskStatus(widget.task.sId ?? '', status));
    if (response.isSuccess) {
      widget.onStatusChagnel();
    }
    widget.showProgress(false);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.task.title ?? '',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(widget.task.description ?? ''),
            Text('Date: ${widget.task.createdDate}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    widget.task.status ?? 'New',
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.red,
                ),
                Wrap(
                  children: [
                    IconButton(
                      onPressed: () {
                        showUpdateStatusModal();
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showUpdateStatusModal() {
    List<ListTile> items = TaskStatus.values
        .map(
          (e) => ListTile(
            title: Text(e.name),
            onTap: () {
              updateTaskStatus(e.name);
              Navigator.pop(context);
            },
          ),
        )
        .toList();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: items,
          ),
          actions: [
            ButtonBar(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.blue),
                    )),
              ],
            ),
          ],
        );
      },
    );
  }
}
