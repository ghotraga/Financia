import 'package:financia/pages/content/level_selectionpage.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  final String category;

  const QuizPage({super.key, required this.category});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Map<String, dynamic>> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedAnswer;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  void _loadQuestions() {
    // Define questions for each category
    final Map<String, List<Map<String, dynamic>>> categoryQuestions = {
      'Payment Options': [
        {
          'question': 'Which payment method is the most secure?',
          'options': ['Cash', 'Credit Card', 'Debit Card', 'Cryptocurrency'],
          'answer': 1,
        },
        {
          'question': 'What is a common benefit of using a credit card?',
          'options': ['Cashback rewards', 'No interest', 'Unlimited spending', 'No fees'],
          'answer': 0,
        },
        {
          'question': 'What is the main purpose of a debit card?',
          'options': ['Borrow money', 'Access your bank account', 'Earn rewards', 'Invest'],
          'answer': 1,
        },
        {
          'question': 'Which payment method is best for budgeting?',
          'options': ['Credit Card', 'Cash', 'Debit Card', 'Cryptocurrency'],
          'answer': 2,
        },
        {
          'question': 'What is the risk of using cash?',
          'options': ['It can be lost or stolen', 'It earns interest', 'It has high fees', 'It is not accepted anywhere'],
          'answer': 0,
        },
      ],
      'Borrowing': [
        {
          'question': 'Which loan typically has the highest interest rate?',
          'options': ['Mortgage', 'Car Loan', 'Credit Card', 'Personal Loan'],
          'answer': 2,
        },
        {
          'question': 'What is a credit score used for?',
          'options': ['To determine loan eligibility', 'To calculate taxes', 'To open a bank account', 'To invest in stocks'],
          'answer': 0,
        },
        {
          'question': 'What is the main benefit of a low-interest loan?',
          'options': ['Lower monthly payments', 'Higher credit score', 'No repayment required', 'Unlimited borrowing'],
          'answer': 0,
        },
        {
          'question': 'What is a secured loan?',
          'options': ['A loan backed by collateral', 'A loan with no interest', 'A loan with no repayment', 'A loan for students'],
          'answer': 0,
        },
        {
          'question': 'What happens if you miss a loan payment?',
          'options': ['Your credit score may decrease', 'You earn rewards', 'The loan is forgiven', 'Nothing happens'],
          'answer': 0,
        },
      ],
      'Protection': [
      {
        'question': 'What is the primary purpose of insurance?',
        'options': ['To save money', 'To protect against financial loss', 'To earn rewards', 'To increase assets'],
        'answer': 1,
      },
      {
        'question': 'What type of insurance is essential for car owners?',
        'options': ['Health insurance', 'Life insurance', 'Auto insurance', 'Home insurance'],
        'answer': 2,
      },
      {
        'question': 'What does term life insurance provide?',
        'options': ['Coverage for a specific period', 'Coverage for a lifetime', 'Investment opportunities', 'Medical benefits'],
        'answer': 0,
      },
      {
        'question': 'What is a deductible in an insurance policy?',
        'options': ['The premium amount', 'The amount paid out by the insurer', 'The amount you pay before insurance covers the rest', 'A type of claim'],
        'answer': 2,
      },
      {
        'question': 'What is the benefit of having health insurance?',
        'options': ['Covers medical expenses', 'Increases income', 'Lowers tax liability', 'Increases investment risk'],
        'answer': 0,
      },
    ],
    
    'Investments': [
      {
        'question': 'What is a stock?',
        'options': ['A type of bond', 'An ownership share in a company', 'A physical commodity', 'A type of bank account'],
        'answer': 1,
      },
      {
        'question': 'What is diversification in investing?',
        'options': ['Investing in one type of asset', 'Spreading investments across various assets', 'Investing in high-risk assets only', 'Avoiding international investments'],
        'answer': 1,
      },
      {
        'question': 'What does ROI stand for?',
        'options': ['Rate of Interest', 'Return on Investment', 'Rate of Inflation', 'Return on Income'],
        'answer': 1,
      },
      {
        'question': 'What is a mutual fund?',
        'options': ['A personal savings account', 'A pool of funds invested in various assets', 'A single corporate bond', 'A government loan'],
        'answer': 1,
      },
      {
        'question': 'What is the main advantage of a long-term investment horizon?',
        'options': ['Quick returns', 'Reduced risk from market fluctuations', 'Higher interest rates', 'Greater liquidity'],
        'answer': 1,
      },
      ],
    };

    // Load questions for the selected category
    setState(() {
      _questions.addAll(categoryQuestions[widget.category] ?? []);
    });
  }

  void _submitAnswer() {
    // Check if the selected answer is correct and update the score
    if (_selectedAnswer == _questions[_currentQuestionIndex]['answer']) {
      _score++;
    }

    // Check if there are more questions
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = null; // Reset the selected answer for the next question
      });
    } else {
      // Navigate to the Level Selection Page after the quiz is completed
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LevelSelectionPage(
            category: widget.category,
            score: _score, // Pass the final score to the next page
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('${widget.category} Quiz'),
          backgroundColor: Colors.orangeAccent,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} Quiz'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question ${_currentQuestionIndex + 1} of ${_questions.length}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              currentQuestion['question'],
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Column(
              children: List.generate(currentQuestion['options'].length, (index) {
                return RadioListTile<int>(
                  title: Text(currentQuestion['options'][index]),
                  value: index,
                  groupValue: _selectedAnswer,
                  onChanged: (value) {
                    setState(() {
                      _selectedAnswer = value;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _selectedAnswer == null ? null : _submitAnswer,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: Text(
                _currentQuestionIndex < _questions.length - 1 ? 'Next' : 'Finish',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}