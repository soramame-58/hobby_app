import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//firebaseにいいねをした、されたユーザーの保存
class likeModel extends ChangeNotifier {
  String stringId = '';
  String name = '';

  // いいねをつけたユーザーのID
  Future likedUser() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = FirebaseFirestore.instance
        .collection('likedUser')
        .doc(uid); // いいねをつけたユーザーのIDをまとめる

    // firestoreに追加
    await doc.set({
      'id': stringId, // いいねをつけたユーザーのID(liked_user_idと一致)
      'createdAt': Timestamp.now(),
      'name': name, // ユーザー名
    }).then((value) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("likedUser")
          .add({
        'id': stringId, // いいねをつけたユーザーのID(liked_user_idと一致)
        'createdAt': Timestamp.now(),
        'name': name, // ユーザー名
      });
    });
  }

  // 自分がいいねをつけた投稿のID
  Future likedPost() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = FirebaseFirestore.instance
        .collection('likedPost')
        .doc(uid); // いいねをつけたユーザーのIDをまとめる

    // firestoreに追加
    await doc.set({
      'id': stringId, // いいねをつけたユーザーのID(liked_user_idと一致)
      'createdAt': Timestamp.now(),
    }).then((value) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("likedPost")
          .add({
        'id': stringId, // いいねをつけたユーザーのID(liked_user_idと一致)
        'createdAt': Timestamp.now(),
      });
    });
  }
}
