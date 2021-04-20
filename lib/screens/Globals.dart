import 'dart:js';

import 'package:flutter/material.dart';

class Student {
  String s_id;
  String name;
  String email;
  String phone_no,room_no,gender;
  Student({this.s_id, this.name,this.email,this.phone_no,this.room_no,this.gender});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        s_id: json['s_id'],
        name: json['name'],
        email:json['email'],
        phone_no: json['phone_no'],
        room_no: json['room_no'],
        gender: json['gender']
    );
  }
}

class Trip
{
  String leave_by_earliest;
  String leave_by_latest;
  String location,destination;
  String status;
  String tripid;
  Trip(this.leave_by_earliest, this.leave_by_latest, this.location, this.destination, this.status,this.tripid);

}

class Account
{
  Student user= Student();
  List <Trip> trips= [];
  static Account currentAccount;

}
class SearchResult
{
  String leave_by_earliest;
  String leave_by_latest;
  String location,destination;
  String s_id;
  String name;
  String email;
  String phone_no,room_no,gender;
  SearchResult(this.s_id,this.name,this.email,this.phone_no,this.room_no,this.gender,this.leave_by_latest,this.leave_by_earliest,this.destination,this.location,);
}
class CabSearchResult
{
  String car_no, driverName,driverPhone, carCapacity, carModel;
  CabSearchResult(this.driverName,this.driverPhone,this.carCapacity,this.carModel,this.car_no);


}

bool checkID(String id_no)
{
  // return RegExp('\b201.[AB][1-7][PT]')
  return  RegExp(r'^[2][0]([1][56789]|[2][0])([A][1234578A]|[B][12345])([A][1234578A]|[B][12345]|[P][S]|[T][S])[0-9]{4}[PGH]').hasMatch(id_no);
}
  bool checkCarno(String car_no)
  {
    return  RegExp(r'^[A-Z]{2}[ -][0-9]{2}[ -][A-Z]{1,2}[ -][0-9]{4}$').hasMatch(car_no);
  }
  bool checkString(String name )
  {
    return  RegExp(r'^[a-zA-Z ]+$').hasMatch(name);
  }
  bool email(String email)
  {
   return  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }
  bool gender(String gen)
  {
    gen=gen.toLowerCase();
    return gen=='female' || gen=='male' || gen=='non binary';
  }
  bool phone(String phone)
  {
    return  RegExp(r'^[1-9][0-9]{9}$').hasMatch(phone);
  }
  bool checknum(String number)
  {
    return RegExp(r'^[0-9]+$').hasMatch(number);
  }
  Future<void> showError(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text('Error'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[Text("Error: invalid entry")],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('ok'),
              ),
            ],
          );
        });
      },
    );
  }
