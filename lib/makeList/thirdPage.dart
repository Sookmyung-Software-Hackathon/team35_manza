import 'package:flutter/material.dart';

class ThirdDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String args = ModalRoute.of(context)!.settings.arguments.toString();
    //  라우터로 subDetail에서전달받은 데이터 가져오기
    return Scaffold(
      appBar: AppBar(
        title: Text('세번째'),
      ),
      body: Container(
        child: Center(
          child: Text(
            args, // 전달 받은 데이터
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
