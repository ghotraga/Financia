import 'package:financia/pages/calculators/affordability_page.dart';
import 'package:financia/pages/calculators/mortgage_page.dart';
import 'package:financia/pages/tools/faq_page.dart';
import 'package:flutter/material.dart';
import 'tools/chat_with_advisorpage.dart';
import 'tools/visiting_bankpage.dart';
import 'tools/word_bankpage.dart';
import 'calculators/cash_flowpage.dart';
import 'calculators/tvm_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Financia',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Image
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Image.asset(
              'assets/images/financialSem.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Tools Section
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Tools',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 150, // Adjust the height of the carousel
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              children: [
                _buildSmallCard(
                  context,
                  'Chat with Advisor',
                  'assets/images/chatWithAdvisor.png',
                  const ChatWithAdvisorPage(),
                ),
                _buildSmallCard(
                  context,
                  'Visiting a Bank',
                  'assets/images/visitingABank.png',
                  const VisitingBankPage(),
                ),
                _buildSmallCard(
                  context,
                  'Word Bank',
                  'assets/images/wordBank.png',
                  const WordBankPage(),
                ),
                _buildSmallCard(
                  context,
                  'FAQ',
                  'assets/images/faq.png',
                  const FAQPage(),
                ),
              ],
            ),
          ),
          // Calculators Section
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Calculators',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 150, // Adjust the height of the carousel
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              children: [
                _buildSmallCard(
                  context,
                  'Cash Flow',
                  'assets/images/cashFlowCalc.png',
                  const CashFlowPage(),
                ),
                _buildSmallCard(
                  context,
                  'Mortgage',
                  'assets/images/mortgageCalc.png',
                  const MortgagePage(),
                ),
                _buildSmallCard(
                  context,
                  'TVM',
                  'assets/images/tvmCalc.jpg',
                  const TVMPage(),
                ),
                _buildSmallCard(
                  context,
                  'Affordability',
                  'assets/images/affordabilityCalc.png',
                  const AffordabilityPage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build a smaller card for the horizontal carousel
  Widget _buildSmallCard(BuildContext context, String title, String imagePath, Widget destinationPage) {
    return GestureDetector(
      onTap: () {
        // Use the context passed to the method to navigate
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      },
      child: Container(
        width: 120, // Adjust the width of the card
        margin: const EdgeInsets.only(right: 8.0), // Add spacing between cards
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  imagePath,
                  height: 60, // Adjust the height of the image
                  fit: BoxFit.contain, // Ensure the image fits within the available space
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}