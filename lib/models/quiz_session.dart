import 'package:flutter/foundation.dart';
import 'package:quiz/models/question.dart';
import 'package:quiz/models/question_repository.dart';

enum QuizSessionState {
  starting,
  showing,
  loading,
  error,
  finished,
}

class QuizSession with ChangeNotifier {

  var _questionRepository;
  var _totalQuestionCount;
  var _currentQuestionCount = 0;

  // There's no `protected` visibility on Dart, so set it back to public, but start its name by the
  // dollar sign ($) which is legal but highly unlikely to be used for real public names.
  //https://stackoverflow.com/questions/28350655/how-do-i-emulate-protected-methods-in-dart
  var $score = 0;
  QuizSessionState $state;

  var _hintRequested = false;
  Question _currentQuestion;

  QuizSessionState get state => $state;
  int get currentQuestionIndex => _currentQuestionCount;
  Question get currentQuestion => _currentQuestion;
  int get questionsCount => _totalQuestionCount;
  int get score => $score;
  bool get hintRequested => _hintRequested;

  QuizSession({QuestionRepository questionRepository, @required int totalQuestionCount}) {
    _questionRepository = questionRepository;
    _totalQuestionCount = totalQuestionCount;
    $state = QuizSessionState.starting;
  }

  void nextQuestion() async {
    _hintRequested = false;

    try {
      _currentQuestionCount++;
      if (_currentQuestionCount > _totalQuestionCount) {
        _currentQuestion = null;
        $state = QuizSessionState.finished;
      }
      else {
        $state = QuizSessionState.loading;
        notifyListeners();
        _currentQuestion = await _questionRepository.fetch();
        $state = QuizSessionState.showing;
      }
    }
    catch (error) {
      $state = QuizSessionState.error;
    }

    notifyListeners();
  }

  bool checkAnswer(String answer) {
    var correct = currentQuestion.isCorrectAnswer(answer);
    updateScore(correct ? $score+pointsOnCorrect() : $score+pointsOnIncorrect());
    return correct;
  }

  void validateAnswer(answer){
    if (checkAnswer(answer)) {
      nextQuestion();
    }
  }

  void updateScore(int newScore){
    $score = newScore;
    notifyListeners();
  }

  void requestHint() {
    _hintRequested = true;
    updateScore($score + pointsOnHint());
    notifyListeners();
  }

  String get info => "";

  int pointsOnCorrect() => 1;
  int pointsOnIncorrect() => 0;
  int pointsOnHint() => 0;
}
