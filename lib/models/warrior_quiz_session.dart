import 'dart:async';

import 'package:quiz/models/question_repository.dart';
import 'package:quiz/models/quiz_session.dart';
import 'package:quiz/models/journeyman_quiz_session.dart';

class WarriorQuizSession extends JourneymanQuizSession {
  Timer _timer;
  final _maxTickCount = 30;
  var _currentTickCount = 0;

  WarriorQuizSession({QuestionRepository questionRepository}) : super(questionRepository: questionRepository, totalQuestionCount: 15) {
    _timer = Timer.periodic(Duration(seconds: 1), tick);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void tick(Timer timer) {
    if (_currentTickCount >= _maxTickCount) return;

    _currentTickCount++;
    if (_currentTickCount == _maxTickCount) {
      $state = QuizSessionState.finished;
    }
    notifyListeners();
  }

  String get info => "${_maxTickCount-_currentTickCount}";
}