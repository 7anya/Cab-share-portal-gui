import 'dart:async';
import 'dart:convert';
import 'dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> createAlbum(String username,String password) async {
  final Map<String,String> body= new Map();
  body['s_id']=username;
  body['password']=password;
  final response = await http.post(
    Uri.https('127.0.0.1:5000','LoginStudent'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: json.encode(body),
  );

  if (response.statusCode == 201) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create album.');
  }
}

class Album {
  final String s_id;
  final String name;
  final String email;
  final String phone_no,room_no,gender;

  Album({this.s_id, this.name,this.email,this.phone_no,this.room_no,this.gender});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      s_id: json['s_id'],
      name: json['name'],
      email:json['email'],
      phone_no: json['phone_no'],
      room_no: json['room_no'],
      gender: json['gender']
    );
  }
}


class login extends StatefulWidget {
  login({Key key}) : super(key: key);

  @override
  _loginState createState() {
    return _loginState();
  }
}

class _loginState extends State<login> {
  // final TextEditingController _controller = TextEditingController();
  Future<Album> _futureAlbum;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
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
        body:  (_futureAlbum == null)
            ? Center(
            child:Container(
              height: 400,
              width:300,
              padding:const EdgeInsets.all(0.0) ,
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
                      onPressed:

                          ()  {
                        username.text.isEmpty || password.text.isEmpty ? print('missing'):
                        print("loginnn"+username.text+" "+password.text);
                        setState(() {
                          _futureAlbum = createAlbum( username.text,password.text);
                        });



                      },
                      child: Text('login')
                  )
                ],
              ),)
        ):
        FutureBuilder<Album>(
          future: _futureAlbum,
          builder: (context, snapshot) {
            // return MaterialApp(
            //   home: MenuDashboardPage()
            // );
            if (snapshot.hasData) {
              return Text(snapshot.data.s_id);
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
