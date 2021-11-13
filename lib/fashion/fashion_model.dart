import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hobby/chat/chat.dart';
import 'package:hobby/user.dart';

import 'hobby.dart';
import 'hobby_img.dart';

class FashionModel extends ChangeNotifier {
  String? name;
  List<Hobby>? hobbys;
  List<HobbyImg>? hobbyImg;
  List<HobbyImg>? hobbysImg;
  List<Chat>? chats;
  List<UserData> randomList = [];

  void fetchFashionList() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('hobby').get();

    final List<Hobby> hobbys = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      final String? title = data['title'];
      final String? imgURL = data['imgURL'];
      return Hobby(id, imgURL, title);
    }).toList();

    this.hobbys = hobbys;
    notifyListeners();
  }

  void fetchName() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final data = snapshot.data();
    this.name = data?['name'];

    notifyListeners();
  }

  Future<void> RandomHobbyList() async {
    final result = //QuerySnapshotをとってくる
        await FirebaseFirestore.instance.collection('users').get();
    //スナップショットに含まれるすべてのドキュメントを取得しリストに格納
    final List<DocumentSnapshot> documents = result.docs;

    //それをシャッフル
    documents.shuffle();
    //シャッフルした中の一つのデータを取得する

    final List<UserData> randomList =
        result.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      final String? name = data['name'];
      return UserData(id, name);
    }).toList();

    this.randomList = randomList;
    notifyListeners();
  }

  void getHobbySubCollection() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('hobby')
        .get();

    final List<HobbyImg> hobbyImg =
        snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      final String? title = data['title'];
      final String? imgURL = data['imgURL'];
      return HobbyImg(id, imgURL, title);
    }).toList();

    this.hobbyImg = hobbyImg;

    notifyListeners();
  }

  //shufflePageのuserDataを受け取っている
  void getHobbyRandomSubCollection(UserData userData) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userData.id)
        .collection('hobby')
        .get();

    final List<HobbyImg> hobbysImg =
        snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      final String? title = data['title'];
      final String? imgURL = data['imgURL'];
      return HobbyImg(id, imgURL, title);
    }).toList();

    this.hobbysImg = hobbysImg;

    notifyListeners();
  }

  void getChatSubCollection() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('chat')
        .get();

    final List<Chat> chats = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      final String? message = data['message'];
      final String? user_name = data['user_name'];
      return Chat(id, message, user_name);
    }).toList();

    this.chats = chats;

    notifyListeners();
  }

  Future delete(Hobby hobby) {
    return FirebaseFirestore.instance
        .collection('hobby')
        .doc(hobby.id)
        .delete();
  }

  Future favorite_showDialog(
    BuildContext context,
    String title,
  ) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future wc_showDialog(
    BuildContext context,
    String title,
  ) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future face_showDialog(
    BuildContext context,
    String title,
  ) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("衣服の紹介ページ"),
          content: Text("自分のお気に入りの洋服屋などを紹介しよう"),
          actions: <Widget>[
            // ボタン領域
            TextButton(
              child: Text(
                "閉じる",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}

Future<UserData> getRandomUser() async {
  final result = //QuerySnapshotをとってくる
      await FirebaseFirestore.instance.collection('users').get();
  //スナップショットに含まれるすべてのドキュメントを取得しリストに格納
  final List<DocumentSnapshot> documents = result.docs;

  //それをシャッフル
  documents.shuffle();
  //シャッフルした中の一つのデータを取得する

  Map<String, dynamic> data = documents.first.data() as Map<String, dynamic>;
  final String id = documents.first.id;
  final String? name = data['name'];
  //UserDataに取得したidとnameを追加
  return UserData(id, name);
}
