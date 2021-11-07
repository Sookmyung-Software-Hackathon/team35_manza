import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myapp/model/cesco_model.dart';
import 'package:myapp/widget/cescoAdd.dart';

import '../pallete.dart';

class CescoScreen extends StatefulWidget {
  @override
  _CescoScreenState createState() => _CescoScreenState();
}

class _CescoScreenState extends State<CescoScreen> {
  final TextEditingController _filter = TextEditingController();
  FocusNode focusNode = FocusNode();
  String _searchText = "";

  _CescoScreenState() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  }

  FirebaseDatabase? _databasec;
  DatabaseReference? referencec;
  String _databaseURL = 'https://together-673c8-default-rtdb.firebaseio.com/';
  List<Cesco> cescos = new List.empty(growable: true);

  @override
  void initState() {
    // 위에서 객체를 선언하고 초기화함.
    super.initState();
    _databasec = FirebaseDatabase(databaseURL: _databaseURL);
    referencec = _databasec!.reference().child('cesco');
    // 데이터 베이스에 memo라는 컬렉션을 만드는 코드이다.
    // 이 컬렉션 안에 데이터를 쓰거나 읽어올 예정

    referencec!.onChildAdded.listen((event) {
      // 데이터베이스에 데이터가 추가 되면 자동으로 실행
      //데이터 베이스에 추가된 데이터를 가져오는 코드를 작성
      print(event.snapshot.value.toString());
      setState(() {
        cescos.add(Cesco.fromSnapshot(event.snapshot));

        // 함수를 이용해 데이터를 간단하게 추가 할 수 있음.
      });
    });
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          backgroundColor: Pallete.whiteBlue,
          centerTitle: true,
          title: Text(
            '세스코',
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
                        controller: _filter,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 17,
                          ),
                          //우측에 배치될 아이콘

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
                            flex: 0,
                            child: Container(),
                          ),
                  ],
                ),
              ),
              Expanded(
                child: _buildListView(context, cescos, _searchText),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CescoAddScreen(referencec!)));
          },
          backgroundColor: Pallete.whiteBlue,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

ListView _buildListView(
    BuildContext context, List<Cesco> cescoscreen, String searchText) {
  return ListView.builder(
    itemBuilder: (context, index) {
      return _buildListWidget(context, index, cescoscreen, searchText);
    },
    itemCount: cescoscreen.length,
  );
}

Widget _buildListWidget(BuildContext context, int index,
    List<Cesco> cescoscreen, String searchText) {
  return cescoscreen[index].toString().contains(searchText)
      ? Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 7,
          color: Pallete.whiteMiddleBlue,
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 10, 30, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 15, 10, 0),
                      child: AutoSizeText(
                        cescoscreen[index].name,
                        style: TextStyle(
                          color: Pallete.darkGrey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
                      icon: Icon(
                        Icons.chat,
                        color: Colors.white,
                      ),
                      onPressed: () {}, //채팅앱으로 Navigator.push0
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AutoSizeText(
                      cescoscreen[index].desc.toString() +
                          "\t/\t" +
                          cescoscreen[index].activeTime.toString(),
                      style: TextStyle(
                        color: Pallete.darkGrey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      : Container();
}
