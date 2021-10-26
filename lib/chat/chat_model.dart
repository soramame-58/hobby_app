import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatModel extends ChangeNotifier {
  String name = '';

  void chatName() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final data = snapshot.data();
    this.name = data?['name'];

    notifyListeners();
  }

  Future delete(hobby) {
    return FirebaseFirestore.instance
        .collection('chat_room')
        .doc(hobby.id)
        .delete();
  }
}

//     .then((val) {
// print("成功です");
// }).catchError((err) {
// print(err);
// });
