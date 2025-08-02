import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/widgets/task_card.dart';
import 'package:task_manager/ui/controllers/progress_screen_list_controller.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';

class ProgressTaskListScreen extends StatelessWidget {
  const ProgressTaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProgressTaskListController());
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: GetBuilder<ProgressTaskListController>(
          builder: (controller) {
            if (controller.inProgress) {
              return const CenteredCircularProgressIndicator();
            }
            
            if (controller.errorMessage != null) {
              showSnackBarMessage(context, controller.errorMessage!);
              return ListView(); // Empty list view as fallback
            }
            
            return ListView.builder(
              itemCount: controller.progressTaskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskType: TaskType.progress,
                  taskModel: controller.progressTaskList[index],
                  onStatusUpdate: controller.getProgressTaskList,
                );
              },
            );
          },
        ),
      ),
    );
  }
}