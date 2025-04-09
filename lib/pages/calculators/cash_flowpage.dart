import 'package:financia/pages/calculators/cash_flowgraphpage.dart';
import 'package:flutter/material.dart';

class CashFlowPage extends StatefulWidget {
  const CashFlowPage({super.key});

  @override
  State<CashFlowPage> createState() => _CashFlowCalculatorPageState();
}

class _CashFlowCalculatorPageState extends State<CashFlowPage> {
  final TextEditingController _nameController = TextEditingController();
  double _amount = 250;
  String _statementType = "Income";
  final List<Map<String, dynamic>> _cashFlowArray = [];

  void _saveStatement() {
    if (_nameController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Warning"),
          content: const Text(
              "You have not completed the form. Please complete the missing fields."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Ok, I got it!"),
            ),
          ],
        ),
      );
    } else {
      setState(() {
        _cashFlowArray.add({
          "name": _nameController.text,
          "amount": _amount.toInt(),
          "type": _statementType,
        });
        _nameController.clear();
        _amount = 250;
      });
    }
  }

  void _navigateToGraph() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CashFlowGraphPage(data: _cashFlowArray),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cash Flow Calculator"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Income/Expense Switch
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: const Text("Income"),
                  selected: _statementType == "Income",
                  onSelected: (selected) {
                    setState(() {
                      _statementType = "Income";
                    });
                  },
                ),
                const SizedBox(width: 16),
                ChoiceChip(
                  label: const Text("Expense"),
                  selected: _statementType == "Expense",
                  onSelected: (selected) {
                    setState(() {
                      _statementType = "Expense";
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Name Input
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Enter the name of cash flow",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Slider
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("The amount is \$${_amount.toInt()}"),
                Slider(
                  value: _amount,
                  min: 0,
                  max: 1000,
                  divisions: 100,
                  label: _amount.toInt().toString(),
                  onChanged: (value) {
                    setState(() {
                      _amount = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Save Button
            ElevatedButton(
              onPressed: _saveStatement,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
              ),
              child: const Text("Save"),
            ),
            const SizedBox(height: 16),
            // Navigate to Graph
            ElevatedButton(
              onPressed: _navigateToGraph,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
              ),
              child: const Text("View Graphical Representation"),
            ),
          ],
        ),
      ),
    );
  }
}