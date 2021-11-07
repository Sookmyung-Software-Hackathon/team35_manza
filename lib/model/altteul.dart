import 'package:firebase_database/firebase_database.dart';

class Altteul {
  String what;
  String maxNum;
  String curNum;

  Altteul(this.what, this.maxNum, this.curNum);

  Altteul.fromSnapshot(DataSnapshot snapshot)
      : what = snapshot.value['what'],
        maxNum = snapshot.value['maxNum'],
        curNum = snapshot.value['curNum'];

  toJson() {
    return {
      'what': what,
      'maxNum': maxNum,
      'curNum': curNum,
    };
  }

  @override
  String toString() => "$what$maxNum";
}
