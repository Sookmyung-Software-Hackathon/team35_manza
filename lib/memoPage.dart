import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'widget/memoAdd.dart';
import 'model/memo.dart';
import 'memoDetail.dart';

class MemoPage extends StatefulWidget {
  @override
  _MemoPageState createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  FirebaseDatabase? _database;
  DatabaseReference? reference;
  String _databaseURL = 'https://together-1bd8d-default-rtdb.firebaseio.com/';
  List<Memo> memos = new List.empty(growable: true);
  // 메모 목록을 나타낼 리스트 선언

  @override
  void initState() {
    // 위에서 객체를 선언하고 초기화함.
    super.initState();
    _database = FirebaseDatabase(databaseURL: _databaseURL);
    reference = _database!.reference().child('memo');
    // 데이터 베이스에 memo라는 컬렉션을 만드는 코드이다.
    // 이 컬렉션 안에 데이터를 쓰거나 읽어올 예정

    reference!.onChildAdded.listen((event) {
      // 데이터베이스에 데이터가 추가 되면 자동으로 실행
      //데이터 베이스에 추가된 데이터를 가져오는 코드를 작성
      print(event.snapshot.value.toString());
      setState(() {
        memos.add(Memo.fromSnapshot(event.snapshot));

        // 함수를 이용해 데이터를 간단하게 추가 할 수 있음.
      });
    });
  }

  // 따라서! 앱을 처음 실행하면 데이터베이스에 저장된 데이터를 차례로 가져와서 memos 리스트에 추가합니다.
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('각 카테고리 제목 작성'),
      ),
      body: Container(
        child: Center(
          child: memos.length == 0
              ? CircularProgressIndicator()
              // 데이터 베이스에서 불러올 데이터가 없을 경우
              // 데이터 베이스가 있을 경우, 그리드뷰
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    // 정형화된 그리드뷰
                    crossAxisCount: 2,

                    //열 개수
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                      child: GridTile(
                        child: Container(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: SizedBox(
                            child: GestureDetector(
                              onTap: () async {
                                Memo? memo = await Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            MemoDetailPage(
                                                reference!, memos[index])));
                                if (memo != null) {
                                  setState(() {
                                    memos[index].title = memo.title;
                                    memos[index].content = memo.content;
                                  });
                                }
                                // 여기에 메모 상세보기 화면으로 이동 추가
                              },
                              onLongPress: () {
                                // 여기에 길게 클릭시 메모 삭제 기능 추가 예정
                              },
                              child: Text(memos[index].content.toString()),
                            ),
                          ),
                        ),
                        header: Text(memos[index].title.toString()),
                        footer: Text(memos[index].createTime!.substring(0, 10)),
                      ),
                    );
                  },
                  itemCount: memos.length,
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MemoAddPage(reference!)));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
