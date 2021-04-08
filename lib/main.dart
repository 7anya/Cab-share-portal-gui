import 'package:flutter/material.dart';
import 'package:login_page/screens/Register.dart';
import 'screens/dashboard.dart';
import 'package:login_page/screens/login.dart';
import 'package:login_page/screens/request_partner.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  var title = "Login";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "$title",
      debugShowCheckedModeBanner: false,
      home:Register(),

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

    );
  }
}
// import 'dart:async';
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// Future<Album> createAlbum(String title) async {
//   final response = await http.post(
//     Uri.https('jsonplaceholder.typicode.com', 'albums'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'title': title,
//     }),
//   );
//
//   if (response.statusCode == 201) {
//     return Album.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Failed to create album.');
//   }
// }
//
// class Album {
//   final int id;
//   final String title;
//
//   Album({this.id, this.title});
//
//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       id: json['id'],
//       title: json['title'],
//     );
//   }
// }
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   MyApp({Key key}) : super(key: key);
//
//   @override
//   _MyAppState createState() {
//     return _MyAppState();
//   }
// }
//
// class _MyAppState extends State<MyApp> {
//   final TextEditingController _controller = TextEditingController();
//   Future<Album> _futureAlbum;
//   TextEditingController username = TextEditingController();
//   TextEditingController password = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Create Data Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Create Data Example'),
//         ),
//         body:  (_futureAlbum == null)
//             ? Center(
//             child:Container(
//               height: 400,
//               width:300,
//               padding:const EdgeInsets.all(0.0) ,
//               child: Column(
//                 children: [
//                   Text("Login"),
//                   TextFormField(
//                     controller: username,
//                     decoration: const InputDecoration(
//                       icon: Icon(Icons.person),
//                       hintText: 'Username',
//                       labelText: 'Username*',
//                     ),
//
//                   ),
//                   TextFormField(
//                     // autofocus: false,
//                     obscureText: true,
//                     controller: password,
//                     decoration: const InputDecoration(
//                       icon: Icon(Icons.person),
//                       hintText: 'password',
//                       labelText: 'Password*',
//                     ),
//
//
//                   ),
//                   ElevatedButton(
//                       onPressed:
//
//                           ()  {
//                         username.text.length==0 || password.text.length==0 ? print("missing"):
//                         print("loginnn"+username.text+" "+password.text);
//                         setState(() {
//                           _futureAlbum = createAlbum( username.text);
//                         });
//
//
//
//                       },
//                       child: Text("login")
//                   )
//                 ],
//               ),)
//         ):
//         FutureBuilder<Album>(
//         future: _futureAlbum,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return Text(snapshot.data.title);
//           } else if (snapshot.hasError) {
//             return Text("${snapshot.error}");
//           }
//
//           return CircularProgressIndicator();
//         },
//       ),
//         ),
//
//     );
//   }
// }
