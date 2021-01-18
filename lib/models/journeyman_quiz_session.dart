import 'package:quiz/models/question_repository.dart';
import 'package:quiz/models/quiz_session.dart';

class JourneymanQuizSession extends QuizSession {

  JourneymanQuizSession({QuestionRepository questionRepository, totalQuestionCount: 10}) : super(questionRepository: questionRepository, totalQuestionCount: totalQuestionCount);

  @override
  bool checkAnswer(String answer) {
    var correct = super.checkAnswer(answer);
    correct ? $score++ : $score--;
    return correct;
  }
}