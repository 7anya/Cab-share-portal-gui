import 'dart:async';
import 'dart:convert';
import 'package:login_page/screens/Globals.dart' as Globals;
import 'package:login_page/screens/ResultsPage.dart';

import 'dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:date_time_picker/date_time_picker.dart';

class search extends StatefulWidget {
  search(this.account);

  Globals.Account account;

  @override
  _searchState createState() {
    return _searchState();
  }
}

class _searchState extends State<search> {
  final TextEditingController _controller = TextEditingController();
  Future<bool> _futureAlbum;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  String leave_by_earliest= DateTime.now().toString().substring(0,16), leave_by_latest= DateTime.now().toString().substring(0,16);
  String from = 'Campus';
  String to = 'Campus';
  List<Globals.SearchResult> searchResults = [];

  Future<bool> findTrips(String s_id, String from, String to,
      String leave_by_earliest, String leave_by_latest) async {
    final response = await http.post(
      Uri.http('127.0.0.1:5000', 'findtrip'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'source': from,
        'destination': to,
        'leave_by_earliest': leave_by_earliest,
        'leave_by_latest': leave_by_latest
      }),
    );

    if (response.statusCode == 200) {
      List<dynamic> trips_result = jsonDecode(response.body);
      for (int i = 0; i < trips_result.length; i++) {
        searchResults.add(Globals.SearchResult(
            trips_result[i]['s_id'],
            trips_result[i]['name'],
            trips_result[i]['email'],
            trips_result[i]['phone_no'],
            trips_result[i]['room_no'],
            trips_result[i]['gender'],
            trips_result[i]['leave_by_latest'],
            trips_result[i]['leave_by_earliest'],
            trips_result[i]['destination'],
            trips_result[i]['source']));
      }
      return true;
    } else {
      throw Exception('Failed to create album.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Browse trips here',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Browse Trips'),
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
                          Text("Enter trip details here"),
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
                          Text("Leaving Between"),
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
                          Text("and"),
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
                          SizedBox(height: 20,),
                          ElevatedButton(
                              onPressed: () {
                                leave_by_earliest.compareTo(leave_by_latest) !=-1 || to==from
                                    ? Globals.showError(context)
                                    : setState(() {
                                  _futureAlbum = findTrips(
                                      widget.account.user.s_id,
                                      from,
                                      to,
                                      leave_by_earliest,
                                      leave_by_latest);
                                });
                              },
                              child: Text("Submit")),
                          SizedBox(height: 20,),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return MenuDashboardPage(widget.account);
                                    },
                                  ),
                                );
                              },
                              child: Text("Return to dashboard"))
                        ],
                      ),
                    )))
            : FutureBuilder<bool>(
                future: _futureAlbum,
                builder: (context, snapshot) {
                  return MaterialApp(home: ResultsPage(searchResults));
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
