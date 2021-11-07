import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myapp/model/exercise.dart';
import 'package:myapp/widget/exerciseAdd.dart';

import '../pallete.dart';

class ExerScreen extends StatefulWidget {
  @override
  _ExerScreenState createState() => _ExerScreenState();
}

class _ExerScreenState extends State<ExerScreen> {
  FirebaseDatabase? _databasex;
  DatabaseReference? referencex;
  String _databaseURL = 'https://together-673c8-default-rtdb.firebaseio.com/';
  List<Exercise> exercises = new List.empty(growable: true);
  void initState() {
    super.initState();
    _databasex = FirebaseDatabase(databaseURL: _databaseURL);
    referencex = _databasex!.reference().child('exercise');

    referencex!.onChildAdded.listen((event) {
      print(event.snapshot.value.toString());
      setState(() {
        exercises.add(Exercise.fromSnapshot(event.snapshot));
      });
    });
  }

  final TextEditingController _filter =
      TextEditingController(); // 검색 위젯 컨트롤하는 위젯
  FocusNode focusNode = FocusNode(); // 현재 검색 위젯에 커서가 있는지에 대한 상태 등을 가지고 있는 위젯
  String _searchText = ""; // = _filter.text

  _ExerScreenState() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width; // 기기의 넓이
    double height = screenSize.height; // 기기의 높이

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: width * 0.1,
          backgroundColor: Pallete.whiteBlue,
          centerTitle: true,
          title: Text(
            '운동하숙',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
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
                child: _buildListView(context, exercises, _searchText),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ExerAddScreen(referencex!)));
          },
          backgroundColor: Pallete.whiteBlue,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

ListView _buildListView(
    BuildContext context, List<Exercise> exers, String searchText) {
  return ListView.builder(
    itemBuilder: (context, index) {
      return _buildListWidget(context, index, exers, searchText);
    },
    itemCount: exers.length,
  );
}

Widget _buildListWidget(
    BuildContext context, int index, List<Exercise> exers, String searchText) {
  return exers[index].toString().contains(searchText)
      ? Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 7,
          color: Pallete.whiteMiddleBlue,
          child: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Container()));
            },
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 15, 10, 0),
                    child: AutoSizeText(
                      exers[index].title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Pallete.darkGrey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 30, 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AutoSizeText(
                          exers[index].kind +
                              "\t/\t" +
                              exers[index].location +
                              "\t/\t" +
                              exers[index].time +
                              "\t/\t" +
                              exers[index].maxNum.toString() +
                              "\t(" +
                              exers[index].curNum.toString() +
                              ")",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Pallete.darkGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      : Container();
}
