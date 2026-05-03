import 'package:flutter/material.dart';
import 'data/quiz_brain.dart';

void main() {
  runApp(const QuizzlerApp());
}

class QuizzlerApp extends StatelessWidget {
  const QuizzlerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final QuizBrain _quizBrain = QuizBrain();
  final List<Icon> _scoreKeeper = <Icon>[];

  void _checkAnswer(bool userAnswer) {
    final bool correctAnswer = _quizBrain.getQuestionAnswer();

    setState(() {
      _scoreKeeper.add(
        Icon(
          userAnswer == correctAnswer ? Icons.check : Icons.close,
          color: userAnswer == correctAnswer ? Colors.lightGreen : Colors.red,
        ),
      );

      if (_quizBrain.isFinished()) {
        _showResultDialog();
      } else {
        _quizBrain.nextQuestion();
      }
    });
  }

  void _showResultDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Finished'),
          content: const Text('You have reached the end of the quiz.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                setState(() {
                  _quizBrain.reset();
                  _scoreKeeper.clear();
                });
              },
              child: const Text('Restart'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF212121),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 4,
                child: Center(
                  child: Text(
                    _quizBrain.getQuestionText(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 28, color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => _checkAnswer(true),
                  child: const Text('True', style: TextStyle(fontSize: 22)),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => _checkAnswer(false),
                  child: const Text('False', style: TextStyle(fontSize: 22)),
                ),
              ),
              const SizedBox(height: 12),
              Wrap(spacing: 8, children: _scoreKeeper),
            ],
          ),
        ),
      ),
    );
  }
}
