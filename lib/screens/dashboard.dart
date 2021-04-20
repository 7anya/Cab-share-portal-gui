import 'dart:convert';
import 'dart:html';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_page/screens/Globals.dart';
import 'package:login_page/screens/Globals.dart' as Globals;
import 'package:login_page/screens/cabResults.dart';
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
  Future<List<CabSearchResult>> futureResult;

  @override
  void initState() {
    super.initState();
    getMyTrips().then((value) {
      setState(() {});
    });
  }

  Future<bool> getMyTrips() async {
    widget.account.trips.clear();
    final trips = await http.post(
      Uri.http('127.0.0.1:5000', 'trip_history'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode(<String, String>{'s_id': widget.account.user.s_id}),
    );
    List<dynamic> trips_result = jsonDecode(trips.body);
    for (var i = 0; i < trips_result.length; i++) {
      widget.account.trips.add(Globals.Trip(
          trips_result[i]['leave_by_earliest'].toString(),
          trips_result[i]['leave_by_latest'].toString(),
          trips_result[i]['location'].toString(),
          trips_result[i]['destination'].toString(),
          trips_result[i]['status'].toString(),
          trips_result[i]['trip_id'].toString()));
    }
    return true;
  }

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

  // Account user=login.loginState.
  Future<void> _showMyDialog(Globals.Trip trip) async {
    String leave_by_earliest = trip.leave_by_earliest,
        leave_by_latest = trip.leave_by_latest;
    String from = trip.location;
    String to = trip.destination;

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
                            DateTimePicker(
                              type: DateTimePickerType.dateTimeSeparate,
                              dateMask: 'd MMM, yyyy',
                              initialValue: trip.leave_by_earliest,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              icon: Icon(Icons.event),
                              dateLabelText: 'Date',
                              timeLabelText: 'Hour',
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
                              timeLabelText: 'Hour',
                              onChanged: (val) {
                                print(val);
                                leave_by_latest = val.toString();
                              },
                              validator: (val) {
                                print(val);

                                return null;
                              },
                              onSaved: (val) =>
                                  leave_by_latest = val.toString(),
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
                onPressed: () {
                  if (leave_by_earliest.compareTo(leave_by_latest) != -1 || from==to)
                    Globals.showError(context);
                  else {
                    update(widget.account.user.s_id, trip.tripid, from, to,
                        leave_by_earliest, leave_by_latest);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) {
                      return MenuDashboardPage(Globals.Account.currentAccount);
                    }), (route) => route.isFirst);
                  }
                },
                child: Text('Update'),
              ),
              TextButton(
                onPressed: () {
                  deleteTrip(trip.tripid);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) {
                    return MenuDashboardPage(Globals.Account.currentAccount);
                  }), (route) => route.isFirst);
                },
                child: Text('Delete'),
              ),
              TextButton(
                onPressed: () {
                  status(trip.tripid);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) {
                    return MenuDashboardPage(Globals.Account.currentAccount);
                  }), (route) => route.isFirst);
                },
                child: Text('Mark as finished'),
              ),
              TextButton(
                onPressed: () {
                  pickup(from, leave_by_earliest, leave_by_latest)
                      .then((value) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) {
                      return ResultsPage(value, trip.tripid, widget.account);
                    }), (route) => route.isFirst);
                  });
                  Navigator.of(context).pop();
                },
                child: Text('Find cabs'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('cancel'),
              ),
            ],
          );
        });
      },
    );
  }

  Future<List<Globals.CabSearchResult>> pickup(
      String location, String startTime, String endTime) async {
    final response = await http.post(
      Uri.http('127.0.0.1:5000', 'findCar'),
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
      var CabSearchResults = <Globals.CabSearchResult>[];
      for (var i = 0; i < result.length; i++) {
        CabSearchResults.add(Globals.CabSearchResult(
          result[i]['driver_name'],
          result[i]['driver_no'],
          result[i]['car_capacity'].toString(),
          result[i]['model'],
          result[i]['car_no'],
        ));
      }
      return CabSearchResults;
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<bool> update(String s_id, String trip_id, String from, String to,
      String leave_by_earliest, String leave_by_latest) async {
    final response = await http.post(
      Uri.http('127.0.0.1:5000', 'update'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode(<String, String>{
        'trip_id': trip_id,
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

  Future<bool> status(String trip_id) async {
    final response = await http.post(
      Uri.http('127.0.0.1:5000', 'status'),
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
      case 0:
        return showTrips(context);
      case 1:
        return search(widget.account);
      case 2:
        return Text('Not yet implemented!');
      default:
        throw UnimplementedError();
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
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.car_rental),
          //   label: 'Get a cab',
          // ),
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

  Widget showTrips(context) {
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
