import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpModel extends ChangeNotifier {
  String mail = '';
  String password = '';
  String name = '';
  int number = 0;

  final FirebaseAuth auth = FirebaseAuth.instance;
  Future signUp() async {
    if (mail.isEmpty) {
      throw ('メールアドレスを入力してください');
    }

    if (password.isEmpty) {
      throw ('パスワードを入力してください');
    }

    if (name.isEmpty) {
      throw ('名前を入力してください');
    }

    final user = (await auth.createUserWithEmailAndPassword(
      email: mail,
      password: password,
    ))
        .user;
    final uid = user!.uid;

    String id = FirebaseFirestore.instance.collection('users').doc(uid).id;

    FirebaseFirestore.instance.collection('users').doc(uid).set({
      'email': mail,
      'createdAt': Timestamp.now(),
      'name': name,
      'likePostCount': number,
      'id': id,
    });
  }
}
