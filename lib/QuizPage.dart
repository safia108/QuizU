import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'dart:async';

import 'package:two_min_question/Question.dart';
import 'package:two_min_question/WrongAns.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  int levelClock = 121;
  @override
  bool done = true;
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getQuestion();
    getQuestion();

    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: levelClock));

    _controller.forward();
    Timer(Duration(seconds: 121), () {
      setState(() {
        done = false;
      });
    });
  }

  late Timer _timer;

  FlutterLogoStyle _logoStyle = FlutterLogoStyle.markOnly;
  int countSkip = 0;
  bool col = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
            appBar: AppBar(
              title: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: ("QuizU "),
                    ),
                    WidgetSpan(
                        child: Icon(
                      Icons.hourglass_bottom_rounded,
                      size: 45,
                      color: Colors.black87,
                    )),
                  ],
                  style: TextStyle(fontSize: 35, color: Colors.black87),
                ),
              ),
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white10,
              shadowColor: Colors.white10,
            ),
            body: Padding(
                padding:
                    EdgeInsets.only(bottom: 20, top: 0, left: 20, right: 20),
                child: SingleChildScrollView(
                    child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      AnimatedCrossFade(
                        duration: const Duration(milliseconds: 300),
                        firstChild: Questions(),
                        secondChild: TimesUp(),
                        secondCurve: Curves.bounceOut,
                        firstCurve: Curves.bounceOut,
                        crossFadeState: done
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                      ),
                    ])))));
  }

  Widget TimesUp() {
    int n = index - countSkip;
    return Center(
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
          SizedBox(
            height: 140,
          ),
          Text(
            "Time is Up!! ",
            style: TextStyle(
                fontSize: 55, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          SizedBox(
            height: 70,
          ),
          Text(
            "you have completed",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.normal,
                color: Colors.black87),
          ),
          Text(
            "$n",
            style: TextStyle(
                fontSize: 45, fontWeight: FontWeight.w900, color: Colors.black),
          ),
          Text(
            "correct answers!",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.normal,
                color: Colors.black87),
          ),
          SizedBox(
            height: 100,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.share_sharp),
                color: Colors.black,
                onPressed: () async {
                  await Share.share("You Score is $n QuizU");
                },
              ),
              Text(
                "Share",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          )
        ]));
  }

  int index = 0;

  Widget Questions() {
    return Center(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Countdown(
            animation: StepTween(
              begin: levelClock,
              end: 0,
            ).animate(_controller),
          ),
          Text(
            myAllData[index].Question,
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30,
          ),
          Column(children: <Widget>[
            options(myAllData[index].a, "a", myAllData[index].correct),
            SizedBox(
              height: 10,
            ),
            options(myAllData[index].b, "b", myAllData[index].correct),
            SizedBox(
              height: 10,
            ),
            options(myAllData[index].c, "c", myAllData[index].correct),
            SizedBox(
              height: 10,
            ),
            options(myAllData[index].d, "d", myAllData[index].correct)
          ]),
          SizedBox(
            height: 50,
          ),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: MaterialButton(
                  minWidth: 230,
                  height: 60,
                  onPressed: () {
                    if (countSkip == 0) {
                      setState(() {
                        index++;
                        col = false;
                        countSkip++;
                      });
                    } else {}
                  },
                  color: col ? Colors.red : Colors.grey,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Skip",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  )))
        ],
      ),
    );
  }

  Widget options(String ans, String letter, String correct) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: MaterialButton(
            minWidth: double.infinity,
            height: 85,
            onPressed: () {
              if (letter == correct) {
                setState(() {
                  index++;
                });
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const agn()));
              }
            },
            color: Color(0xff313540),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              ans,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.white,
              ),
            )));
  }
}

class Countdown extends AnimatedWidget {
  Countdown({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    return Text(
      "$timerText",
      style: TextStyle(
        fontSize: 110,
        color: Colors.black54,
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget();

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: Text(
              '$_count',
              // This key causes the AnimatedSwitcher to interpret this as a "new"
              // child each time the count changes, so that it will begin its animation
              // when the count changes.
              key: ValueKey<int>(_count),
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          ElevatedButton(
            child: const Text('Increment'),
            onPressed: () {
              setState(() {
                _count += 1;
              });
            },
          ),
        ],
      ),
    );
  }
}

List<Questions> myAllData = [];
Future getQuestion() async {
  var headers = {
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiaWF0IjoxNjYzMzU4NDY1fQ.LlVAcArd2Bn3gtdanoHlfMOsHn0gRMqvVHozUk4bjWM'
  };
  var request =
      http.Request('GET', Uri.parse('https://quizu.okoul.com/Questions'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  myAllData = [];
  if (response.statusCode == 200) {
    String objText = await response.stream.bytesToString();

    var q = jsonDecode(objText);

    for (var data in q) {
      myAllData.add(new Questions(
        data['Question'],
        data['a'],
        data['b'],
        data['c'],
        data['d'],
        data['correct'],
      ));
    }
  } else {
    print(response.reasonPhrase);
  }
}
