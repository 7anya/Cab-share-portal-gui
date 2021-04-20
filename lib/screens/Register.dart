import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_page/screens/login.dart';
import 'Globals.dart' as Globals;
import 'login.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> {
  final TextEditingController name = TextEditingController();
  final TextEditingController id = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController room = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController re_password = TextEditingController();
  Future<bool> _futureAlbum;
  Future<void> _showError() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text('Trip details'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[Text("Error: invalid entry")],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('ok'),
              ),
            ],
          );
        });
      },
    );
  }
  Future<bool> createAlbum() async {
    final response = await http.post(
      Uri.http('127.0.0.1:5000', 'CreateStudent'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode(<String, String>{
        's_id': id.text,
        'name': name.text,
        'password': password.text,
        'email': email.text,
        'phone_no': phone.text,
        'gender': gender.text,
        'room_no': room.text,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to create album.');
    }
  }

  @override
  Widget build(BuildContext context) {
    var leftPanel = Container(
      width: MediaQuery.of(context).size.width / 3.3,
      height: MediaQuery.of(context).size.height,
      color: Colors.yellow[600],
      child: Padding(
        padding: EdgeInsets.only(top: 70.0, right: 50.0, left: 50.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: Column(
            children: <Widget>[
              Container(
                child: CircleAvatar(
                  backgroundColor: Colors.black87,
                  backgroundImage: NetworkImage(
                    'https://upload.wikimedia.org/wikipedia/en/thumb/d/d3/BITS_Pilani-Logo.svg/1024px-BITS_Pilani-Logo.svg.png',
                  ),
                  radius: 70.0,
                ),
              ),
              SizedBox(
                height: 60.0,
              ),
              Container(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Text(
                  'Welcome to BPHC cab share portal! Please register here.',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Text(
                  'Find people to share a cab with based on your travel schedule painlessly',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                child: CircleAvatar(
                  backgroundColor: Colors.black87,
                  child: Text(
                    '>',
                    style: TextStyle(color: Colors.yellow),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    var fields = {
      'Name': name,
      'Gender (Male/Female/Non-binary)': gender,
      'ID Number': id,
      'Email': email,
      'Mobile': phone,
      'Room Number': room,
      'Set a password': password,
      'Retype Password': re_password
    };

    Padding generateField(MapEntry field) {
      return Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: Row(
            children: <Widget>[
              Container(
                width: 80.0,
                child: Text(
                  field.key,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                width: 40.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 3.7,
                color: Colors.blue[50],
                child: TextField(
                  controller: field.value,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue[50],
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue[50],
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: field.key,
                    fillColor: Colors.blue[50],
                  ),
                ),
              ),
            ],
          ));
    }

    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: (_futureAlbum == null)
          ? Padding(
              padding: EdgeInsets.only(
                  top: 60.0, bottom: 60.0, left: 120.0, right: 120.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0)),
                elevation: 5.0,
                child: Container(
                  child: Row(
                    children: <Widget>[
                      leftPanel,
                      Container(
                        padding: EdgeInsets.only(
                            top: 40.0, right: 70.0, left: 70.0, bottom: 40.0),
                        child: Column(children: <Widget>[
                          for (var field in fields.entries)
                            generateField(field),
                          Row(
                            children: <Widget>[
                              MaterialButton(
                                color: Colors.greenAccent,
                                onPressed: () {
                                  name.text.isEmpty ||
                                          password.text.isEmpty ||
                                          id.text.isEmpty ||
                                          re_password.text != password.text ||
                                          email.text.isEmpty ||
                                          phone.text.isEmpty ||
                                          gender.text.isEmpty || !Globals.gender(gender.text) || !Globals.email(email.text) || !Globals.checkString(name.text) || !Globals.checkID(id.text)
                                      ? Globals.showError(context)
                                      : {
                                          // ignore: unrelated_type_equality_checks
                                          setState(() {
                                            _futureAlbum = createAlbum();
                                          })
                                        };
                                },
                                child: Text(
                                  'Register',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : FutureBuilder<bool>(
              future: _futureAlbum,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return MaterialApp(home: login());
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return CircularProgressIndicator();
              },
            ),
    );
  }
}
