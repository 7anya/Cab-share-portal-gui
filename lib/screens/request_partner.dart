import 'dart:async';
import 'dart:convert';
import 'dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:date_time_picker/date_time_picker.dart';
Future<Album> createAlbum(String title) async {
  final response = await http.post(
    Uri.https('jsonplaceholder.typicode.com', 'albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );

  if (response.statusCode == 201) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create album.');
  }
}

class Album {
  final int id;
  final String title;

  Album({this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }
}

class request_partner extends StatefulWidget {
  request_partner({Key key}) : super(key: key);

  @override
  _request_partnerState createState() {
    return _request_partnerState();
  }
}

class _request_partnerState extends State<request_partner> {
  final TextEditingController _controller = TextEditingController();
  Future<Album> _futureAlbum;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  String from =   'Campus';
  String to =   'Campus';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find a travel partner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Find a travel partner'),
        ),
        body: (_futureAlbum == null)
            ? Center(
                child: Container(
                height: 400,
                width: 500,
                padding: const EdgeInsets.all(0.0),
                child: Center(
                  child: Column(
                    children: [
                      Text("Enter your trip details here"),
                      // Row(
                      //   children: [

                          Text("From"),
                          Container(
                            margin: const EdgeInsets.only(left: 40, right: 2.0),
                            width: MediaQuery.of(context).size.width/6,
                            child: DropdownButton<String>(
                              value: from,
                              // icon: Icon(Icons.person),
                              style: TextStyle(color: Colors.black),
                              underline: Container(
                                height: 2,
                                color: Colors.grey,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  from = newValue;
                                });
                              },
                              items: <String>[
                                'Campus',
                                'Airport',
                                'Kacheguda',
                                'Secunderabad',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          Text("To"),
                          Container(
                            margin: const EdgeInsets.only(left: 40, right: 2.0),
                            width: MediaQuery.of(context).size.width/6,
                            child: DropdownButton<String>(
                              value:to,
                              // icon: Icon(Icons.person),
                              style: TextStyle(color: Colors.black),
                              underline: Container(
                                height: 2,
                                color: Colors.grey,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  to = newValue;
                                });
                              },
                              items: <String>[
                                'Campus',
                                'Airport',
                                'Kacheguda',
                                'Secunderabad',

                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),

                      //   ],
                      // ),
                      DateTimePicker(
                        type: DateTimePickerType.dateTimeSeparate,
                        dateMask: 'd MMM, yyyy',
                        initialValue: DateTime.now().toString(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        icon: Icon(Icons.event),
                        dateLabelText: 'Date',
                        timeLabelText: "Hour",
                        onChanged: (val) => print(val),
                        validator: (val) {
                          print(val);
                          return null;
                        },
                        onSaved: (val) => print(val),
                      ),
                      DateTimePicker(
                        type: DateTimePickerType.dateTimeSeparate,
                        dateMask: 'd MMM, yyyy',
                        initialValue: DateTime.now().toString(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        icon: Icon(Icons.event),
                        dateLabelText: 'Date',
                        timeLabelText: "Hour",
                        onChanged: (val) => print(val),
                        validator: (val) {
                          print(val);
                          return null;
                        },
                        onSaved: (val) => print(val),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            username.text.length == 0 || password.text.length == 0
                                ? print("missing")
                                : print("loginnn" +
                                username.text +
                                " " +
                                password.text);
                            setState(() {
                              _futureAlbum = createAlbum(username.text);
                            });
                          },
                          child: Text("Submit"))
                    ],
                  ),
                )
              ))
            : FutureBuilder<Album>(
                future: _futureAlbum,
                builder: (context, snapshot) {
                  return MaterialApp(home: MenuDashboardPage());
                  if (snapshot.hasData) {
                    return Text(snapshot.data.title);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  return CircularProgressIndicator();
                },
              ),
      ),
    );
  }
}
