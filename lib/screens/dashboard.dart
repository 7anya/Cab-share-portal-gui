import 'package:flutter/material.dart';
import 'package:login_page/screens/Globals.dart';
import 'package:login_page/screens/Register.dart';
import 'package:login_page/screens/request_partner.dart';
import './ResultsPage.dart';
import 'login.dart' as login;
import 'search.dart';
import 'dart:convert';
import 'package:login_page/screens/Globals.dart' as Globals;
import 'package:date_time_picker/date_time_picker.dart';
import 'dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  // Account user=login.loginState.
  Future<void> _showMyDialog(Globals.Trip trip) async {
    TextEditingController source= TextEditingController();
    TextEditingController destination= TextEditingController();
    source.text=trip.location;
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
                            value:to,
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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<List<Globals.CabSearchResult>> pickup(
      String car_no, String location, String startTime, String endTime) async {
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
            result[i][''],
            result[i][''],
            result[i][''],
            result[i][''],
            result[i][''],
            result[i]['']));
      }
      return CabSearchResults;
    } else {
      throw Exception('Failed to create album.');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[
          menu(context),
          dashboard(context),
        ],
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Dashboard",
                    style: TextStyle(color: Colors.black, fontSize: 22)),
                SizedBox(height: 10),
                Text("Messages",
                    style: TextStyle(color: Colors.black, fontSize: 22)),
                SizedBox(height: 10),
                Text("Utility Bills",
                    style: TextStyle(color: Colors.black, fontSize: 22)),
                SizedBox(height: 10),
                Text("Funds Transfer",
                    style: TextStyle(color: Colors.black, fontSize: 22)),
                SizedBox(height: 10),
                Text("Branches",
                    style: TextStyle(color: Colors.black, fontSize: 22)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboard(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.1 * screenWidth,
      right: isCollapsed ? 0 : -0.5 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: backgroundColor,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        child: Text("log out"),
                        onTap:  () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Register();
                                  },
                                ),
                              );
                            },
                          ),
                      Text("My Trips",
                          style: TextStyle(fontSize: 24, color: Colors.black)),
                      Icon(Icons.settings, color: Colors.black),
                    ],
                  ),
                  // SizedBox(height: 20),
                  Container(
                    height: 30,
                    child: PageView(
                      controller: PageController(viewportFraction: 0.3),
                      scrollDirection: Axis.horizontal,
                      pageSnapping: true,
                      children: <Widget>[
                        Container(
                          width: 40,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.all(2),
                                child: RaisedButton(
                                  child: Text("Request a partner"),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return request_partner(
                                              widget.account);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),SizedBox(width: 20,),
                              Container(
                                margin: EdgeInsets.all(2),
                                child: RaisedButton(
                                  child: Text("Browse Trips"),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return search(widget.account);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),SizedBox(width: 20,),
                              Container(
                                margin: EdgeInsets.all(2),
                                child: RaisedButton(
                                  child: Text("Find a cab"),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return search(widget.account);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Card(
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: () {
                              _showMyDialog(widget.account.trips[index]);
                            },
                            child: Container(
                              width: 300,
                              height: 100,
                              child: ListTile(
                                title: Text(widget
                                    .account.trips[index].leave_by_earliest),
                                subtitle: Text(widget
                                        .account.trips[index].location +
                                    ' to ' +
                                    widget.account.trips[index].destination),
                                trailing:
                                    Text(widget.account.trips[index].status),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(height: 16);
                      },
                      itemCount: widget.account.trips.length)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
