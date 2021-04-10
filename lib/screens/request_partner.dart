import 'dart:async';
import 'dart:convert';
import 'package:login_page/screens/Globals.dart';

import 'dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:date_time_picker/date_time_picker.dart';

class request_partner extends StatefulWidget {
  request_partner(this.account);

  Account account;

  @override
  _request_partnerState createState() {
    return _request_partnerState();
  }
}

class _request_partnerState extends State<request_partner> {
  final TextEditingController _controller = TextEditingController();
  Future<bool> _futureAlbum;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  String leave_by_earliest, leave_by_latest;
  String from = 'Campus';
  String to = 'Campus';

  Future<bool> createTrip(String s_id,String from,String to,String leave_by_earliest,String leave_by_latest) async {
    final response = await http.post(
      Uri.http('127.0.0.1:5000', 'trip'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        's_id':s_id,
        'source':from,
        'destination':to,
        'leave_by_earliest':leave_by_earliest,
        'leave_by_latest':leave_by_latest
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
                            width: MediaQuery.of(context).size.width / 6,
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
                            width: MediaQuery.of(context).size.width / 6,
                            child: DropdownButton<String>(
                              value: to,
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
                            onChanged: (val) {
                              print(val);
                              leave_by_earliest = val.toString();
                            },
                            validator: (val) {
                              print(val);
                              return null;
                            },
                            onSaved: (val) => {
                              leave_by_earliest = val.toString()
                              // print(val);
                            },
                          ),
                          DateTimePicker(
                            type: DateTimePickerType.dateTimeSeparate,
                            dateMask: 'dd MMM ,yyyy',
                            initialValue: DateTime.now().toString(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            icon: Icon(Icons.event),
                            dateLabelText: 'Date',
                            timeLabelText: "Hour",
                            onChanged: (val) {
                              print(val);
                              leave_by_latest = val.toString();
                            },
                            validator: (val) {
                              print(val);

                              return null;
                            },
                            onSaved: (val) => leave_by_latest = val.toString(),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                leave_by_latest.compareTo(leave_by_earliest) ==
                                        1
                                    ? print("success")
                                    : print("loginnn" +
                                        username.text +
                                        " " +
                                        password.text);
                                setState(() {
                                  _futureAlbum = createTrip(widget.account.user.s_id,from,to,leave_by_earliest,leave_by_latest);
                                });
                              },
                              child: Text("Submit"))
                        ],
                      ),
                    )))
            : FutureBuilder<bool>(
                future: _futureAlbum,
                builder: (context, snapshot) {
                  // return MaterialApp(home: MenuDashboardPage());
                  if (snapshot.hasData) {
                    return Text("snapshot.data.title");
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
