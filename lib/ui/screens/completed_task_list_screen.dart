import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/widgets/task_card.dart';
import 'package:task_manager/ui/controllers/completed_screen_list_controller.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

class CompletedTaskListScreen extends StatelessWidget {
  const CompletedTaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CompletedTaskListController());
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: GetBuilder<CompletedTaskListController>(
          builder: (controller) {
            if (controller.inProgress) {
              return const Center(child: CircularProgressIndicator());
            }
            
            if (controller.errorMessage != null) {
              showSnackBarMessage(context, controller.errorMessage!);
              return const Center(child: Text('Failed to load tasks'));
            }
            
            return ListView.builder(
              itemCount: controller.completedTaskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskType: TaskType.completed,
                  taskModel: controller.completedTaskList[index],
                  onStatusUpdate: () {
                    controller.getCompletedTaskList();
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