import 'package:quiz/models/question_repository.dart';
import 'package:quiz/models/quiz_session.dart';

class RookieQuizSession extends QuizSession {

  RookieQuizSession({QuestionRepository questionRepository}) : super(questionRepository: questionRepository, totalQuestionCount: 10);

  bool checkAnswer(String answer) {
    if (super.checkAnswer(answer)) $score++;
    return true;
  }
}