import 'package:flutter/material.dart';
import 'Globals.dart' as Globals;

final Color backgroundColor = Colors.white;

class ResultsPage extends StatefulWidget {
  ResultsPage(this.searchResults);
  List <Globals.SearchResult> searchResults;

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> with SingleTickerProviderStateMixin {
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
          GridView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: EdgeInsets.all(20),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: widget.searchResults.length,
              itemBuilder: (BuildContext ctx, index) {
                return Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(5)),
                  child:ListTile(

                    title: Text("Name: "+widget.searchResults[index].name.toUpperCase()),
                    subtitle: Text( "Phone: "+widget.searchResults[index].phone_no+
                        "\n" +
                       "Room #: "+ widget.searchResults[index].room_no+'\n'+"Leaving between: "+widget.searchResults[index].leave_by_earliest+" and\n"+widget.searchResults[index].leave_by_latest+"\n"+widget.searchResults[index].gender),
                    // trailing: Text(widget.account.trips[index].status),
                  ),
                );
              })
          // Expanded(
          //     child: ListView.builder(
          //         scrollDirection: Axis.vertical,
          //         shrinkWrap: true,
          //         padding: const EdgeInsets.all(8),
          //         itemCount:widget.searchResults.length,
          //         itemBuilder: (BuildContext context, int index) {
          //           return Container(
          //             height: 100,
          //             // color: Colors.amber[colorCodes[index]],
          //             child:Card(
          //               child: InkWell(
          //                 splashColor: Colors.blue.withAlpha(30),
          //                 onTap: (){},
          //                 child: Container(
          //                   width: 300,
          //                   height: 100,
          //
          //                     child: Text(widget.searchResults[index].leave_by_earliest+ ' '+ widget.searchResults[index].leave_by_latest+' '+widget.searchResults[index].phone_no+''++widget.searchResults[index].gender,
          //                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          //
          //                 ),
          //               ),
          //             ),
          //           );
          //         })
          // )
        ],
      ),
    );
  }


}
