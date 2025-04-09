import 'package:flutter/material.dart';

class ContentViewPage extends StatelessWidget {
  final String category;
  final String level;

  const ContentViewPage({super.key, required this.category, required this.level});

  @override
  Widget build(BuildContext context) {
    // Define educational content for each category and level
    final Map<String, Map<String, List<Map<String, String>>>> contentData = {
      'Payment Options': {
        'Beginner': [
          {
            'title': 'What are Payment Options?',
            'description': 'Learn about different payment methods like cash, credit cards, and debit cards.',
          },
          {
            'title': 'How to Use a Credit Card Responsibly',
            'description': 'Understand how to manage credit card usage to avoid debt.',
          },
        ],
        'Intermediate': [
          {
            'title': 'Understanding Credit Card Rewards',
            'description': 'Learn how to maximize cashback and rewards programs.',
          },
          {
            'title': 'Digital Wallets',
            'description': 'Explore how to use digital wallets like Apple Pay and Google Pay.',
          },
        ],
        'Advanced': [
          {
            'title': 'Cryptocurrency Payments',
            'description': 'Dive into the world of cryptocurrency and how it can be used for payments.',
          },
          {
            'title': 'International Wire Transfers',
            'description': 'Learn about sending and receiving money internationally.',
          },
        ],
      },
      'Borrowing': {
        'Beginner': [
          {
            'title': 'What is Borrowing?',
            'description': 'Understand the basics of borrowing money and loans.',
          },
          {
            'title': 'Types of Loans',
            'description': 'Learn about personal loans, car loans, and mortgages.',
          },
        ],
        'Intermediate': [
          {
            'title': 'Understanding Interest Rates',
            'description': 'Learn how interest rates affect your loan repayments.',
          },
          {
            'title': 'Building Credit',
            'description': 'Discover how to build and maintain a good credit score.',
          },
        ],
        'Advanced': [
          {
            'title': 'Debt Consolidation',
            'description': 'Learn how to manage multiple debts effectively.',
          },
          {
            'title': 'Investment Loans',
            'description': 'Explore how to use loans for investment purposes.',
          },
        ],
      },
      'Protection': {
        'Beginner': [
          {
            'title': 'Understanding Insurance Basics',
            'description': 'Learn what insurance is and why it\'s important.',
          },
          {
            'title': 'Types of Insurance',
            'description': 'Explore common types of insurance such as health, auto, and home.',
          },
        ],
        'Intermediate': [
          {
            'title': 'Life Insurance',
            'description': 'Understand different life insurance policies and how they work.',
          },
          {
            'title': 'Health Insurance Plans',
            'description': 'Learn about various health insurance plans and their benefits.',
          },
        ],
        'Advanced': [
          {
            'title': 'Evaluating Insurance Needs',
            'description': 'How to assess your insurance needs at different life stages.',
          },
          {
            'title': 'Insurance as a Financial Tool',
            'description': 'Using insurance strategically to protect and grow wealth.',
          },
        ],
      },
      'Investments': {
        'Beginner': [
          {
            'title': 'Introduction to Investing',
            'description': 'Learn the basics of what investing is all about.',
          },
          {
            'title': 'Types of Investments',
            'description': 'Explore various investment options like stocks, bonds, and mutual funds.',
          },
        ],
        'Intermediate': [
          {
            'title': 'Creating an Investment Strategy',
            'description': 'Learn how to build a personalized investment strategy.',
          },
          {
            'title': 'Risk and Return',
            'description': 'Understanding the relationship between investment risk and potential returns.',
          },
        ],
        'Advanced': [
          {
            'title': 'Portfolio Diversification',
            'description': 'Strategies to diversify your investment portfolio effectively.',
          },
          {
            'title': 'Advanced Investment Vehicles',
            'description': 'Explore complex investment options like derivatives and annuities.',
          },
        ],
      },
    };

    // Get the content for the selected category and level
    final List<Map<String, String>>? contentList = contentData[category]?[level];

    return Scaffold(
      appBar: AppBar(
        title: Text('$category - $level'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: contentList == null || contentList.isEmpty
          ? const Center(
              child: Text(
                'No content available for this category and level.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: contentList.length,
              itemBuilder: (context, index) {
                final content = contentList[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  child: ListTile(
                    title: Text(
                      content['title']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(content['description']!),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      // Navigate to a detailed view or additional resources
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailedContentPage(
                            title: content['title']!,
                            description: content['description']!,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}

class DetailedContentPage extends StatelessWidget {
  final String title;
  final String description;

  const DetailedContentPage({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Add functionality for additional resources or actions
              },
              child: const Text('View More Resources'),
            ),
          ],
        ),
      ),
    );
  }
}