import 'dart:math';

import 'package:flutter/material.dart';

class MortgagePage extends StatefulWidget {
  const MortgagePage({super.key});

  @override
  State<MortgagePage> createState() => _MortgagePageState();
}

class _MortgagePageState extends State<MortgagePage> {
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _interestRateController = TextEditingController();
  final TextEditingController _loanTermController = TextEditingController();

  double? _monthlyPayment;

  void _calculateMortgage() {
    try {
      final double loanAmount = double.parse(_loanAmountController.text);
      final double interestRate = double.parse(_interestRateController.text) / 100;
      final int loanTerm = int.parse(_loanTermController.text);

      // Calculate monthly interest rate
      final double monthlyInterestRate = interestRate / 12;

      // Calculate total number of payments (months)
      final int totalMonths = loanTerm * 12;

      // Calculate monthly payment using the formula for an annuity
      final double monthlyPayment = loanAmount *
          (monthlyInterestRate * pow(1 + monthlyInterestRate, totalMonths)) /
          (pow(1 + monthlyInterestRate, totalMonths) - 1);

      setState(() {
        _monthlyPayment = monthlyPayment;
      });
    } catch (e) {
      setState(() {
        _monthlyPayment = null;
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
          'Mortgage Calculator',
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
              controller: _loanAmountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Loan Amount',
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
            const SizedBox(height: 16),
            TextField(
              controller: _loanTermController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Loan Term (in years)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: _calculateMortgage,
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
            if (_monthlyPayment != null)
              Center(
                child: Text(
                  'Your Monthly Payment: \$${_monthlyPayment!.toStringAsFixed(2)}',
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