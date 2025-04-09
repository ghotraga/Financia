import 'package:flutter/material.dart';
import 'dart:math';

class TVMPage extends StatefulWidget {
  const TVMPage({super.key});

  @override
  State<TVMPage> createState() => _TVMPageState();
}

class _TVMPageState extends State<TVMPage> {
  final TextEditingController _moneyController = TextEditingController();
  final TextEditingController _interestController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();
  final TextEditingController _compoundRateController = TextEditingController();

  String _calculationType = "Present"; // Default to Present Value
  String _result = "";

  void _calculate() {
    if (_moneyController.text.isEmpty ||
        _interestController.text.isEmpty ||
        _yearsController.text.isEmpty ||
        _compoundRateController.text.isEmpty) {
      setState(() {
        _result = "At least one of the fields is missing values!";
      });
      return;
    }

    try {
      double money = double.parse(_moneyController.text);
      double interestRate = double.parse(_interestController.text) / 100;
      double years = double.parse(_yearsController.text);
      double compoundRate = double.parse(_compoundRateController.text);

      double finalValue = 0.0;

      if (_calculationType == "Present") {
        finalValue = money / pow((1 + interestRate), years * compoundRate);
        finalValue = (finalValue * 100).roundToDouble() / 100.0;

        _showResultDialog(
          "Calculation Result",
          "The above calculation shows you that the future value of \$${money.toStringAsFixed(2)} with ${_interestController.text}% interest compounded ${compoundRate.toInt()} times for ${years.toInt()} year(s) is worth \$${finalValue.toStringAsFixed(2)} today.",
        );
      } else {
        finalValue = money * pow((1 + interestRate), years * compoundRate);
        finalValue = (finalValue * 100).roundToDouble() / 100.0;

        _showResultDialog(
          "Calculation Result",
          "The above calculation shows you that with \$${money.toStringAsFixed(2)} and you're earning ${_interestController.text}% interest on that sum compounded ${compoundRate.toInt()} times for ${years.toInt()} year(s), it is worth \$${finalValue.toStringAsFixed(2)}.",
        );
      }
    } catch (e) {
      setState(() {
        _result = "Invalid input. Please enter valid numbers.";
      });
    }
  }

  void _showResultDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Time Value of Money"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calculation Type Switch
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: const Text("PV"),
                  selected: _calculationType == "Present",
                  onSelected: (selected) {
                    setState(() {
                      _calculationType = "Present";
                    });
                  },
                ),
                const SizedBox(width: 16),
                ChoiceChip(
                  label: const Text("FV"),
                  selected: _calculationType == "Future",
                  onSelected: (selected) {
                    setState(() {
                      _calculationType = "Future";
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Input Fields
            _buildTextField("Amount of Money", _moneyController),
            const SizedBox(height: 16),
            _buildTextField("Interest Rate (%)", _interestController),
            const SizedBox(height: 16),
            _buildTextField("Years", _yearsController),
            const SizedBox(height: 16),
            _buildTextField("Compounded Period (1-4)", _compoundRateController),
            const SizedBox(height: 16),
            // Calculate Button
            Center(
              child: ElevatedButton(
                onPressed: _calculate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  "Calculate",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Result
            Center(
              child: Text(
                _result,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}