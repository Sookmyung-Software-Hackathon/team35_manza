import 'package:firebase_database/firebase_database.dart';

class Eat {
  String food;
  String time;
  String maxNum;
  String curNum;
  String foodImg;

  Eat(this.food, this.time, this.maxNum, this.curNum, this.foodImg);

  Eat.fromSnapshot(DataSnapshot snapshot)
      : food = snapshot.value['food'],
        time = snapshot.value['time'],
        maxNum = snapshot.value['maxNum'],
        curNum = snapshot.value['curNum'],
        foodImg = snapshot.value['foodImg'];

  toJson() {
    return {
      'food': food,
      'time': time,
      'maxNum': maxNum,
      'curNum': curNum,
      'foodImg': foodImg,
    };
  }

  @override
  String toString() => "$food$maxNum";
}
