import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:two_min_question/Tabs.dart';
import 'package:http/http.dart' as http;

import 'User.dart';

class phoneNumber extends StatefulWidget {
  const phoneNumber({Key? key}) : super(key: key);

  @override
  State<phoneNumber> createState() => _phoneNumberState();
}

final _formKey = GlobalKey<FormState>();

class _phoneNumberState extends State<phoneNumber> {
  String _phoneNumber = "";

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(bottom: 20, top: 140, left: 20, right: 20),
      child: Center(
          child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Container(
              height: 180,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: ("QuizU "),
                    ),
                    WidgetSpan(
                        child: Icon(
                      Icons.hourglass_bottom_rounded,
                      size: 65,
                    )),
                  ],
                  style: TextStyle(fontSize: 55),
                ),
              )),
          Container(
              child: Column(
            children: <Widget>[
              Text(
                "Enter your phone number to continue , we will send you OTP to verifiy",
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          )),
          SizedBox(
            height: 40,
          ),
          Form(
            key: _formKey,
            child: TextFormField(
              onChanged: (value) {
                _phoneNumber = value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your phone number';
                } else if (!isNumeric(value)) {
                  return 'phone number must be numeric';
                } else if (value.length != 10) {
                  return 'phone number must be 10 digits';
                } else if (!(value.startsWith('05'))) {
                  return 'Invalid phone number format (ex.05########)';
                }
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black12,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    )),
              ),
            ),
          ),
          SizedBox(height: 50),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: MaterialButton(
                  minWidth: 230,
                  height: 60,
                  onPressed: () {
                    final form = _formKey.currentState;

                    if (form!.validate() && _phoneNumber.isNotEmpty) {
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //   content: Text("Your account is create successfully"),
                      //   backgroundColor: Colors.green,
                      // ));
                      Navigator.of(
                        context,
                      ).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => OTP(value: _phoneNumber)),
                          (Route<dynamic> route) => false);
                    }
                  },
                  color: Color(0xff313540),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Start",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  )))
        ],
      )),
    ));
  }
}

class OTP extends StatelessWidget {
  final String value;
  String n1 = '';
  String n2 = '';
  String n3 = '';

  String n4 = '';

  OTP({required this.value, Key? key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(bottom: 20, top: 140, left: 20, right: 20),
      child: Center(
          child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Container(
              height: 200,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: ("QuizU "),
                    ),
                    WidgetSpan(
                        child: Icon(
                      Icons.hourglass_bottom_rounded,
                      size: 65,
                    )),
                  ],
                  style: TextStyle(fontSize: 55),
                ),
              )),
          Text(
            "Please enter your OTP sent to your mobile ",
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30,
          ),
          Form(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                SizedBox(
                    height: 70,
                    width: 65,
                    child: TextFormField(
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                          n1 = value.toString();
                        }
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black12,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            )),
                      ),
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    )),
                SizedBox(
                    height: 70,
                    width: 65,
                    child: TextFormField(
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                          n2 = value.toString();
                        }
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black12,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            )),
                      ),
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    )),
                SizedBox(
                    height: 70,
                    width: 65,
                    child: TextFormField(
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                          n3 = value.toString();
                        }
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black12,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            )),
                      ),
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    )),
                SizedBox(
                    height: 70,
                    width: 65,
                    child: TextFormField(
                      onChanged: (value) {
                        if (value.length == 1) {
                          n4 = value.toString();
                        }
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black12,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            )),
                      ),
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ))
              ])),
          SizedBox(
            height: 120,
          ),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: MaterialButton(
                  minWidth: 230,
                  height: 60,
                  onPressed: () async {
                    User userState = await getUser();
                    if ((n1 + n2 + n3 + n4) == "0000") {
                      print(userState);
                      if (userState.message.toString() == "user created!") {
                        Navigator.of(
                          context,
                        ).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) =>
                                    userName(value: userState.token)),
                            (Route<dynamic> route) => false);
                      } else {
                        Navigator.of(
                          context,
                        ).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => Tabs()),
                            (Route<dynamic> route) => false);
                      }
                    }
                    if (userState.message.toString() ==
                        "Unauthorized! Your OTP is invalid") {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("The OTP is Incorrect"),
                        backgroundColor: Colors.red,
                      ));
                    }
                  },
                  color: Color(0xff313540),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Check",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  )))
        ],
      )),
    ));
  }

  Future<User> getUser() async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('https://quizu.okoul.com/Login'));
    request.body =
        json.encode({"OTP": "0000", "mobile": value.toString().trim()});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      String res = await response.stream.bytesToString();
      print(res);
      print(response.statusCode);
      User user = await User.fromJson(jsonDecode(res));

      return user;
    } else {
      return " " as User;
    }
  }
}

class userName extends StatefulWidget {
  final String value;

  const userName({Key? key, required this.value}) : super(key: key);

  @override
  State<userName> createState() => _userNameState();
}

class _userNameState extends State<userName> {
  @override
  String _fullName = "";

  late SharedPreferences prefs;

  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(bottom: 20, top: 140, left: 20, right: 20),
      child: Center(
          child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Container(
              height: 200,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: ("QuizU "),
                    ),
                    WidgetSpan(
                        child: Icon(
                      Icons.hourglass_bottom_rounded,
                      size: 65,
                    )),
                  ],
                  style: TextStyle(fontSize: 55),
                ),
              )),
          Text(
            "What is your Name ?",
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30,
          ),
          Form(
              key: _formKey,
              child: TextFormField(
                onChanged: (value) {
                  _fullName = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  } else if (!RegExp('[a-zA-Z_]+').hasMatch(_fullName)) {
                    return 'name must contain only letters';
                  } else if (value.length > 25) {
                    return ' name must less than 25 character';
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black12,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      )),
                ),
              )),
          SizedBox(
            height: 120,
          ),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: MaterialButton(
                  minWidth: 230,
                  height: 60,
                  onPressed: () {
                    final form = _formKey.currentState;

                    if (form!.validate() && _fullName.isNotEmpty) {
                      setUserName(widget.value);
                      Navigator.of(
                        context,
                      ).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => Tabs()),
                          (Route<dynamic> route) => false);
                    }
                  },
                  color: Color(0xff313540),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Done",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  )))
        ],
      )),
    ));
  }

  void setUserName(String value) async {
    var headers = {
      'Authorization': 'Bearer $value',
      'Content-Type': 'application/json'
    };
    var request =
        http.Request('POST', Uri.parse('https://quizu.okoul.com/Name'));
    request.body = json.encode({"name": _fullName});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String objText = await response.stream.bytesToString();

      var q = jsonDecode(objText);

      final prefs = await SharedPreferences.getInstance();
      String n = q['name'].toString();
      prefs.setString('name', n);
      String m = q['mobile'].toString();
      prefs.setString('mobile', m);
      prefs.setString('token', value.toString());
    } else {}
  }
}
