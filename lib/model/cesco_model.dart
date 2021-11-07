import 'package:firebase_database/firebase_database.dart';


class Cesco {
  String name;
  String desc;
  String activeTime;

  Cesco(this.name, this.desc, this.activeTime);

  Cesco.fromSnapshot(DataSnapshot snapshot)
      : name = snapshot.value['name'],
        desc = snapshot.value['desc'],
        activeTime = snapshot.value['activeTime'];

  toJson() {
    return {
      'name': name,
      'desc': desc,
      'activeTime': activeTime,
    };
  }
}