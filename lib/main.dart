import 'package:flutter/material.dart';
import 'package:login_page/screens/init.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  var title = "Login";

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: '$title',
      debugShowCheckedModeBanner: false,
      home: initScreen(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
