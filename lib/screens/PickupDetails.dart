import 'dart:async';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';

import 'Globals.dart';
import 'dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Globals.dart' as Globals;
import 'dashboard.dart';
import 'package:flutter/material.dart';
import 'Globals.dart' as Globals;

class pickupDetails extends StatefulWidget {
  pickupDetails(this.car_no);

  String car_no;

  @override
  _pickupDetailsState createState() {
    return _pickupDetailsState();
  }
}

class _pickupDetailsState extends State<pickupDetails> {
  // final TextEditingController _controller = TextEditingController();
  Future<bool> _futureAlbum;
  String location = 'Campus';
  TimeOfDay _startTime = TimeOfDay(hour: 7, minute: 15);
  TimeOfDay _endTime = TimeOfDay(hour: 7, minute: 15);

  void _selectStartTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (newTime != null) {
      setState(() {
        _startTime = newTime;
      });
    }
  }

  void _selectEndTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _endTime,
    );
    if (newTime != null) {
      setState(() {
        _endTime = newTime;
      });
    }
  }

  Future<bool> pickup(
      String car_no, String location, String startTime, String endTime) async {
    final response = await http.post(
      Uri.http('127.0.0.1:5000', 'pickup'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode(<String, String>{
        'car_no': car_no,
        'location': location,
        'start_time': startTime,
        'end_time': endTime,
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
      title: 'Create Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pick up details of cab'),
        ),
        body: (_futureAlbum == null)
            ? Center(
                child: Container(
                height: 400,
                width: 300,
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  children: [
                    Text('Login'),
                    Container(
                      margin: const EdgeInsets.only(left: 40, right: 2.0),
                      width: MediaQuery.of(context).size.width / 6,
                      child: DropdownButton<String>(
                        value: location,
                        // icon: Icon(Icons.person),
                        style: TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            location = newValue;
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
                    SizedBox(
                      height: 20,
                    ),
                    FlatButton(
                      onPressed: _selectStartTime,
                      child: Text(_startTime.toString()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FlatButton(
                      onPressed: _selectEndTime,
                      child: Text(_endTime.toString()),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _futureAlbum = pickup(widget.car_no, location,
                                _startTime.toString().substring(10, 15), _endTime.toString().substring(10, 15));
                            print(_futureAlbum);
                            // account.user.name = '_futureAlbum';
                          });
                        },
                        child: Text('add'))
                  ],
                ),
              ))

            : FutureBuilder<bool>(
                future: _futureAlbum,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text("eeeeeeee");
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
