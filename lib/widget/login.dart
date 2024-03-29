import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myapp/model/user.dart';
import 'package:myapp/widget/signPage.dart';
import 'package:myapp/pallete.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> with SingleTickerProviderStateMixin {
  late FirebaseDatabase _database;
  late DatabaseReference reference;
  String _databaseURL = 'https://logintest-b54c8-default-rtdb.firebaseio.com/';

  double opacity = 0;
  late AnimationController _animationController;
  late Animation _animation;
  late TextEditingController _idTextController;
  late TextEditingController _pwTextController;

  @override
  void initState() {
    super.initState();

    _idTextController = TextEditingController();
    _pwTextController = TextEditingController();

    _animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    _animation =
        Tween<double>(begin: 0, end: pi * 2).animate(_animationController);
    _animationController.repeat();
    Timer(Duration(seconds: 2), () {
      setState(() {
        opacity = 1;
      });
    });

    _database = FirebaseDatabase(databaseURL: _databaseURL);
    reference = _database.reference().child('user');
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, widget) {
                  return Transform.rotate(
                    angle: _animation.value,
                    child: widget,
                  );
                },
                child: Icon(
                  Icons.home,
                  color: Colors.deepOrangeAccent,
                  size: 80,
                ),
              ),
              SizedBox(
                height: 100,
                child: Center(
                  child: Text(
                    '만능자취',
                    style: TextStyle(fontSize: 30, fontFamily: 'SB'),
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: opacity,
                duration: Duration(seconds: 1),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: _idTextController,
                        maxLines: 1,
                        decoration: InputDecoration(
                            hintText: '4자 이상 입력해주세요',
                            hintStyle: TextStyle(fontFamily: 'PT'),
                            labelStyle: TextStyle(fontFamily: 'PT'),
                            labelText: '아이디',
                            border: OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: _pwTextController,
                        obscureText: true,
                        maxLines: 1,
                        decoration: InputDecoration(
                            hintText: '6자 이상 입력해주세요',
                            hintStyle: TextStyle(fontFamily: 'PT'),
                            labelStyle: TextStyle(fontFamily: 'PT'),
                            labelText: '비밀번호',
                            border: OutlineInputBorder()),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        TextButton(
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     new MaterialPageRoute(
                              //         builder: (context) => new SignPage()));
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SignPage()));
                            },
                            child: Text('회원가입')),
                        TextButton(
                            onPressed: () {
                              if (_idTextController.value.text.length == 0 ||
                                  _pwTextController.value.text.length == 0) {
                                makeDialog('빈칸이 있습니다');
                              } else {
                                reference
                                    .child(_idTextController.value.text)
                                    .onValue
                                    .listen((event) {
                                  if (event.snapshot.value == null) {
                                    makeDialog('아이디가 없습니다');
                                  } else {
                                    reference
                                        .child(_idTextController.value.text)
                                        .onChildAdded
                                        .listen((event) {
                                      User user =
                                          User.fromSnapshot(event.snapshot);
                                      var bytes = utf8
                                          .encode(_pwTextController.value.text);
                                      var digest = sha1.convert(bytes);
                                      if (user.pw == digest.toString()) {
                                        Navigator.of(context)
                                            .pushReplacementNamed('/main',
                                                arguments: _idTextController
                                                    .value.text);
                                      } else {
                                        makeDialog('비밀번호가 틀립니다');
                                      }
                                    });
                                  }
                                });
                              }
                            },
                            child: Text('로그인'))
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )
                  ],
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }

  void makeDialog(String text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(text),
          );
        });
  }
}
