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
  String car_no, driverName,driverPhone, carCapacity, carModel,trip_id;
  CabSearchResult(this.driverName,this.driverPhone,this.carCapacity,this.carModel,this.car_no,this.trip_id);


}