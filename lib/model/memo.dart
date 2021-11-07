import 'package:firebase_database/firebase_database.dart';

class Memo {
  // 각각 목록 가져오면 됨
  String? key;
  String? title;
  String? content;
  String? createTime;

  Memo(this.title, this.content, this.createTime);

  Memo.fromSnapshot(DataSnapshot snapshot)
  // 데이터 베이스에서 데이터를 가져올 때 memo 클래스의 변수에 넣어줌
      : key = snapshot.key,
        title = snapshot.value['title'],
        content = snapshot.value['content'],
        createTime = snapshot.value['createTime'];

  toJson() {
    return {
      'title': title,
      'content': content,
      'createTime': createTime,
    };
  }
}


