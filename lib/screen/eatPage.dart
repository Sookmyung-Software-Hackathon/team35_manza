import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myapp/model/eat.dart';
import 'package:myapp/widget/eatAdd.dart';

import '../pallete.dart';

class EatScreen extends StatefulWidget {
  List<Widget> items = new List.empty(growable: true);

  @override
  _EatScreenState createState() => _EatScreenState();
}

class _EatScreenState extends State<EatScreen> {
  FirebaseDatabase? _databasee;
  DatabaseReference? referencee;
  String _databaseURL = 'https://together-673c8-default-rtdb.firebaseio.com/';
  List<Eat> eats = new List.empty(growable: true);

  void initState() {
    super.initState();
    _databasee = FirebaseDatabase(databaseURL: _databaseURL);
    referencee = _databasee!.reference().child('eat');

    referencee!.onChildAdded.listen((event) {
      print(event.snapshot.value.toString());
      setState(() {
        eats.add(Eat.fromSnapshot(event.snapshot));
      });
    });
  }

  final TextEditingController _filter =
      TextEditingController(); // 검색 위젯 컨트롤하는 위젯
  FocusNode focusNode = FocusNode(); // 현재 검색 위젯에 커서가 있는지에 대한 상태 등을 가지고 있는 위젯
  String _searchText = ""; // = _filter.text

  _PetScreenState() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //Size screenSize = MediaQuery.of(context).size;
    //double width = screenSize.width; // 기기의 넓이
    //double height = screenSize.height; // 기기의 높이

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 50,
          backgroundColor: Pallete.whiteBlue,
          centerTitle: true,
          title: Text(
            '밥친구',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'SB',
              color: Colors.white,
              letterSpacing: 20,
            ),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                height: 70,
                color: Colors.grey[200],
                padding: EdgeInsets.fromLTRB(10, 10, 5, 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: TextField(
                        focusNode: focusNode,
                        style: TextStyle(
                          fontSize: 13,
                        ),
                        //autofocus: true,
                        controller: _filter,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 17,
                          ),
                          // 우측에 배치될 아이콘
                          suffixIcon: focusNode.hasFocus
                              ? IconButton(
                                  icon: Icon(
                                    Icons.cancel,
                                    size: 17,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _filter.clear();
                                      _searchText = "";
                                    });
                                  },
                                )
                              : Container(),
                          hintText: '검색',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
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
                      ),
                    ),
                    focusNode.hasFocus
                        ? Expanded(
                            child: TextButton(
                              child: Text(
                                '취소',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                              onPressed: () {
                                _filter.clear();
                                _searchText = "";
                                focusNode.unfocus();
                              },
                            ),
                          )
                        : Expanded(
                            flex: 0, // 다른 위젯에 비해 크기 0배
                            child: Container(),
                          ),
                  ],
                ),
              ),
              Expanded(
                child: _buildListView(context, eats, _searchText),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Pallete.darkBlue,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => eatAddPage(referencee!)));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

ListView _buildListView(
    BuildContext context, List<Eat> eat, String searchText) {
  return ListView.builder(
    itemBuilder: (context, index) {
      return _buildListWidget(context, index, eat, searchText);
    },
    itemCount: eat.length,
  );
}

Widget _buildListWidget(
    BuildContext context, int index, List<Eat> eat, String searchText) {
  Size screenSize = MediaQuery.of(context).size;
  double width = screenSize.width;
  double height = screenSize.height;

  return eat[index].toString().contains(searchText)
      ? Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 7,
          color: Pallete.whiteMiddleBlue,
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 0, 15, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 15, 10, 2),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(eat[index].foodImg),
                        radius: 40.0,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 15, 30, 15),
                      child: Container(
                        width: width * 0.3,
                        child: AutoSizeText(
                          eat[index].food +
                              "\n" +
                              "time: " +
                              eat[index].time +
                              "\n" +
                              "maxnum: " +
                              eat[index].maxNum +
                              "\n" +
                              "curnum: " +
                              eat[index].curNum,
                          style: TextStyle(fontFamily: 'SB'),
                        ),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  padding: EdgeInsets.fromLTRB(50, 20, 10, 0),
                  icon: Icon(
                    Icons.chat,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {},
                  alignment: Alignment.centerRight, //채팅앱으로 Navigator.push0
                ),
              ],
            ),
          ),
        )
      : Container();
}
