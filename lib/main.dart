import 'package:flutter/material.dart';
import 'controller.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Controller controller = new Controller();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  int count = 0;
  List<Icon> scoreKeeper = [];

  void checkAnswer(BuildContext context,bool current) {
    setState(() {
      if (controller.getAnswer() == current) {
        scoreKeeper.add(
          Icon(
            Icons.check, 
            color: Colors.green,
          ),
        );
      } else {
        scoreKeeper.add(
          Icon(
            Icons.close, 
            color: Colors.red,
          ),
        );
      };
      if (controller.isEnd() == true) {
        Alert(
            type: AlertType.info,
            context: context,
            title: 'QUIZ END',
            desc: 'You have reached the end of the quiz.',
            buttons: [
              DialogButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                //onPressed: () => Navigator.pop(context),
                onPressed: () {
                  controller.reset();
                  scoreKeeper = [];
                  Navigator.of(context, rootNavigator: true).pop();
                },
                width: 120,
              ),
            ],
        )
        .show();
      }
      controller.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                controller.getText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(context,true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(context,false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}
