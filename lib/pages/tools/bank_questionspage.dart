import 'package:financia/pages/tools/items_totakepage.dart';
import 'package:flutter/material.dart';

class BankQuestionsPage extends StatelessWidget {
  final String bankName;

  const BankQuestionsPage({super.key, required this.bankName});

  @override
  Widget build(BuildContext context) {
    final List<String> questions = [
      'Open a new account',
      'Deposit money',
      'Withdraw money',
      'Apply for a loan',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Why are you visiting $bankName?'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(questions[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemsToTakePage(question: questions[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}