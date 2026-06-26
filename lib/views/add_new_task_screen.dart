import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:tool_box/widget/core_input_field_widget.dart';
import 'screen_import.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Fetch the GetX controller instead of Provider
  final TodoController controller = Get.find<TodoController>();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CoreInputField(
                controller: _titleController,
                keyboardType: TextInputType.text,
                maxLines: 1,
                labelText: "Task Title",
                // Simple inline validation replacing CustomValidators
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a title'
                    : null,
              ),
              const SizedBox(height: 20),
              CoreInputField(
                controller: _descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: 6,
                labelText: "Task Description",
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a description'
                    : null,
              ),

              const SizedBox(height: 20),
              SizedBox(
                height: 60,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Add task via GetX controller
                      controller.addNewTask(
                        _titleController.text,
                        _descriptionController.text,
                      );
                      Get.back();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Task added successfully!",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text("Add Task"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
