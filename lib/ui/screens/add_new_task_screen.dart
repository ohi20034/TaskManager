import 'package:flutter/material.dart';
import 'package:flutter_application_9/data/network_caller/network_coller.dart';
import 'package:flutter_application_9/data/network_caller/network_response.dart';
import 'package:flutter_application_9/data/utility/urls.dart';
import 'package:flutter_application_9/ui/widgets/bodyBackground.dart';
import 'package:flutter_application_9/ui/widgets/profile_summary_card.dart';
import 'package:flutter_application_9/ui/widgets/snack_message.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _createTaskInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            Expanded(
              child: BodyBackground(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 32,
                          ),
                          Text(
                            'Add New Task',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: _subjectTEController,
                            decoration: const InputDecoration(
                              hintText: 'Subject',
                            ),
                            validator: (String? value) {
                              if (value!.trim().isEmpty) {
                                return 'Enter Your Subject';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _descriptionTEController,
                            maxLines: 8,
                            decoration: const InputDecoration(
                              hintText: 'Description',
                            ),
                            validator: (String? value) {
                              if (value!.trim().isEmpty) {
                                return 'Enter Your Description';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Visibility(
                              visible: _createTaskInProgress == false,
                              replacement: const Center(
                                child: CircularProgressIndicator(),
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                onPressed: createTask,
                                child: const Icon(
                                  Icons.arrow_circle_right_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> createTask() async {
    if (_formKey.currentState!.validate()) {
      _createTaskInProgress = true;
      if (mounted) {
        setState(() {});
      }
      final NetworkResponse response = await NetworkCaller().postRequest(
        Urls.createNewTaks,
        body: {
          "title": _subjectTEController.text.trim(),
          "description": _descriptionTEController.text.trim(),
          "status": "New",
        },
      );
      _createTaskInProgress = false;
      if (mounted) {
        setState(() {
          _subjectTEController.clear();
          _descriptionTEController.clear();
          if (mounted) {
            showSnackMessage(
              context,
              'New Task added',
            );
            Navigator.pop(context);
          }
        });
      }
      if (response.isSuccess) {
      } else {
        if (mounted) {
          showSnackMessage(context, 'Create New task failed! try again.', true);
        }
      }
    }
  }

  @override
  void dispose() {
    _descriptionTEController.dispose();
    _subjectTEController.dispose();
    super.dispose();
  }
}
