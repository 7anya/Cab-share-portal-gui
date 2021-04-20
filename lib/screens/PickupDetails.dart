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
import 'addCab.dart';
class pickupDetails extends StatefulWidget {
  pickupDetails(this.car_no,this.admin_id);

  String car_no;String admin_id;

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
          title: Text('Details of availablity'),
        ),
        body: Center(
                child: Container(
                height: 400,
                width: 300,
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  children: [

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
                    Text("From"),
                    FlatButton(
                      onPressed: _selectStartTime,
                      child: Text(_startTime.toString()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("To"),
                    FlatButton(
                      onPressed: _selectEndTime,
                      child: Text(_endTime.toString()),
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(
                        onPressed: () {
                          _startTime.toString().substring(10,15).compareTo(_endTime.toString().substring(10,15))!=-1?Globals.showError(context):
                          setState(() {
                            _futureAlbum = pickup(widget.car_no, location,
                                _startTime.toString().substring(10, 15), _endTime.toString().substring(10, 15));
                            print(_futureAlbum);
                            showadd(context);
                            // account.user.name = '_futureAlbum';
                          });
                        },
                        child: Text('Add this pickup detail')),
                    SizedBox(height: 20,),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return add_cab(widget.admin_id);
                                },
                              ),
                            );
                            // account.user.name = '_futureAlbum';
                          });
                        },
                        child: Text('Add a new car'))
                  ],
                ),
              ))

      ),
    );
  }
}
Future<void> showadd(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: Text('Success'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[Text("Added")],
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
