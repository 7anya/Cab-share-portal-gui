import 'package:flutter/material.dart';
import './ResultsPage.dart';
final Color backgroundColor = Colors.white;

class MenuDashboardPage extends StatefulWidget {
  @override
  _MenuDashboardPageState createState() => _MenuDashboardPageState();
}

class _MenuDashboardPageState extends State<MenuDashboardPage> with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                Text("Dashboard", style: TextStyle(color: Colors.black, fontSize: 22)),
                SizedBox(height: 10),
                Text("Messages", style: TextStyle(color: Colors.black, fontSize: 22)),
                SizedBox(height: 10),
                Text("Utility Bills", style: TextStyle(color: Colors.black, fontSize: 22)),
                SizedBox(height: 10),
                Text("Funds Transfer", style: TextStyle(color: Colors.black, fontSize: 22)),
                SizedBox(height: 10),
                Text("Branches", style: TextStyle(color: Colors.black, fontSize: 22)),
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
                        child: Icon(Icons.menu, color: Colors.blue),
                        onTap: () {
                          setState(() {
                            if (isCollapsed)
                              _controller.forward();
                            else
                              _controller.reverse();

                            isCollapsed = !isCollapsed;
                          });
                        },
                      ),
                      Text("My Trips", style: TextStyle(fontSize: 24, color: Colors.black)),
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
                                child:RaisedButton(
                                  child: Text("Request a partner"),
                                  onPressed: (){
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return ResultsPage() ;
                                        },
                                      ),
                                    );
                                  },

                                ) ,
                              ),
                              Container(
                                margin: EdgeInsets.all(2),
                                child:RaisedButton(
                                  child: Text("Browse Trips"),
                                  onPressed: (){},

                                ) ,
                              ),
                              Container(
                                margin: EdgeInsets.all(2),
                                child:RaisedButton(
                                  child: Text("Find a cab"),
                                  onPressed: (){
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return ResultsPage() ;
                                        },
                                      ),
                                    );
                                  },

                                ) ,
                              ),
                              Container(
                                margin: EdgeInsets.all(30),
                                child:RaisedButton(
                                  child: Text("Browse Trips"),
                                  onPressed: (){
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return ResultsPage() ;
                                        },
                                      ),
                                    );
                                  },

                                ) ,
                              ),
                            ],
                          ),

                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("Transactions", style: TextStyle(color: Colors.white, fontSize: 20),),
                  ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text("27/10/2020"),
                          subtitle: Text("From campus to airport"),
                          trailing: Text("Patners found"),
                        );
                      }, separatorBuilder: (context, index) {
                    return Divider(height: 16);
                  }, itemCount: 10)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
