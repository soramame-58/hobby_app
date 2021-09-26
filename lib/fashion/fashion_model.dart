import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../hobby.dart';

class FashionModel extends ChangeNotifier {
  List<Hobby>? hobbys;

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
