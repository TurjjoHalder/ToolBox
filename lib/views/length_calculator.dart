
import 'package:flutter/material.dart';


class LengthConverterScreen extends StatefulWidget {
  const LengthConverterScreen({super.key});

  @override
  State<LengthConverterScreen> createState() =>
      _LengthConverterScreenState();
}

class _LengthConverterScreenState
    extends State<LengthConverterScreen> {
  final TextEditingController controller =
      TextEditingController();

  final Map<String, double> units = {
    'Meter': 1,
    'Feet': 3.28084,
    'Kilometer': 0.001,
    'Mile': 0.000621371,
    'Inch': 39.3701,
    'Yard': 1.09361,
  };

  String fromUnit = 'Meter';
  String toUnit = 'Feet';

  double result = 0;

  void convert() {
    double input =
        double.tryParse(controller.text) ?? 0;

    double meters = input / units[fromUnit]!;
    double converted = meters * units[toUnit]!;

    setState(() {
      result = converted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Length Converter"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Card(
                          
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        const Text(
                          "Result",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          result.toStringAsFixed(2),
                          style: const TextStyle(
                            fontSize: 28,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(toUnit),
                      ],
                    ),
                  ),
                ),
              ),
          
              const SizedBox(height: 40),
              TextField(
                controller: controller,
                keyboardType:
                    const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: "Enter Value",
                  border: OutlineInputBorder(),
                ),
              ),
          
              const SizedBox(height: 20),
          
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: fromUnit,
                      decoration: const InputDecoration(
                        labelText: "From",
                        border: OutlineInputBorder(),
                      ),
                      items: units.keys.map((unit) {
                        return DropdownMenuItem(
                          value: unit,
                          child: Text(unit, style: const TextStyle(fontSize: 16, ),),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          fromUnit = value!;
                        });
                      },
                    ),
                  ),
          
                  const SizedBox(width: 15),
          
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: toUnit,
                      decoration: const InputDecoration(
                        labelText: "To",
                        border: OutlineInputBorder(),
                      ),
                      items: units.keys.map((unit) {
                        return DropdownMenuItem(
                          value: unit,
                          child: Text(unit, style: const TextStyle(fontSize: 16),),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          toUnit = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
          
              const SizedBox(height: 25),
          
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                  onPressed: convert,
                  child: const Text(
                    "Convert",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
          
              const SizedBox(height: 30),
          
              
            ],
          ),
        ),
      ),
    );
  }
}