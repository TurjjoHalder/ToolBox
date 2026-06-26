import 'package:flutter/material.dart';

class BmiCalculatorPage extends StatefulWidget {
  const BmiCalculatorPage({super.key});

  @override
  State<BmiCalculatorPage> createState() => _BmiCalculatorPageState();
}

class _BmiCalculatorPageState extends State<BmiCalculatorPage> {
  // Pre-filled with default values for quick testing
  final TextEditingController _feetController = TextEditingController();
  final TextEditingController _inchesController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  double _bmi = 0.0;
  String _bmiCategory = '';
  String _bmiMessage = '';

  @override
  void initState() {
    super.initState();
    _calculateBMI(); // Calculate initially so the screen isn't blank
  }

  @override
  void dispose() {
    _feetController.dispose();
    _inchesController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _calculateBMI() {
    // Safely parse the inputs
    double feet = double.tryParse(_feetController.text) ?? 0;
    double inches = double.tryParse(_inchesController.text) ?? 0;
    double weight = double.tryParse(_weightController.text) ?? 0;

    if (feet == 0 && inches == 0 || weight == 0) return;

    // Convert height to meters
    double totalInches = (feet * 12) + inches;
    double heightInMeters = totalInches * 0.0254;

    // Calculate BMI
    double bmiResult = weight / (heightInMeters * heightInMeters);

    // Determine category
    String category;
    String message;

    if (bmiResult < 18.5) {
      category = 'Underweight';
      message = 'You may need to gain some weight.';
    } else if (bmiResult >= 18.5 && bmiResult <= 24.9) {
      category = 'Normal';
      message = 'You have a healthy body weight. Great job!';
    } else if (bmiResult >= 25 && bmiResult <= 29.9) {
      category = 'Overweight';
      message = 'You may need to lose some weight.';
    } else {
      category = 'Obese';
      message = 'Please consult a doctor for a health plan.';
    }

    setState(() {
      _bmi = bmiResult;
      _bmiCategory = category;
      _bmiMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA), // Very soft off-white background
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        
        title: const Text(
          'BMI Calculator',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildResultCard(),
            const SizedBox(height: 24),
            _buildInputCard(),
            const SizedBox(height: 24),
            _buildScaleCard(),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // 1. RESULT CARD (Gradient Top Section)
  // ==========================================
  Widget _buildResultCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF11998E), Color(0xFF38EF7D)], // Sleek Teal/Emerald
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF11998E).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Your BMI',
            style: TextStyle(color: Colors.white70, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          Text(
            _bmi.toStringAsFixed(1),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 64,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _bmiCategory,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _bmiMessage,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ==========================================
  // 2. INPUT CARD
  // ==========================================
  Widget _buildInputCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Enter your details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 24),
          
          // Height Inputs (Feet & Inches side-by-side)
          Row(
            children: [
              Expanded(
                child: _customTextField(
                  controller: _feetController,
                  label: 'Feet',
                  icon: Icons.height,
                  hintText: '5',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _customTextField(
                  controller: _inchesController,
                  label: 'Inches',
                  icon: Icons.unfold_more,
                  hintText: '4',

                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Weight Input
          _customTextField(
            controller: _weightController,
            label: 'Weight (kg)',
            icon: Icons.monitor_weight_outlined,
            hintText: '58',

          ),
          const SizedBox(height: 30),
          
          // Calculate Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                FocusScope.of(context).unfocus(); // Close keyboard
                _calculateBMI();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF11998E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Calculate BMI',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Custom styling for the text fields
  Widget _customTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hintText,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        prefixIcon: Icon(icon, color: Colors.grey.shade400, size: 20),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF11998E), width: 2),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  // ==========================================
  // 3. BMI SCALE LEGEND CARD
  // ==========================================
  Widget _buildScaleCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'BMI Scale',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 16),
          _scaleRow('Underweight', '< 18.5', Colors.blue),
          _scaleRow('Normal', '18.5 - 24.9', Colors.green),
          _scaleRow('Overweight', '25.0 - 29.9', Colors.orange),
          _scaleRow('Obese', '≥ 30.0', Colors.red),
        ],
      ),
    );
  }

  // Helper for the colored dots in the scale
  Widget _scaleRow(String label, String range, Color color) {
    // Bold the text if this row matches the user's current category
    bool isCurrent = _bmiCategory == label;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
                  color: isCurrent ? Colors.black : Colors.grey.shade700,
                ),
              ),
            ],
          ),
          Text(
            range,
            style: TextStyle(
              fontSize: 15,
              fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
              color: isCurrent ? Colors.black : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}