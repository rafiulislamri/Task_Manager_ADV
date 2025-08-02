import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/widgets/task_card.dart';
import 'package:task_manager/ui/controllers/cancelled_task_list_controller.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

class CancelledTaskListScreen extends StatelessWidget {
  const CancelledTaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CancelledTaskListController());
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: GetBuilder<CancelledTaskListController>(
          builder: (controller) {
            if (controller.inProgress) {
              return const Center(child: CircularProgressIndicator());
            }
            
            if (controller.errorMessage != null) {
              showSnackBarMessage(context, controller.errorMessage!);
              return const Center(child: Text('Failed to load tasks'));
            }
            
            return ListView.builder(
              itemCount: controller.cancelledTaskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskType: TaskType.cancelled,
                  taskModel: controller.cancelledTaskList[index],
                  onStatusUpdate: () {
                    controller.getCancelledTaskList();
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}