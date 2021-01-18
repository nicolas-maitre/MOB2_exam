import 'package:flutter/material.dart';

import 'package:quiz/widgets/game_screen.dart';

import 'package:quiz/models/question_repository.dart';

import 'package:quiz/models/rookie_quiz_session.dart';
import 'package:quiz/models/journeyman_quiz_session.dart';
import 'package:quiz/models/warrior_quiz_session.dart';
import 'package:quiz/models/master_quiz_session.dart';

class MenuScreen extends StatelessWidget {
  final _questionRepository = new StaticQuestionRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz ‐ Menu"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => GameScreen(RookieQuizSession(questionRepository: _questionRepository))
                ));
              },
              child: Text("Rookie", textScaleFactor: 2.0, textAlign: TextAlign.center),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => GameScreen(JourneymanQuizSession(questionRepository: _questionRepository))
                ));
              },
              child: Text("Journeyman", textScaleFactor: 2.0, textAlign: TextAlign.center),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => GameScreen(WarriorQuizSession(questionRepository: _questionRepository))
                ));
              },
              child: Text("Warrior", textScaleFactor: 2.0, textAlign: TextAlign.center),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => GameScreen(MasterQuizSession(questionRepository: _questionRepository))
                ));
              },
              child: Text("Master", textScaleFactor: 2.0, textAlign: TextAlign.center),
            ),
          ],
        ),
      )
    );
  }
}
