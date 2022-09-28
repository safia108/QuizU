import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:two_min_question/HomePage.dart';
import 'package:two_min_question/Leaderboard.dart';
import 'package:two_min_question/TopScore.dart';
import 'package:two_min_question/UserInfo.dart';

import 'QuizPage.dart';
import 'Tabs.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TopScores();
    getQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Image.asset(
              'assets/smart.jpeg',
              height: 400,
              width: 400,
            ),
            // SizedBox(
            //   height: 30,
            // ),
            Text(" QuizU",
                style: TextStyle(fontSize: 65, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 80,
            ),
            Container(
                width: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * .45,
                          height: MediaQuery.of(context).size.height * .08,
                          child: RaisedButton(
                              color: Color(0xff313540),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => phoneNumber()));
                              },
                              child: Text("Start",
                                  style: new TextStyle(
                                      fontSize: 24.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w100))))
                    ]))
          ],
        ),
      ),
    );
  }
}
  //   return Scaffold(
  //       body: Center(
  //     child: TextButton(
  //       style: ButtonStyle(
  //         foregroundColor: MaterialStateProperty.all<Color>(Colors.black54),
  //         backgroundColor: MaterialStateProperty.all<Color>(Colors.black12),
  //       ),
  //       onPressed: () {
  //         getQuestions();
  //       },
  //       child: const Text('Requests'),
  //     ),
  //   ));
  // }

  // int b = 0000;
  // void getQuestions() async {
  //   var headers = {
  //     'Content-Type': 'application/json'
  //   };
  //   var request =
  //       http.Request('POST', Uri.parse('https://quizu.okoul.com/Login'));
  //   request.body = json.encode({"OTP": "0000", "mobile": "05"});
  //   request.headers.addAll(headers);

  //   http.StreamedResponse response = await request.send();

  //   if (response.statusCode == 200) {
  //     print(await response.stream.bytesToString());
  //   } else {
  //     print(response.reasonPhrase);
  //     print(await response.stream.bytesToString());
  //   }
  // }