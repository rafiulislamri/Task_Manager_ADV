import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/task_card.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

class CancelledTaskListScreen extends StatefulWidget {
  const CancelledTaskListScreen({super.key});

  @override
  State<CancelledTaskListScreen> createState() => _CancelledTaskListScreenState();
}

class _CancelledTaskListScreenState extends State<CancelledTaskListScreen> {
  bool _getCancelledTasksInProgress = false;
  List<TaskModel> _cancelledTaskList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getCancelledTaskList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: _getCancelledTasksInProgress
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _cancelledTaskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskType: TaskType.cancelled,
                  taskModel: _cancelledTaskList[index],
                  onStatusUpdate: () {
                    _getCancelledTaskList();
                  },
                );
              },
            ),
    );
  }

  Future<void> _getCancelledTaskList() async {
    _getCancelledTasksInProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.getCancelledTasksUrl,
    );

    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _cancelledTaskList = list;
    } else {
      showSnackBarMessage(context, response.errorMessage!);
    }

    _getCancelledTasksInProgress = false;
    setState(() {});
  }
}
