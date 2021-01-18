import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quiz/models/quiz_session.dart';
//import 'package:quiz/models/question.dart';

class GameScreen extends StatelessWidget {
  final QuizSession session;

  GameScreen(this.session);

  @override
  Widget build(BuildContext context) {
    session.nextQuestion();

    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz ‐ Game"),
      ),
      body: ChangeNotifierProvider.value(
        value: session,
        child: Consumer<QuizSession>(
          builder: (consumerContext, session, __) {
            switch (session.state) {
              case QuizSessionState.starting:
              case QuizSessionState.loading:
                return buildLoading(consumerContext);
              case QuizSessionState.error:
                return buildError(consumerContext, session);
              case QuizSessionState.showing:
                return buildQuestion(consumerContext, session);
              case QuizSessionState.finished:
                return buildGameEnded(consumerContext, session);
            }
          },
        ),
      ),
    );
  }

  Widget buildLoading(BuildContext context) {
    return Center(
      child: CircularProgressIndicator()
    );
  }

  Widget buildError(BuildContext context, QuizSession session) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Sorry, something went wrong while grabbing the next question", textScaleFactor: 2.0),
          ElevatedButton(
            onPressed: () => session.nextQuestion(),
            child: Text("Retry", textScaleFactor: 2.0, textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }

  Widget buildQuestion(BuildContext context, QuizSession session) {
    var question = session.currentQuestion;
    var answerButtons = question.answers.map((answer) {
      return ElevatedButton(
        onPressed: () {
          if (session.checkAnswer(answer)) {
            session.nextQuestion();
          }
        },
        child: SizedBox(
          width: double.infinity,
          child: Text(answer, textScaleFactor: 2.0, textAlign: TextAlign.center)
        )
      );
    });

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(session.info, textScaleFactor: 2.0),
          ),
          Spacer(),
          buildHint(context, session),
          Spacer(),
          Text(question.caption, textScaleFactor: 2.0),
          ...answerButtons,
          Spacer(),
        ],
      ),
    );
  }

  Widget buildHint(BuildContext context, QuizSession session) {
    if (session.hintRequested) {
      return Text(session.currentQuestion.hint, textScaleFactor: 2.0);
    }
    else {
      return ElevatedButton(
        onPressed: () {
          session.requestHint();
        },
        child: Text("?", textScaleFactor: 2.0, textAlign: TextAlign.center),
      );
    }
  }

  Widget buildGameEnded(BuildContext context, QuizSession session) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Spacer(),
          Text("GAME OVER", textScaleFactor: 2.0),
          Spacer(),
          Text("${session.score} / ${session.questionsCount}", textScaleFactor: 2.0),
          Spacer(),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Menu", textScaleFactor: 2.0, textAlign: TextAlign.center),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
