import 'package:flutter/material.dart';
import 'package:two_min_question/QuizPage.dart';

class agn extends StatefulWidget {
  const agn({Key? key}) : super(key: key);

  @override
  State<agn> createState() => _agnState();
}

class _agnState extends State<agn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Text(
                "Wrong Answare !!",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 40,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 80,
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
                                builder: (context) => const QuizPage()));
                      },
                      color: Colors.red,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Try Again",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ))),
            ])));
  }
}
