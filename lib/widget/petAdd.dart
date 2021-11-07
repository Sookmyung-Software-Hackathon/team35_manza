import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:myapp/pallete.dart';
import '../model/pet.dart';

class petAddPage extends StatefulWidget {
  final DatabaseReference referencep;
  petAddPage(this.referencep);
  @override
  _petAddPageState createState() => _petAddPageState();
}

class _petAddPageState extends State<petAddPage> {
  // 각각 가지고 오고 싶은 내용에 대해서 controller 작성
  TextEditingController? reqController;
  TextEditingController? locationController;
  TextEditingController? animalController;
  TextEditingController? timeController;
  TextEditingController? imageController;

  void initState() {
    super.initState();
    // 각 컨트롤러 초기화
    reqController = TextEditingController();
    locationController = TextEditingController();
    animalController = TextEditingController();
    timeController = TextEditingController();
    imageController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width; // 기기의 넓이
    double height = screenSize.height; // 기기의 높이
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.1,
        backgroundColor: Pallete.whiteMiddleBlue,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); //textfield에서 바깥 아무곳 누르면 키보드내리기
        },
        child: Container(
          color: Pallete.whiteMiddleBlue,
          padding: EdgeInsets.all(30),
          child: Center(
            child: Container(
              width: width * 0.8,
              padding: EdgeInsets.fromLTRB(30, 25, 30, 20),
              decoration: BoxDecoration(
                color: Pallete.whiteBlue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Title',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _buildTextField('제목', width, reqController!),
                    SizedBox(height: 20),
                    _buildTextField('장소', width, locationController!),
                    SizedBox(height: 20),
                    _buildTextField('동물', width, animalController!),
                    SizedBox(height: 20),
                    _buildTextField('시간', width, timeController!),
                    SizedBox(height: 20),
                    _buildTextField('image file name', width, imageController!),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.black87,
                          ),
                          onPressed: () {
                            widget.referencep
                                .push()
                                .set(Pet(
                                  reqController!.value.text,
                                  locationController!.value.text,
                                  animalController!.value.text,
                                  timeController!.value.text,
                                  imageController!.value.text,
                                ).toJson())
                                .then((_) {
                              Navigator.of(context).pop();
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildTextField(
    String text, double width, TextEditingController controller) {
  return Container(
    height: 55,
    width: width * 0.7,
    child: TextField(
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        hintText: text,
        hintStyle: TextStyle(
          fontSize: 15,
        ),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      controller: controller,
    ),
  );
}
