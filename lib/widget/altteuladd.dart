import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:myapp/pallete.dart';

class altteulAddScreen extends StatefulWidget {
  final DatabaseReference reference;
  altteulAddScreen(this.reference);
  @override
  _altteulAddScreenState createState() => _altteulAddScreenState();
}

class _altteulAddScreenState extends State<altteulAddScreen> {
  // 각각 가지고 오고 싶은 내용에 대해서 controller 작성
  TextEditingController? whatController;
  TextEditingController? maxNumController;
  TextEditingController? curController;

  void initState() {
    super.initState();
    // 각 컨트롤러 초기화
    whatController = TextEditingController();
    maxNumController = TextEditingController();
    curController = TextEditingController();
  }

  void dispose() {
    whatController!.dispose();
    maxNumController!.dispose();
    curController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width; // 기기의 넓이
    double height = screenSize.height; // 기기의 높이

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Pallete.whiteMiddleBlue,
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
                          '알뜰 장터',
                          style: TextStyle(
                            fontSize: 30,
                            color: Pallete.darkGrey,
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
                    _buildTextField('제목', width, whatController!),
                    SizedBox(height: 20),
                    _buildTextField('종류', width, maxNumController!),
                    SizedBox(height: 20),
                    _buildTextField('위치', width, curController!),
                    SizedBox(
                      height: 20,
                    ),
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
