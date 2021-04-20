import 'package:flutter/material.dart';
import 'Globals.dart' as Globals;
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dashboard.dart';

final Color backgroundColor = Colors.white;

class ResultsPage extends StatefulWidget {
  ResultsPage(this.searchResults, this.tripid,this.account);
  Globals.Account account;

  List<Globals.CabSearchResult> searchResults;
  String tripid;

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage>
    with SingleTickerProviderStateMixin {
  Future<bool> linkcab(String car_no, String trip_id) async {
    final response = await http.post(
      Uri.http('127.0.0.1:5000', 'linkcab'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode(<String, String>{
        'trip_id': trip_id,
        'car_no':car_no,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to create album.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xfff7c4dff),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return MenuDashboardPage(widget.account);
                      },
                    ),
                  );
                },
                icon: Icon(Icons.exit_to_app))
          ],
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
                  child: ListTile(
                    onTap: () {
                      linkcab(widget.searchResults[index].car_no,widget.tripid);
                    },
                    title: Text("Driver name: " +
                        widget.searchResults[index].driverName),
                    subtitle: Text("Phone: " +
                        widget.searchResults[index].driverPhone +
                        "\n" +
                        "Car model: " +
                        widget.searchResults[index].carModel +
                        '\n' +
                        "Car capacity: " +
                        widget.searchResults[index].carCapacity +
                        "\nCar number: " +
                        widget.searchResults[index].car_no),
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
