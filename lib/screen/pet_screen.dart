import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myapp/model/pet.dart';
import 'package:myapp/widget/petAdd.dart';

import '../pallete.dart';
//import 'package:google_fonts/google_fonts.dart';
//import 'package:hackathon/model/model.dart';

class PetScreen extends StatefulWidget {
  List<Widget> items = new List.empty(growable: true);

  @override
  _PetScreenState createState() => _PetScreenState();
}

class _PetScreenState extends State<PetScreen> {
  FirebaseDatabase? _databasep;
  DatabaseReference? referencep;
  String _databaseURL = 'https://together-673c8-default-rtdb.firebaseio.com/';
  List<Pet> pets = new List.empty(growable: true);

  void initState() {
    super.initState();
    _databasep = FirebaseDatabase(databaseURL: _databaseURL);
    referencep = _databasep!.reference().child('pet');

    referencep!.onChildAdded.listen((event) {
      print(event.snapshot.value.toString());
      setState(() {
        pets.add(Pet.fromSnapshot(event.snapshot));
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
            'ga chi eat ha ja',
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
                child: _buildListView(context, pets, _searchText),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => petAddPage(referencep!)));
          },
          backgroundColor: Pallete.darkBlue,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

ListView _buildListView(
    BuildContext context, List<Pet> pet, String searchText) {
  return ListView.builder(
    itemBuilder: (context, index) {
      return _buildListWidget(context, index, pet, searchText);
    },
    itemCount: pet.length,
  );
}

Widget _buildListWidget(
    BuildContext context, int index, List<Pet> pet, String searchText) {
  Size screenSize = MediaQuery.of(context).size;
  double width = screenSize.width;
  double height = screenSize.height;

  return pet[index].toString().contains(searchText)
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
                        backgroundImage: AssetImage(pet[index].image),
                        radius: 40.0,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 15, 30, 15),
                      child: Container(
                        width: width * 0.3,
                        child: AutoSizeText("\n" +
                                pet[index].req +
                                "animal sort: " +
                                pet[index].animal +
                                "\n" +
                                "location: " +
                                pet[index].location +
                                "\n" +
                                "time: " +
                                pet[index].time
                            /* style: GoogleFonts.amita(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),*/
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
