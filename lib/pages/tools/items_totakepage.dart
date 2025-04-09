import 'package:flutter/material.dart';

class ItemsToTakePage extends StatelessWidget {
  final String question;

  const ItemsToTakePage({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    final Map<String, List<String>> items = {
      'Open a new account': ['ID Proof', 'Address Proof', 'Initial Deposit'],
      'Deposit money': ['Cash', 'Deposit Slip'],
      'Withdraw money': ['ID Proof', 'Withdrawal Slip'],
      'Apply for a loan': ['ID Proof', 'Income Proof', 'Loan Application Form'],
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('Items to Take'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: ListView.builder(
        itemCount: items[question]?.length ?? 0,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[question]![index]),
          );
        },
      ),
    );
  }
}