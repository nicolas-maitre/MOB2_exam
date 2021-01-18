import 'package:quiz/models/journeyman_quiz_session.dart';
import 'package:quiz/models/question_repository.dart';

class MasterQuizSession extends JourneymanQuizSession {
  MasterQuizSession({QuestionRepository questionRepository}) : super(questionRepository: questionRepository, totalQuestionCount: 8);

  @override
  int pointsOnCorrect() => 2;
  @override
  int pointsOnIncorrect() => -4;
  @override
  int pointsOnHint() => -2;
  @override
  bool shuffleAnswers() => true;
}