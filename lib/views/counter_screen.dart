import 'package:flutter/material.dart';
import 'package:tool_box/controllers/count_controller.dart';
import 'package:get/get.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  final CounterController controller = Get.put(CounterController());
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: const Color(0xFFF7F8FC),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Count Display Card
              Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                  color: const Color(0xFF5B7FFF),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent,
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Center(
                  child: Obx(() => Text(
                      "${controller.count}",
                      style: const TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// Decrease + Reset
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 80,
                      child: ElevatedButton(
                        onPressed: controller.decrement,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF6B81),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          elevation: 8,
                        ),
                        child: const Icon(
                          Icons.remove,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 80,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.reset();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF42E2C8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          elevation: 8,
                        ),
                        child: const Text(
                          "Reset",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 50),

              /// Increment Button
              SizedBox(
                width: double.infinity,
                height: 110,
                child: ElevatedButton(
                  onPressed: () {
                    controller.increment();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5B7FFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 10,
                  ),
                  child: const Icon(Icons.add, size: 50, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
