import 'package:flutter/material.dart';
import 'package:two_min_question/QuizPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
          padding: EdgeInsets.only(bottom: 20, top: 40, left: 20, right: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text("Ready to test your knoweldge and challenge others?",
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    )),
                Image.asset(
                  "assets/lamp.jpeg",
                  height: 330,
                ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: MaterialButton(
                        minWidth: 230,
                        height: 60,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const QuizPage()),
                          );
                        },
                        color: Colors.red,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Quiz Me",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ))),
                SizedBox(
                  height: 30,
                ),
                Text("Answer as mush questions correctly within 2 minutes",
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    )),
              ],
            ),
          ),
        ));
  }
}
