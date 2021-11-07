import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:myapp/pallete.dart';
import '../model/eat.dart';

class eatAddPage extends StatefulWidget {
  final DatabaseReference referencee;
  eatAddPage(this.referencee);
  @override
  _eatAddPageState createState() => _eatAddPageState();
}

class _eatAddPageState extends State<eatAddPage> {
  // 각각 가지고 오고 싶은 내용에 대해서 controller 작성
  TextEditingController? foodController;
  TextEditingController? timeController;
  TextEditingController? maxNumController;
  TextEditingController? curController;
  TextEditingController? foodImgController;

  void initState() {
    super.initState();
    // 각 컨트롤러 초기화
    foodController = TextEditingController();
    timeController = TextEditingController();
    maxNumController = TextEditingController();
    curController = TextEditingController();
    foodImgController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width; // 기기의 넓이
    double height = screenSize.height; // 기기의 높이

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.whiteBlue,
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
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Pallete.whiteBlue,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(243, 243, 243, 1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '밥친구',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    _buildTextField('제목', width, foodController!),
                    SizedBox(height: 20),
                    _buildTextField('날짜', width, timeController!),
                    SizedBox(height: 20),
                    _buildTextField('최대인원', width, maxNumController!),
                    SizedBox(height: 20),
                    _buildTextField('현재인원', width, curController!),
                    SizedBox(height: 20),
                    _buildTextField(
                        'food image file name', width, foodImgController!),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          child: Text(
                            'Save',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Pallete.darkBlue,
                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          ),
                          onPressed: () {
                            widget.referencee
                                .push()
                                .set(Eat(
                                        foodController!.value.text,
                                        timeController!.value.text,
                                        maxNumController!.value.text,
                                        curController!.value.text,
                                        foodImgController!.value.text)
                                    .toJson())
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
            color: Pallete.whiteMiddleGrey,
            fontWeight: FontWeight.bold,
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
}
