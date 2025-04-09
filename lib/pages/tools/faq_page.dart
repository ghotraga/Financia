import 'package:flutter/material.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  final List<Map<String, String>> _faqList = [
    {
      'question': 'What is Financia?',
      'answer': 'Financia is a financial management app designed to help you manage your finances effectively.'
    },
    {
      'question': 'How do I use the affordability calculator?',
      'answer': 'Enter your income, expenses, loan term, and interest rate to calculate how much you can afford to borrow.'
    },
    {
      'question': 'How do I use the mortgage calculator?',
      'answer': 'Enter the loan amount, interest rate, and loan term to calculate your monthly mortgage payment.'
    },
    {
      'question': 'Is my data secure?',
      'answer': 'Yes, Financia uses industry-standard encryption to ensure your data is safe and secure.'
    },
    {
      'question': 'Can I access Financia on multiple devices?',
      'answer': 'Yes, you can log in to your account on multiple devices and access your data seamlessly.'
    },
  ];

  final List<bool> _expanded = [];

  @override
  void initState() {
    super.initState();
    // Initialize the expanded state for each FAQ item
    _expanded.addAll(List.generate(_faqList.length, (_) => false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FAQ',
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _faqList.length,
        itemBuilder: (context, index) {
          final faq = _faqList[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12.0),
            child: ExpansionPanelList(
              elevation: 1,
              expandedHeaderPadding: EdgeInsets.zero,
              expansionCallback: (panelIndex, isExpanded) {
                setState(() {
                  _expanded[index] = !isExpanded;
                });
              },
              children: [
                ExpansionPanel(
                  isExpanded: _expanded[index],
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      title: Text(
                        faq['question']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    );
                  },
                  body: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      faq['answer']!,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}