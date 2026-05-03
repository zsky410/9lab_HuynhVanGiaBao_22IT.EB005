import '../models/question.dart';

class QuizBrain {
  final List<Question> _questions = const [
    Question(text: 'Flutter is developed by Google.', answer: true),
    Question(text: 'Dart is a statically typed language.', answer: true),
    Question(text: 'setState() is used in StatelessWidget.', answer: false),
    Question(text: 'Hot reload preserves current app state.', answer: true),
    Question(text: 'Android and iOS both supported by Flutter.', answer: true),
  ];

  int _questionIndex = 0;

  String getQuestionText() => _questions[_questionIndex].text;

  bool getQuestionAnswer() => _questions[_questionIndex].answer;

  bool isFinished() => _questionIndex >= _questions.length - 1;

  void nextQuestion() {
    if (_questionIndex < _questions.length - 1) {
      _questionIndex++;
    }
  }

  void reset() {
    _questionIndex = 0;
  }

  int get totalQuestions => _questions.length;
}
