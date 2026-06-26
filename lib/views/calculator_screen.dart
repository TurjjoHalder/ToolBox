import 'package:flutter/material.dart';
import 'dart:math';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  // We now track the equation in three distinct parts
  String _val1 = "";
  String _operand = "";
  String _val2 = "";

  // Dynamically builds the string shown on the calculator screen
  String get _displayText {
    if (_val1.isEmpty) return "0";
    String res = _val1;
    if (_operand.isNotEmpty) res += " $_operand ";
    if (_val2.isNotEmpty) res += _val2;
    return res;
  }

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        // Clear all
        _val1 = "";
        _operand = "";
        _val2 = "";
      } else if (buttonText == "⌫") {
        // Backspace logic steps backwards through the equation
        if (_val2.isNotEmpty) {
          _val2 = _val2.substring(0, _val2.length - 1);
        } else if (_operand.isNotEmpty) {
          _operand = "";
        } else if (_val1.isNotEmpty) {
          _val1 = _val1.substring(0, _val1.length - 1);
        }
      } else if (buttonText == "x²") {
        // Squares the currently active number
        if (_val2.isNotEmpty) {
          double v = double.tryParse(_val2) ?? 0;
          _val2 = _formatOutput(v * v);
        } else if (_val1.isNotEmpty) {
          double v = double.tryParse(_val1) ?? 0;
          _val1 = _formatOutput(v * v);
        }
      } else if (buttonText == "√x") {
        // Square roots the currently active number
        if (_val2.isNotEmpty) {
          double v = double.tryParse(_val2) ?? 0;
          _val2 = v >= 0 ? _formatOutput(sqrt(v)) : "Error";
        } else if (_val1.isNotEmpty) {
          double v = double.tryParse(_val1) ?? 0;
          _val1 = v >= 0 ? _formatOutput(sqrt(v)) : "Error";
        }
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "×" || buttonText == "÷") {
        // Operator logic
        if (_val1.isEmpty) _val1 = "0"; // Default to 0 if operator pressed first
        if (_val1 == "Error") return; 
        
        if (_val2.isNotEmpty) {
          // If we already have a full equation (e.g., 5 + 5), evaluate it before adding the new operator
          _calculateResult();
        }
        _operand = buttonText;
      } else if (buttonText == ".") {
        // Decimal logic properly separated for the first and second number
        if (_operand.isEmpty) {
          if (!_val1.contains(".")) {
            _val1 = _val1.isEmpty ? "0." : "$_val1.";
          }
        } else {
          if (!_val2.contains(".")) {
            _val2 = _val2.isEmpty ? "0." : "$_val2.";
          }
        }
      } else if (buttonText == "=") {
        _calculateResult();
      } else {
        // Number entry logic
        if (_val1 == "Error") {
          _val1 = buttonText; // Reset if typing after an error
        } else if (_operand.isEmpty) {
          // Modifying the first number
          if (_val1 == "0") {
            _val1 = buttonText;
          } else {
            _val1 += buttonText;
          }
        } else {
          // Modifying the second number
          if (_val2 == "0") {
            _val2 = buttonText;
          } else {
            _val2 += buttonText;
          }
        }
      }
    });
  }

  void _calculateResult() {
    if (_val1.isEmpty || _operand.isEmpty || _val2.isEmpty) return;

    double num1 = double.tryParse(_val1) ?? 0;
    double num2 = double.tryParse(_val2) ?? 0;
    double result = 0;

    if (_operand == "+") result = num1 + num2;
    if (_operand == "-") result = num1 - num2;
    if (_operand == "×") result = num1 * num2;
    if (_operand == "÷") {
      if (num2 == 0) {
        _val1 = "Error";
        _operand = "";
        _val2 = "";
        return;
      }
      result = num1 / num2;
    }

    _val1 = _formatOutput(result);
    _operand = "";
    _val2 = "";
  }

  String _formatOutput(double value) {
    String result = value.toString();
    if (result.endsWith(".0")) {
      result = result.substring(0, result.length - 2); // Remove trailing .0
    }
    // Prevent the string from becoming infinitely long
    if (result.length > 15) {
      result = result.substring(0, 15);
    }
    return result;
  }

  Widget _buildButton(String buttonText, Color textColor, Color bgColor) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(20.0),
            elevation: 0,
          ),
          onPressed: () => _buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.w400,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color bgGrey = Color(0xFF2E2E2E);
    const Color numGrey = Color(0xFF424242);
    const Color opGrey = Color(0xFF5E5E5E);
    const Color actionLightGrey = Color(0xFFB0B0B0);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculator',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      backgroundColor: bgGrey,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                // FittedBox shrinks the text automatically if the equation gets too wide
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: Text(
                    _displayText,
                    style: const TextStyle(
                      fontSize: 72.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            
            const Divider(color: Colors.white12, height: 1),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildButton("C", Colors.black, actionLightGrey),
                      _buildButton("⌫", Colors.black, actionLightGrey),
                      _buildButton("x²", Colors.black, actionLightGrey),
                      _buildButton("√x", Colors.black, actionLightGrey),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton("7", Colors.white, numGrey),
                      _buildButton("8", Colors.white, numGrey),
                      _buildButton("9", Colors.white, numGrey),
                      _buildButton("÷", Colors.white, opGrey),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton("4", Colors.white, numGrey),
                      _buildButton("5", Colors.white, numGrey),
                      _buildButton("6", Colors.white, numGrey),
                      _buildButton("×", Colors.white, opGrey),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton("1", Colors.white, numGrey),
                      _buildButton("2", Colors.white, numGrey),
                      _buildButton("3", Colors.white, numGrey),
                      _buildButton("-", Colors.white, opGrey),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton(".", Colors.white, numGrey),
                      _buildButton("0", Colors.white, numGrey),
                      _buildButton("=", Colors.white, opGrey),
                      _buildButton("+", Colors.white, opGrey),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}