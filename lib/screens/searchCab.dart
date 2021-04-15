import 'package:flutter/material.dart';
import 'Globals.dart' as Globals;

final Color backgroundColor = Colors.white;

class CabResultsPage extends StatefulWidget {
  CabResultsPage(this.searchResults);
  List <Globals.CabSearchResult> searchResults;

  @override
  _CabResultsPageState createState() => _CabResultsPageState();
}

class _CabResultsPageState extends State<CabResultsPage> with SingleTickerProviderStateMixin {
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
                  itemCount:widget.searchResults.length,
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

                            child: Text(widget.searchResults[index].carModel+ ' '+ widget.searchResults[index].carCapacity+' '+widget.searchResults[index].driverName+''+widget.searchResults[index].driverName+" "+widget.searchResults[index].driverPhone,
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
