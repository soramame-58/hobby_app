import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hobby/chat/chat_model.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  ChatPage(this._userName);

  final String _userName;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatModel>(
      create: (_) => ChatModel()..chatName(),
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'お話',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: <Widget>[
                // データを取得して画面に表示する処理
                Flexible(
                  child: StreamBuilder<QuerySnapshot>(
                    //Firestoreのstreamにdocumentのsnapshots()を取得。documentに更新があったときにリアルタイムで画面の描画を更新
                    stream: FirebaseFirestore.instance
                        .collection("chat_room")
                        .orderBy("created_at", descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return Container();
                      return ListView.builder(
                        padding: EdgeInsets.all(8.0),
                        reverse: true,
                        itemBuilder: (_, int index) {
                          DocumentSnapshot document =
                              snapshot.data!.docs[index];

                          bool isOwnMessage = false;
                          if (document['user_name'] == widget._userName) {
                            isOwnMessage = true;
                          }
                          return isOwnMessage
                              ? _ownMessage(
                                  document['message'], document['user_name'])
                              : _message(
                                  document['message'], document['user_name']);
                        },
                        itemCount: snapshot.data!.docs.length,
                      );
                    },
                  ),
                ),

                Divider(height: 1.0),
                Container(
                  margin:
                      EdgeInsets.only(bottom: 20.0, right: 10.0, left: 10.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: TextField(
                          controller: _controller,
                          onSubmitted: _handleSubmit,
                          decoration:
                              InputDecoration.collapsed(hintText: "メッセージの送信"),
                        ),
                      ),
                      Container(
                        child: IconButton(
                            icon: Icon(
                              Icons.send,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              _handleSubmit(_controller.text);
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget _ownMessage(String message, String userName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Text(userName),
            Text(message),
          ],
        ),
        Icon(Icons.person),
      ],
    );
  }

  Widget _message(String message, String userName) {
    return Row(
      children: <Widget>[
        Icon(Icons.person),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Text(userName),
            Text(message),
          ],
        )
      ],
    );
  }

  //firestoreにデータを送信する作業
  _handleSubmit(String message) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    _controller.text = "";
    var db = FirebaseFirestore.instance;
    db.collection("chat_room").add({
      "user_name": widget._userName,
      "message": message,
      "created_at": DateTime.now()
      //then関数の引数として与えたコールバック関数は、時間が掛かる関数の値処理が終わった際に実行
    }).then((value) {
      print("成功です");
      FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("chat")
          .add({
        "user_name": widget._userName,
        "message": message,
        "created_at": DateTime.now(),
      });
    }).catchError((err) {
      print(err);
    });
    ;
  }
}
