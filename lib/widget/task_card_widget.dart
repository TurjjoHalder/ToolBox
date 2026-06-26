import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:tool_box/controllers/todo_controller.dart';
import 'package:tool_box/model/todo.dart';

class TaskCard extends StatelessWidget {
  final Todo task;
  final TodoController controller = Get.find();

  TaskCard({super.key, required this.task});

  // Helper to nicely format the DateTime object
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return 'Today';
    }
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    // We don't need Obx inside the card anymore because the Obx on the ListView 
    // forces the cards to rebuild when controller.tasks.refresh() is called.
    final isDone = task.isCompleted;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDone ? Colors.grey.shade200 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          if (!isDone)
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
            border: Border(
              bottom: BorderSide(color: Colors.redAccent, width: 2),

            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Checkbox
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: isDone,
                  onChanged: (value) => controller.toggleTaskCompletion(task),
                  activeColor: const Color(0xFF4285F4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              
              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isDone ? Colors.grey : Colors.black87,
                        decoration: isDone ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      task.description,
                      style: TextStyle(
                        fontSize: 13,
                        color: isDone ? Colors.grey : Colors.grey.shade600,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _formatDate(task.createdAt),
                      style: TextStyle(
                        fontSize: 12,
                        color: isDone ? Colors.grey : Colors.grey.shade400,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Delete Button
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.redAccent,
                  size: 24,
                ),
                onPressed: () => controller.deleteTask(task.id),
              ),
            ],
          ),
        ),
      ),
    );
  }
}