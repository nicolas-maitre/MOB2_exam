import 'package:quiz/models/question_repository.dart';
import 'package:quiz/models/quiz_session.dart';

class JourneymanQuizSession extends QuizSession {
  JourneymanQuizSession({QuestionRepository questionRepository, totalQuestionCount: 10}) : super(questionRepository: questionRepository, totalQuestionCount: totalQuestionCount);
  @override
  int pointsOnIncorrect() => -1;
}