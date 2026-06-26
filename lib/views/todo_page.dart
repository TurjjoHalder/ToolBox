import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tool_box/views/add_new_task_screen.dart';
import 'package:tool_box/widget/task_card_widget.dart';
import 'screen_import.dart';

class TasksPage extends StatelessWidget {
  TasksPage({super.key});

  final TodoController controller = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4285F4),
        title: const Text('Tasks'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildTabs(),
          const Divider(height: 1, color: Colors.black12),
          Expanded(
            child: Obx(() {
              if (controller.filteredTasks.isEmpty) {
                return const Center(
                  child: Text(
                    "No tasks yet. Add one!",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: controller.filteredTasks.length,
                itemBuilder: (context, index) {
                  final task = controller.filteredTasks[index];
                  return TaskCard(task: task);
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // Navigates to the AddTaskPage using GetX routing
        onPressed: () => Get.to(() => const AddTaskPage()),
        backgroundColor: const Color(0xFF4285F4),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildTabs() {
    final tabs = ['All', 'Active', 'Completed'];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: tabs.map((tab) {
          return GestureDetector(
            onTap: () => controller.setTab(tab),
            child: Obx(() {
              final isSelected = controller.currentTab.value == tab;
              return Column(
                children: [
                  Text(
                    tab,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected ? const Color(0xFF4285F4) : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 3,
                    width: 40,
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF4285F4) : Colors.transparent,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                    ),
                  )
                ],
              );
            }),
          );
        }).toList(),
      ),
    );
  }
}