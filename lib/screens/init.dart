import 'package:flutter/material.dart';
import 'package:login_page/screens/Register.dart';
import 'package:login_page/screens/adminLogin.dart';
import 'package:login_page/screens/login.dart';

class initScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var options = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
            width: 250,
            child: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return Register();
                  }));
                },
                child: Card(
                    color: Colors.lightBlueAccent,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 10, 20),
                            child: Icon(Icons.app_registration,
                                size: 50, color: Colors.white)),
                        Padding(
                            padding: EdgeInsets.fromLTRB(10, 20, 20, 20),
                            child: Text(
                              'Register',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ))
                      ],
                    )))),
        Container(
            width: 250,
            child: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return adminLogin();
                  }));
                },
                child: Card(
                    color: Colors.lightBlueAccent,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 10, 20),
                            child: Icon(Icons.app_registration,
                                size: 50, color: Colors.white)),
                        Padding(
                            padding: EdgeInsets.fromLTRB(10, 20, 20, 20),
                            child: Text(
                              'Admin Login',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ))
                      ],
                    )))),
        Container(
            width: 250,
            child: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return login();
                  }));
                },
                child: Card(
                    color: Colors.lightBlueAccent,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 10, 20),
                            child: Icon(Icons.app_registration,
                                size: 50, color: Colors.white)),
                        Padding(
                            padding: EdgeInsets.fromLTRB(10, 20, 20, 20),
                            child: Text(
                              'Student Login',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ))
                      ],
                    ))))
      ],
    );

    var leftPanel = Container(
      // width: MediaQuery.of(context).size.width / 3.3,
      // height: MediaQuery.of(context).size.height,
      color: Colors.yellow[600],
      child: Padding(
        padding: EdgeInsets.only(top: 70.0, right: 50.0, left: 50.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: Column(
            children: <Widget>[
              Container(
                child: CircleAvatar(
                  backgroundColor: Colors.black87,
                  backgroundImage: NetworkImage(
                    'https://upload.wikimedia.org/wikipedia/en/thumb/d/d3/BITS_Pilani-Logo.svg/1024px-BITS_Pilani-Logo.svg.png',
                  ),
                  radius: 70.0,
                ),
              ),
              SizedBox(
                height: 60.0,
              ),
              Container(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Text(
                  "Welcome to BPHC cab share portal! Please register here.",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Text(
                  "Find people to share a cab with based on your travel schedule painlessly",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                child: CircleAvatar(
                  backgroundColor: Colors.black87,
                  child: Text(
                    ">",
                    style: TextStyle(color: Colors.yellow),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return Scaffold(
        backgroundColor: Colors.blue[50],
        body: Padding(
            padding: EdgeInsets.only(
                top: 60.0, bottom: 60.0, left: 120.0, right: 120.0),
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0)),
                elevation: 5.0,
                child: Container(
                    child: Flex(
                        direction: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                      Expanded(flex: 1, child: leftPanel),
                      Expanded(
                          flex: 2,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [options]))
                    ])))));
  }
}
