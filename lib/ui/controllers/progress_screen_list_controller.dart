import 'package:get/get.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/urls.dart';

class ProgressTaskListController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  List<TaskModel> _progressTaskList = [];

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;
  List<TaskModel> get progressTaskList => _progressTaskList;

  Future<bool> getProgressTaskList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.getProgressTasksUrl,
    );

    if (response.isSuccess) {
      _progressTaskList = (response.body!['data'] as List)
          .map((json) => TaskModel.fromJson(json))
          .toList();
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

  @override
  void onInit() {
    getProgressTaskList();
    super.onInit();
  }
}