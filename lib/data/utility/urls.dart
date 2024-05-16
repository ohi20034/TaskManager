import 'package:flutter_application_9/ui/widgets/task_item_card.dart';

class Urls {
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static const String registration = '$_baseUrl/registration';
  static const String login = '$_baseUrl/login';
  static const String createNewTaks = '$_baseUrl/createTask';
  static  String getNewTask = '$_baseUrl/listTaskByStatus/${TaskStatus.New.name}';
  static  String getNewProgress = '$_baseUrl/listTaskByStatus/${TaskStatus.Progress.name}';
  static  String getNewCompleted = '$_baseUrl/listTaskByStatus/${TaskStatus.Completed.name}';
  static  String getNewCancel = '$_baseUrl/listTaskByStatus/${TaskStatus.Cancel.name}';



  static const String getTaskStatusCount = '$_baseUrl/taskStatusCount';
  static String updateTaskStatus(String taskID, String status) =>
      '$_baseUrl/updateTaskStatus/$taskID/$status';
}
