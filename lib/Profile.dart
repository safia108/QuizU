import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    getUserinfo();
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
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Profile",
                  style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                SizedBox(
                  height: 30,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Container(
                    alignment: Alignment.center,
                    constraints: const BoxConstraints(
                      maxWidth: 150,
                      maxHeight: 150,
                    ),
                    color: Colors.green,
                    child: Image.asset(
                      'assets/Albert_Einstein_Head.jpeg',
                      height: 250,
                      width: 250,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(children: [
                  Container(
                      child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: ("Name: " + name + "\n\n"),
                        ),
                        TextSpan(
                          text: ("Mobile: " + mobile),
                        ),
                      ],
                      style: TextStyle(fontSize: 25),
                    ),
                  )),
                ])
              ]),
        ));
  }

  getUserName() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    final String name = prefs.getString('name').toString();
    return name;
  }

  getUserMobile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String mobile = prefs.getString('mobile').toString();
    String mobile1 = prefs.getString('token').toString();

    print(prefs.getString('token'));

    return mobile;
  }

  Future<String?> getStringValue() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getString("name");
  }

  String name = '';
  String mobile = '';

  getUserinfo() async {
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTU4NywiaWF0IjoxNjY0MzY3NDI4fQ.UxCaJSD3CbNRJzk-qaYlvFaJATz_-ctwOOi-YQUUOX8'
    };
    var request =
        http.Request('GET', Uri.parse('https://quizu.okoul.com/UserInfo'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String objText = await response.stream.bytesToString();

      var q = jsonDecode(objText);
      setState(() {
        mobile = q['mobile'].toString();
        name = q['name'].toString();
      });
    } else {
      print(response.reasonPhrase);
    }
  }
}
