import 'dart:async';
import 'dart:convert';
import 'package:login_page/screens/Globals.dart' as Globals;
import 'package:login_page/screens/PickupDetails.dart';

import 'dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:date_time_picker/date_time_picker.dart';

class add_cab extends StatefulWidget {
  add_cab(this.admin_id);

  String admin_id;

  @override
  _add_cabState createState() {
    return _add_cabState();
  }
}

class _add_cabState extends State<add_cab> {
  Future<bool> _futureAlbum;
  TextEditingController car_no = TextEditingController();
  TextEditingController driverName = TextEditingController();
  TextEditingController carModel = TextEditingController();
  TextEditingController carCapacity = TextEditingController();
  TextEditingController driverPhone = TextEditingController();

  Future<bool> createCab(String car_no, String driverName, String carModel,
      String carCapacity, String driverPhone, String admin_id) async {
    final response = await http.post(
      Uri.http('127.0.0.1:5000', 'car'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'car_no': car_no,
        'admin_id': admin_id,
        'model': carModel,
        'car_capacity': carCapacity,
        'driver_name': driverName,
        'driver_phone': driverPhone,
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
          title: Text('Enter cab details'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                icon: Icon(Icons.exit_to_app))
          ],
        ),
        body: (_futureAlbum == null)
            ? Center(
                child: Container(
                    height: 700,
                    width: 500,
                    padding: const EdgeInsets.all(0.0),
                    child: Center(
                      child: Column(
                        children: [
                          Text("Enter cab details here"),
                          // Row(
                          //   children: [
                          Container(
                              margin:
                                  const EdgeInsets.only(left: 40, right: 2.0),
                              width: MediaQuery.of(context).size.width / 6,
                              child: TextFormField(
                                controller: car_no,
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue[50],
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  hintText: "Enter license plate number of car",
                                  labelText:
                                      "Enter license plate number of car",
                                  fillColor: Colors.blue[50],
                                ),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              margin:
                                  const EdgeInsets.only(left: 40, right: 2.0),
                              width: MediaQuery.of(context).size.width / 6,
                              child: TextFormField(
                                controller: carModel,
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
                                  hintText: "Enter Make and Model of car",
                                  labelText: "Enter Make and Model of car",
                                  fillColor: Colors.blue[50],
                                ),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          //   ],
                          // ),
                          Container(
                              margin:
                                  const EdgeInsets.only(left: 40, right: 2.0),
                              width: MediaQuery.of(context).size.width / 6,
                              child: TextFormField(
                                controller: carCapacity,
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
                                    hintText: "capactiy",
                                    fillColor: Colors.blue[50],
                                    labelText: "whats the capacity of the car"),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              margin:
                                  const EdgeInsets.only(left: 40, right: 2.0),
                              width: MediaQuery.of(context).size.width / 6,
                              child: TextFormField(
                                controller: driverName,
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
                                  hintText: "driver's name",
                                  labelText: "Driver's name",
                                  fillColor: Colors.blue[50],
                                ),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              margin:
                                  const EdgeInsets.only(left: 40, right: 2.0),
                              width: MediaQuery.of(context).size.width / 6,
                              child: TextFormField(
                                controller: driverPhone,
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
                                  hintText: "driver's phone",
                                  labelText: "Driver's phone",
                                  fillColor: Colors.blue[50],
                                ),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                car_no.text.isEmpty ||
                                        driverPhone.text.isEmpty ||
                                        carModel.text.isEmpty ||
                                        car_no.text.isEmpty ||
                                        carCapacity.text.isEmpty ||
                                        !Globals.checkString(driverName.text) ||
                                        !Globals.checkCarno(car_no.text) ||
                                        !Globals.checknum(carCapacity.text)
                                    ? Globals.showError(context)
                                    : setState(() {
                                        _futureAlbum = createCab(
                                            car_no.text,
                                            driverName.text,
                                            carModel.text,
                                            carCapacity.text,
                                            driverPhone.text,
                                            widget.admin_id);
                                      });
                              },
                              child: Text("Next"))
                        ],
                      ),
                    )))
            : FutureBuilder<bool>(
                future: _futureAlbum,
                builder: (context, snapshot) {
                  return pickupDetails(car_no.text, widget.admin_id);
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
