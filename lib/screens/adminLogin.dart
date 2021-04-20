import 'dart:async';
import 'dart:async';
import 'dart:convert';
import 'package:login_page/screens/addCab.dart';

import 'Globals.dart';
import 'dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Globals.dart' as Globals;
import 'dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Globals.dart' as Globals;

class adminLogin extends StatefulWidget {
  adminLogin({Key key}) : super(key: key);

  @override
  _adminLoginState createState() {
    return _adminLoginState();
  }
}

class _adminLoginState extends State<adminLogin> {
  // final TextEditingController _controller = TextEditingController();
  Future<bool> _futureAlbum;
  Globals.Account account = new Globals.Account();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  String adminID;

  Future<bool> loginStudent(String username, String password) async {
    final response = await http.post(
      Uri.http('127.0.0.1:5000', 'admin'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json
          .encode(<String, String>{'admin_id': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      print(result);
      if (result == null) return false;
      adminID = result[0];
      return true;
    } else {
      throw Exception('Failed to create album.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Admin'),
        ),
        body:  Center(
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

                            loginStudent(username.text, password.text).then((value) {
                              if (!value) {
                                _futureAlbum = null;
                                Globals.showError(context);
                              }
                              else
                                {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return add_cab(adminID);
                                      },
                                    ),
                                  );
                                }
                            });

                            // print(_futureAlbum);
                            // account.user.name = '_futureAlbum';
                          });
                        },
                        child: Text('login'))
                  ],
                ),
              ))

      ),
    );
  }
}
