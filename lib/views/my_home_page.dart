import 'package:flutter/material.dart';
import 'package:tool_box/views/bmi_calculator.dart';
import 'screen_import.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(Colors.blueAccent.value),
        title: Row(
          children: [
            const Icon(Icons.category_rounded),
            const SizedBox(width: 8),
            const Text('Tool Box'),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Expanded(
                child: ListView(
                  children: [
                    _toolCard(
                      title: 'Calculator',
                      description: 'Perform mathematical calculations',
                      icon: Icons.calculate,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Calculator(),
                        ),
                      ),
                      color: Colors.purpleAccent,
                    ),
                    _toolCard(
                      title: 'Counter',
                      description: 'Count items or events',
                      icon: Icons.add_circle_outline,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CounterScreen(),
                        ),
                      ),
                      color: Colors.green,
                    ),
                    _toolCard(
                      title: 'Length Converter',
                      description: 'Convert between different length units',
                      icon: Icons.straighten,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LengthConverterScreen(),
                        ),
                      ),

                      color: Colors.orange,
                    ),
                    _toolCard(
                      title: 'Todo Manager',
                      description: 'Manage and organize your everyday tasks',
                      icon: Icons.list_alt,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TasksPage()),
                      ),
                      color: Colors.blueAccent,
                    ),
                    _toolCard(
                      title: 'BMI Calculator',
                      description: 'Calculate your Body Mass Index',
                      icon: Icons.calculate,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BmiCalculatorPage(),
                        ),
                      ),
                      color: Colors.teal,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _toolCard({
  required String title,
  required String description,
  required IconData icon,
  required VoidCallback? onTap,
  required Color? color,
}) {
  return Card(
    elevation: 4,
    color: color,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: ListTile(
      leading: Icon(icon, size: 35, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
      subtitle: Text(description, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
    ),
  );
}
