import 'dart:async';
import 'dart:async';
import 'dart:convert';
import 'Globals.dart';
import 'dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Globals.dart' as Globals;
import 'dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Globals.dart' as Globals;

class login extends StatefulWidget {
  login({Key key}) : super(key: key);

  @override
  _loginState createState() {
    return _loginState();
  }
}

class _loginState extends State<login> {
  // final TextEditingController _controller = TextEditingController();
  Future<Globals.Student> _futureAlbum;
  Globals.Account account = new Globals.Account();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

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
      for (int i = 0; i < trips_result.length; i++) {
        // Globals.Trip temp = Trip(
        //     trips_result[i]['leave_by_earliest'],
        //     trips_result[i]['leave_by_latest'],
        //     trips_result[i]['location'],
        //     trips_result[i][' destination'],
        //     "5");
        account.trips.add(Globals.Trip(
            trips_result[i]['leave_by_earliest'].toString(),
            trips_result[i]['leave_by_latest'].toString(),
            trips_result[i]['location'].toString(),
            trips_result[i]['destination'].toString(),
            'status'));
        print(trips_result[i]['leave_by_earliest'].toString()+"hey");
      }

      print(trips_result[0]["s_id"]);
      return Globals.Student.fromJson(jsonDecode(response.body));
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
          title: Text('Create Data Example'),
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
                    TextFormField(
                      controller: username,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: 'Username',
                        labelText: 'Username*',
                      ),
                    ),
                    TextFormField(
                      // autofocus: false,
                      obscureText: true,
                      controller: password,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: 'password',
                        labelText: 'Password*',
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          username.text.isEmpty || password.text.isEmpty
                              ? print('missing')
                              : print("loginnn" +
                                  username.text +
                                  " " +
                                  password.text);
                          setState(() {
                            _futureAlbum =
                                loginStudent(username.text, password.text);
                            print(_futureAlbum);
                            // account.user.name = '_futureAlbum';
                          });
                        },
                        child: Text('login'))
                  ],
                ),
              ))
            : FutureBuilder<Globals.Student>(
                future: _futureAlbum,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return MaterialApp(home: MenuDashboardPage(account));
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
