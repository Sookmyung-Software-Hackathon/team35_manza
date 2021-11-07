import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:myapp/pallete.dart';

class CescoAddScreen extends StatefulWidget {
  final DatabaseReference reference;
  CescoAddScreen(this.reference);
  @override
  _CescoAddScreenState createState() => _CescoAddScreenState();
}

class _CescoAddScreenState extends State<CescoAddScreen> {
  // 각각 가지고 오고 싶은 내용에 대해서 controller 작성
  TextEditingController? nameController;
  TextEditingController? decsController;
  TextEditingController? actController;

  void initState() {
    super.initState();
    // 각 컨트롤러 초기화
    nameController = TextEditingController();
    decsController = TextEditingController();
    actController = TextEditingController();
  }

  void dispose() {
    nameController!.dispose();
    decsController!.dispose();
    actController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width; // 기기의 넓이
    double height = screenSize.height; // 기기의 높이

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.1,
        backgroundColor: Pallete.whiteBlue,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); //textfield에서 바깥 아무곳 누르면 키보드내리기
        },
        child: Container(
          color: Pallete.whiteBlue,
          padding: EdgeInsets.all(30),
          child: Center(
            child: Container(
              width: width * 0.8,
              padding: EdgeInsets.fromLTRB(30, 25, 30, 20),
              decoration: BoxDecoration(
                color: Pallete.whiteMiddleBlue,
                borderRadius: BorderRadius.circular(20),
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
                          'Title',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _buildTextField('이름', width, nameController!),
                    SizedBox(height: 20),
                    _buildTextField('내용', width, decsController!),
                    SizedBox(height: 20),
                    _buildTextField('시간', width, actController!),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                          child: Text(
                            'Save',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(67, 116, 217, 1),
                            ),
                          ),
                          onPressed: () {},
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
