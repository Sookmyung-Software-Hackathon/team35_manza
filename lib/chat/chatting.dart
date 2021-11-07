// import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';
// import 'package:myapp/chat/chat_message.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class Chatting extends StatefulWidget {
//   @override
//   _ChattingState createState() => _ChattingState();
// }

// class _ChattingState extends State<Chatting> {
//   TextEditingController controller = TextEditingController();
//   FirebaseFirestore firestore = FirebaseFirestore.instance;

//   List<ChatMessage> chats = [];

//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return fetchData(context);
//   }

//   Widget fetchData(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: firestore.collection('chat').snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return LinearProgressIndicator();
//         return ListView.builder(
//             itemBuilder: (context, index) =>
//                 _buildBody(context, snapshot.data!.docs[index]));
//       },
//     );
//   }

//   Widget _buildBody(BuildContext context, QueryDocumentSnapshot snapshot) {
//     return Column(
//       children: [
//         Expanded(
//           child: ListView.builder(
//             itemBuilder: (context, index) {
//               return chats[index];
//             },
//             // itemCount: chats.length,
//             // itemCount: snapshot.data.documents.length,
//             reverse: true,
//           ),
//         ),
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 15),
//           child: Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   onSubmitted: handleSubmitting,
//                   controller: controller,
//                   decoration: InputDecoration(
//                     hintText: '메시지 보내기',
//                   ),
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   handleSubmitting(controller.text);
//                 },
//                 child: Text('전송'),
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.amber,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   void handleSubmitting(String text) {
//     Logger().d(text);
//     controller.clear();
//     setState(() {
//       ChatMessage newChat = ChatMessage(text: text);
//       chats.insert(0, newChat);
//     });
//     // animListKey.currentState!.insertItem(0);
//   }
// }
