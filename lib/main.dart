import 'package:flutter/material.dart';
import 'package:quizzler/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizzer',
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body:SafeArea(
          child:Padding(
            padding:EdgeInsets.symmetric(horizontal:10.0),
            child:QuizPage(),
          )
        )
      ),
    );
  }
}

class QuizPage extends StatefulWidget{
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage>{
  List<Widget>  scoreKeeper = [];
  QuizBrain quizBrain = new QuizBrain();
  int questionNumber = 0;

  void answer(bool answer){
    bool answerIsCorrect = answer == quizBrain.getCorrectAnswer();

    Icon icon = answerIsCorrect ? Icon(Icons.check,color:Colors.green) :
                Icon(Icons.close,color:Colors.red);

    setState(() {
      scoreKeeper.add(icon);
      quizBrain.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex:5,
          child: Padding(
            padding:EdgeInsets.all(10.0),
            child:Center(
              child:Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style:TextStyle(
                  fontSize:25,
                  color: Colors.white
                )
              )
            )
          )
        ),
        Expanded(
          child:Padding(
            padding:EdgeInsets.all(15.0),
            child:FlatButton(
              color:Colors.green,
              textColor: Colors.white,
              child:Text(
                "True",
                style:TextStyle(
                  fontSize: 20.0,
                  color:Colors.white
                ),
              ),
              onPressed:(){
                if(!quizBrain.quizEnded()){
                  answer(true);
                }else{
                  Alert(
                    context:context,
                    type:AlertType.success,
                    title:"Quiz Completed",
                    desc:"Thank you for completing quiz ",
                    buttons: [
                      DialogButton(
                        child:
                        Text("OK",
                        style: TextStyle(
                          color:Colors.white,
                          fontSize: 18,
                        )) ,
                        onPressed:  () => Navigator.pop(context),
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(116, 116, 191, 1.0),
                          Color.fromRGBO(52, 138, 199, 1.0)
                        ]),
                      )
                    ]
                  ).show();
                }
              }
            )
          )
        ),
        Expanded(
          child:Padding(
            padding:EdgeInsets.all(15.0),
            child:FlatButton(
              color:Colors.red,
              textColor: Colors.white,
              child:Text(
                "False",
                style:TextStyle(
                  fontSize: 20.0,
                  color:Colors.white
                ),
              ),
              onPressed:(){
                if(!quizBrain.quizEnded()){
                  answer(false);
                }else{
                  Alert(
                      context:context,
                      type:AlertType.success,
                      title:"Quiz Completed",
                      desc:"Thank you for completing quiz ",
                      buttons: [
                        DialogButton(
                            child:
                            Text("OK",
                                style: TextStyle(
                                  color:Colors.white,
                                  fontSize: 18,
                                )) ,
                            onPressed:  () => Navigator.pop(context))
                      ]
                  ).show();
                }
              }
            )
          )
        ),
        Row(
          children:scoreKeeper,
        )
      ],
    );
  }
}