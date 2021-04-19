import 'dart:convert';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_page/screens/Globals.dart';
import 'package:login_page/screens/Globals.dart' as Globals;
import 'package:login_page/screens/request_partner.dart';
import 'package:login_page/screens/search.dart';

final Color backgroundColor = Color(0xfffEDE7F6);

class MenuDashboardPage extends StatefulWidget {
  Account account;

  MenuDashboardPage(this.account);

  @override
  _MenuDashboardPageState createState() => _MenuDashboardPageState();
}

class _MenuDashboardPageState extends State<MenuDashboardPage>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);

  // Account user=login.loginState.
  Future<void> _showMyDialog(Globals.Trip trip) async {
    TextEditingController source = TextEditingController();
    TextEditingController destination = TextEditingController();
    source.text = trip.location;
    String leave_by_earliest, leave_by_latest;
    String from = trip.location;
    String to = trip.destination;

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
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
                        children: <Widget>[
                          DropdownButton<String>(
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
                          DropdownButton<String>(
                            value: to,
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
                          DateTimePicker(
                            type: DateTimePickerType.dateTimeSeparate,
                            dateMask: 'd MMM, yyyy',
                            initialValue: trip.leave_by_earliest,
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
                            initialValue: trip.leave_by_latest,
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
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Update'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('delete'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Mark as finished'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('find cabs'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<List<Globals.CabSearchResult>> pickup(
      String car_no, String location, String startTime, String endTime,String trip_id) async {
    final response = await http.post(
      Uri.http('127.0.0.1:5000', 'pickup'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode(<String, String>{
        'location': location,
        'start_time': startTime,
        'end_time': endTime,
      }),
    );

    if (response.statusCode == 200) {
      List result = jsonDecode(response.body);
      List<Globals.CabSearchResult> CabSearchResults = [];
      for (int i = 0; i < result.length; i++) {
        CabSearchResults.add(Globals.CabSearchResult(
            result[i]['driver_name'],
            result[i]['driver_no'],
            result[i]['car_capacity'],
            result[i]['model'],
            result[i]['car_no'],
            trip_id)
            );
      }
      return CabSearchResults;
    } else {
      throw Exception('Failed to create album.');
    }
  }
  Future<bool> update(String s_id,String trip_id, String from, String to, String leave_by_earliest,String leave_by_latest) async {
    final response = await http.post(
      Uri.http('127.0.0.1:5000', 'update'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode(<String, String>{
        'trip_id':trip_id,
        's_id': s_id,
        'source': from,
        'destination': to,
        'leave_by_earliest': leave_by_earliest,
        'leave_by_latest': leave_by_latest
      }),
    );

    if (response.statusCode == 200) {

      return true;
    } else {
      throw Exception('Failed to create album.');
    }
  }
  Future<bool> deleteTrip(String trip_id) async {
    final response = await http.post(
      Uri.http('127.0.0.1:5000', 'delete'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode(<String, String>{
        'trip_id': trip_id,

      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to create album.');
    }
  }
  var _selectedIndex = 0;

  Widget getBody(BuildContext context) {
    switch (_selectedIndex) {
      case 0: return dashboard(context);
      case 1: return search(widget.account);
      case 2: return Text('Not yet implemented!');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'My Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Browse Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.car_rental),
            label: 'Get a cab',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      appBar: AppBar(
        title: Text('Student Dashboard'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      backgroundColor: backgroundColor,
      body: getBody(context),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return request_partner(widget.account);
                },
              ),
            );
          },
          child: Icon(Icons.add_rounded)),
    );
  }

  Widget dashboard(context) {
    return GridView.builder(
      padding: EdgeInsets.all(20),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: widget.account.trips.length,
        itemBuilder: (BuildContext ctx, index) {
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: widget.account.trips[index].status == 'pending'
                    ? Colors.amber
                    : Colors.green,
                borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              onTap: () {
                _showMyDialog(widget.account.trips[index]);
              },
              subtitle: Text(widget.account.trips[index].leave_by_earliest),
              title: Text(widget.account.trips[index].location +
                  ' to ' +
                  widget.account.trips[index].destination),
              // trailing: Text(widget.account.trips[index].status),
            ),
          );
        });
  }
}
