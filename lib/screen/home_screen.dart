import 'package:flutter/material.dart';
import 'package:myapp/screen/altteulPage.dart';
import 'package:myapp/screen/cesco.dart';
import 'package:myapp/screen/eatPage.dart';
import 'package:myapp/screen/exercisePage.dart';
import 'package:myapp/screen/pet_screen.dart';
import 'package:flutter/painting.dart';
import 'package:myapp/pallete.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        //자동으로 햄버거 메뉴 생성
        child: ListView(
          padding: EdgeInsets.zero, //패딩 필요없어서 0으로
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('images/icon_sm.png'),
              ),
              accountName: Text('눈송이'),
              accountEmail: Text('noonsong@sookmyung.ac.kr'),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          '만능자취',
          style: TextStyle(
              color: Pallete.darkBlue, fontFamily: 'SB', fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Pallete.whiteMiddleBlue,
        elevation: 0.0,
      ),
      body: Container(
        color: Pallete.whiteMiddleBlue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        elevation: 0.0,
                        minimumSize: Size(400, 100),
                        primary: Pallete.whiteBlue,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                // Container 위제 대신 PetScreen
                                builder: (context) => CescoScreen()));
                      },
                      child: Text(
                        '벌레퇴치',
                        style: TextStyle(
                          fontFamily: 'SB',
                          fontSize: 18,
                          color: Pallete.darkBlue,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        primary: Pallete.whiteBlue,
                        elevation: 0.0,
                        minimumSize: Size(400, 100),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                // Container 위제 대신 PetScreen
                                builder: (context) => PetScreen()));
                      },
                      child: Text(
                        '대리돌봄',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'SB',
                          color: Pallete.darkBlue,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        primary: Pallete.whiteBlue,
                        elevation: 0.0,
                        minimumSize: Size(400, 100),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                // Container 위제 대신 PetScreen
                                builder: (context) => ExerScreen()));
                      },
                      child: Text(
                        '운동파트너',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'SB',
                          color: Pallete.darkBlue,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        primary: Pallete.whiteBlue,
                        elevation: 0.0,
                        minimumSize: Size(400, 100),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AltteulScreen()));
                      },
                      child: Text(
                        '알뜰',
                        style: TextStyle(
                          fontSize: 18,
                          color: Pallete.darkBlue,
                          fontFamily: 'SB',
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        primary: Pallete.whiteBlue,
                        elevation: 0.0,
                        minimumSize: Size(400, 100),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                // Container 위제 대신 PetScreen
                                builder: (context) => EatScreen()));
                      },
                      child: Text(
                        '밥친구',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'SB',
                          color: Pallete.darkBlue,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
