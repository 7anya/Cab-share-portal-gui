import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Globals.dart' as Globals;
import 'dashboard.dart';

class login extends StatefulWidget {
  login({Key key}) : super(key: key);

  @override
  _loginState createState() {
    return _loginState();
  }
}

class _loginState extends State<login> {
  // final TextEditingController _controller = TextEditingController();
  Globals.Account account = Globals.Account();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  Future<Globals.Student> _futureAlbum;

  Future<Globals.Student> loginStudent(String username, String password) async {
    final response = await http.post(
      Uri.http('127.0.0.1:5000', 'LoginStudent'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body:
          json.encode(<String, String>{'s_id': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      print("testtttttttttttttttttttttttttttttttt");
      var result = jsonDecode(response.body);
      account.user.s_id = result['s_id'];
      account.user.gender = result['gender'];
      account.user.name = result['name'];
      account.user.email = result['email'];
      account.user.room_no = result['room_no'];
      account.user.phone_no = result['phone_no'];
      final trips = await http.post(
        Uri.http('127.0.0.1:5000', 'trip_history'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: json.encode(<String, String>{'s_id': username}),
      );
      List<dynamic> trips_result = jsonDecode(trips.body);
      for (var i = 0; i < trips_result.length; i++) {
        account.trips.add(Globals.Trip(
            trips_result[i]['leave_by_earliest'].toString(),
            trips_result[i]['leave_by_latest'].toString(),
            trips_result[i]['location'].toString(),
            trips_result[i]['destination'].toString(),
            'status',trips_result[i]['trip_id'].toString()));
        print(trips_result[i]['leave_by_earliest'].toString() + "hey");
      }
      return Globals.Student.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create album.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Student Login'),
          ),
          body: (_futureAlbum == null)
              ? Center(
              child: Container(
                  height: 320,
                  width: 700,
                  padding: const EdgeInsets.all(0.0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                    elevation: 5.0,
                    child: Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'Login',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            )),
                        Padding(
                            padding: EdgeInsets.all(20),
                            child: TextFormField(
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.white),
                              controller: username,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.person),
                                hintText: 'Username',
                                labelText: 'Username*',
                              ),
                            )),
                        Padding(
                            padding: EdgeInsets.all(20),
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              // autofocus: false,
                              obscureText: true,
                              controller: password,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.person),
                                hintText: 'password',
                                labelText: 'Password*',
                              ),
                            )),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 20, 25),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        if (!username.text.isEmpty && !password.text.isEmpty) {
                                          setState(() {
                                            _futureAlbum = loginStudent(
                                                username.text, password.text);
                                            print(_futureAlbum);
                                            // account.user.name = '_futureAlbum';
                                          });
                                        }
                                        // Navigator.of(context)
                                        //     .pushAndRemoveUntil(
                                        //         MaterialPageRoute(
                                        //             builder: (context) {
                                        //   return MenuDashboardPage(account);
                                        // }), (route) => route.isFirst);
                                      },
                                      child: Text(
                                        'Login',
                                        style: TextStyle(fontSize: 18),
                                      )))
                            ])
                      ],
                    ),
                  )
              )
          ):FutureBuilder<Globals.Student>(
            future: _futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                   Navigator.of(context)
                    .pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) {
                  return MenuDashboardPage(account);

                }), (route) => route.isFirst);
                   return Text("jskdjaljd");
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
