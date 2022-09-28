import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:two_min_question/TopScore.dart';

List<TopScore> Scores = [];

class Leaderboard extends StatefulWidget {
  const Leaderboard({Key? key}) : super(key: key);

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      TopScores();
    });
  }

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
        body: Column(children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "Leaderboard",
            style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
              child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: Scores.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 60,
                color: Colors.blueGrey,
                child: Center(
                  child: Text('Name: ${Scores[index].name} - ' +
                      'Score: ${Scores[index].score}'),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ))
        ]));
  }
}

Future TopScores() async {
  var headers = {
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTAyNywiaWF0IjoxNjYzODczMDY3fQ.AdwZKTIvTA9fy1x6VJ2YXrAb3I-hLFH9tZnCV6PBW2I'
  };
  var request =
      http.Request('GET', Uri.parse('https://quizu.okoul.com/TopScores'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  Scores = [];

  if (response.statusCode == 200) {
    String objText = await response.stream.bytesToString();

    var q = jsonDecode(objText);
    for (var data in q) {
      Scores.add(new TopScore(
        data['name'],
        data['score'].toString(),
      ));
    }
    return Scores;
  } else {
    print(response.reasonPhrase);
    return Scores;
  }
}
