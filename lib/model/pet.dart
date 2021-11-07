import 'package:firebase_database/firebase_database.dart';

class Pet {
  // String pic;

  String req;
  String location;
  String animal;
  String time;
  String image;

  Pet(this.req, this.location, this.animal, this.time, this.image);

  Pet.fromSnapshot(DataSnapshot snapshot)
      : req = snapshot.value['req'],
        location = snapshot.value['location'],
        animal = snapshot.value['animal'],
        time = snapshot.value['time'],
        image = snapshot.value['image'];

  toJson() {
    return {
      'req': req,
      'location': location,
      'animal': animal,
      'time': time,
      'image': image,
    };
  }

  @override
  String toString() => "$animal$req";
}
