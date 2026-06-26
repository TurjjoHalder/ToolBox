import 'package:get/get.dart';
import 'package:tool_box/model/todo.dart';
class TodoController extends GetxController {
  // Started completely empty as requested
  var tasks = <Todo>[].obs;
  var currentTab = 'All'.obs;

  List<Todo> get filteredTasks {
    if (currentTab.value == 'Active') {
      return tasks.where((task) => !task.isCompleted).toList();
    } else if (currentTab.value == 'Completed') {
      return tasks.where((task) => task.isCompleted).toList();
    }
    return tasks;
  }

  void toggleTaskCompletion(Todo task) {
    task.toggleCompleted();
    tasks.refresh(); 
  }

  void deleteTask(String id) {
    tasks.removeWhere((task) => task.id == id);
  }

  void setTab(String tab) {
    currentTab.value = tab;
  }

  // Updated to accept data from the form
  void addNewTask(String title, String description) {
    tasks.add(
      Todo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        description: description,
        isCompleted: false,
        createdAt: DateTime.now(), // Sets current time
      ),
    );
  }
}