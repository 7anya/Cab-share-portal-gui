class Album {
  final String s_id;
  final String name;
  final String email;
  final String phone_no,room_no,gender;

  Album({this.s_id, this.name,this.email,this.phone_no,this.room_no,this.gender});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
        s_id: json['s_id'],
        name: json['name'],
        email:json['email'],
        phone_no: json['phone_no'],
        room_no: json['room_no'],
        gender: json['gender']
    );
  }
}

