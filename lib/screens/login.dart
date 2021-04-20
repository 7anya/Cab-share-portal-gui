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
  Globals.Account account = new Globals.Account();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<bool> loginStudent(String username, String password) async {
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
      // List<dynamic> tenp=result;
      if (result.toString()=='[]')
        return false;
      account.user.s_id = result['s_id'];
      account.user.gender = result['gender'];
      account.user.name = result['name'];
      account.user.email = result['email'];
      account.user.room_no = result['room_no'];
      account.user.phone_no = result['phone_no'];
      Globals.Account.currentAccount = account;
      return true;
    } else {
      Globals.showError(context);
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
          body: Center(
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
                                hintText: 'ID number',
                                labelText: 'ID number*',
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
                                        username.text.isEmpty ||
                                            password.text.isEmpty
                                            ? print('missing')
                                            : print('loginnn' +
                                            username.text +
                                            ' ' +
                                            password.text);
                                        loginStudent(
                                            username.text, password.text)
                                            .then((value) {
                                              if(value)
                                                {
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                          builder:
                                                              (context) {
                                                            return MenuDashboardPage(
                                                                account);
                                                          }), (route) => route.isFirst);
                                                }
                                              else Globals.showError(context);

                                        });
                                      },
                                      child: Text(
                                        'Login',
                                        style: TextStyle(fontSize: 18),
                                      )))
                            ])
                      ],
                    ),
                  )))),
    );
  }
}
