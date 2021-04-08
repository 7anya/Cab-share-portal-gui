import 'package:flutter/material.dart';

final Color backgroundColor = Colors.white;

class ResultsPage extends StatefulWidget {
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> with SingleTickerProviderStateMixin {
List <String> name = ["John", "harry", "Tom","Polycarp","Vanya"];
List <String> from=["Campus","Campus","Campus","Campus","Campus"];
List <String> to=["Airport","Airport","Airport","Airport","Airport"];
List <String> phone=["923839292","923839292","923839292","923839292","923839292"];
List <String> time=["1600-1620","1610-1630","1620-1630","1620-1640","1615-1625",];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xfff7c4dff),
          title: Row(
            children: [
              Text("Search Results "),
            ],
          )),
      backgroundColor: backgroundColor,
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            child:  Text("date:12/04/2021   time:1600-1630"),
          ),

          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount:name.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 100,
                      // color: Colors.amber[colorCodes[index]],
                      child:Card(
                        child: InkWell(
                          splashColor: Colors.blue.withAlpha(30),
                          onTap: (){},
                          child: Container(
                            width: 300,
                            height: 100,

                              child: Text(name[index]+"                  Phone: "+phone[index]+"               trip:"+from[index]+ " to "+to[index]+"              time:"+time[index],
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),

                          ),
                        ),
                      ),
                    );
                  })
          )
        ],
      ),
    );
  }


}
