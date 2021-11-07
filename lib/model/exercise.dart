import 'package:firebase_database/firebase_database.dart';



class Exercise{
  String title;
  String kind;
  String location;
  String time;
  String maxNum;
  String curNum;

  Exercise(this.title, this.kind, this.location,this.time, this.maxNum, this.curNum);

  Exercise.fromSnapshot(DataSnapshot snapshot)
      : title = snapshot.value['title'],
        kind = snapshot.value['kind'],
        location = snapshot.value['location'],
        time = snapshot.value['time'],
        maxNum = snapshot.value['maxNum'],
        curNum = snapshot.value['curNum'];

  toJson() {
    return{
      'title': title,
      'kind': kind,
      'location': location,
      'time': time,
      'maxNum': maxNum,
      'curNum': curNum,
    };
  }

  @override
  String toString() => "$title$maxNum$curNum";
}
