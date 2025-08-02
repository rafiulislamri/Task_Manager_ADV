import 'package:get/get.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/urls.dart';

class CompletedTaskListController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  List<TaskModel> _completedTaskList = [];

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;
  List<TaskModel> get completedTaskList => _completedTaskList;

  Future<bool> getCompletedTaskList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.getCompletedTasksUrl,
    );

    if (response.isSuccess) {
      _completedTaskList = (response.body!['data'] as List)
          .map((json) => TaskModel.fromJson(json))
          .toList();
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage!;
    }

    _inProgress = false;
    update(); 
    return isSuccess;
  }

  @override
  void onInit() {
    getCompletedTaskList();
    super.onInit();
  }
}