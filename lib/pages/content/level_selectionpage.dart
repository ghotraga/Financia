import 'package:financia/pages/content/content_viewpage.dart';
import 'package:flutter/material.dart';

class LevelSelectionPage extends StatefulWidget {
  final String category;
  final int? score; // Nullable score parameter to handle skipped quizzes

  const LevelSelectionPage({super.key, required this.category, this.score});

  @override
  State<LevelSelectionPage> createState() => _LevelSelectionPageState();
}

class _LevelSelectionPageState extends State<LevelSelectionPage> {
  String? _recommendedLevel;

  @override
  void initState() {
    super.initState();
    _determineRecommendedLevel();
    if (widget.score != null) {
      _showScorePrompt();
    }
  }

  void _determineRecommendedLevel() {
    if (widget.score != null) {
      if (widget.score! <= 2) {
        _recommendedLevel = 'Beginner';
      } else if (widget.score! <= 4) {
        _recommendedLevel = 'Intermediate';
      } else {
        _recommendedLevel = 'Advanced';
      }
    }
  }

  void _showScorePrompt() {
    Future.delayed(Duration.zero, () {
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent dismissing the dialog without action
        builder: (context) {
          return AlertDialog(
            title: const Text('Quiz Results'),
            content: Text(
              'Your Quiz Score: ${widget.score}\n'
              'You have been placed in the $_recommendedLevel level.',
              style: const TextStyle(fontSize: 16),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContentViewPage(
                        category: widget.category,
                        level: _recommendedLevel!,
                      ),
                    ),
                  );
                },
                child: const Text('Continue'),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> levels = ['Beginner', 'Intermediate', 'Advanced'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a Level for ${widget.category}'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: widget.score != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your Quiz Score: ${widget.score}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'You have been placed in the $_recommendedLevel level.',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  const CircularProgressIndicator(), // Show a loading indicator while navigating
                ],
              ),
            )
          : ListView.builder(
              itemCount: levels.length,
              itemBuilder: (context, index) {
                final level = levels[index];
                return ListTile(
                  title: Text(
                    level,
                    style: const TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContentViewPage(
                          category: widget.category,
                          level: level,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}