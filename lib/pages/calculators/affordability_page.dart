import 'dart:math';

import 'package:flutter/material.dart';

class AffordabilityPage extends StatefulWidget {
  const AffordabilityPage({super.key});

  @override
  State<AffordabilityPage> createState() => _AffordabilityPageState();
}

class _AffordabilityPageState extends State<AffordabilityPage> {
  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _expensesController = TextEditingController();
  final TextEditingController _loanTermController = TextEditingController();
  final TextEditingController _interestRateController = TextEditingController();

  double? _affordableAmount;

  void _calculateAffordability() {
    try {
      final double income = double.parse(_incomeController.text);
      final double expenses = double.parse(_expensesController.text);
      final int loanTerm = int.parse(_loanTermController.text);
      final double interestRate = double.parse(_interestRateController.text) / 100;

      // Calculate monthly savings
      final double monthlySavings = income - expenses;

      if (monthlySavings <= 0) {
        setState(() {
          _affordableAmount = 0;
        });
        return;
      }

      // Calculate the affordable loan amount using a simple formula
      final double monthlyInterestRate = interestRate / 12;
      final int totalMonths = loanTerm * 12;
      final double affordableLoan = monthlySavings *
          ((1 - (1 / pow(1 + monthlyInterestRate, totalMonths))) / monthlyInterestRate);

      setState(() {
        _affordableAmount = affordableLoan;
      });
    } catch (e) {
      setState(() {
        _affordableAmount = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid numbers.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Affordability Calculator',
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your details:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _incomeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Monthly Income',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _expensesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Monthly Expenses',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _loanTermController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Loan Term (in years)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _interestRateController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Interest Rate (%)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: _calculateAffordability,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text(
                  'Calculate',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (_affordableAmount != null)
              Center(
                child: Text(
                  'You can afford to borrow: \$${_affordableAmount!.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}