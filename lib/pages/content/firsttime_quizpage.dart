import 'package:financia/pages/content/level_selectionpage.dart';
import 'package:financia/pages/content/levelquiz_page.dart';
import 'package:flutter/material.dart';

class FirstTimePromptPage extends StatefulWidget {
  final String category;

  const FirstTimePromptPage({super.key, required this.category});

  @override
  State<FirstTimePromptPage> createState() => _FirstTimePromptPageState();
}

class _FirstTimePromptPageState extends State<FirstTimePromptPage> {
  bool _hasCompletedQuiz = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Time in ${widget.category}?'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_hasCompletedQuiz)
              Column(
                children: [
                  Text(
                    'You have already completed the quiz for ${widget.category}.',
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LevelSelectionPage(category: widget.category),
                        ),
                      );
                    },
                    child: const Text('Go to Level Selection'),
                  ),
                ],
              )
            else
              Column(
                children: [
                  Text(
                    'We noticed this is your first time accessing ${widget.category}. Would you like to take a quick quiz to determine your level?',
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizPage(category: widget.category),
                        ),
                      );
                      // Mark the quiz as completed after returning from the quiz page
                      setState(() {
                        _hasCompletedQuiz = true;
                      });
                    },
                    child: const Text('Let\'s do it!'),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LevelSelectionPage(category: widget.category),
                        ),
                      );
                    },
                    child: const Text('Skip'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}