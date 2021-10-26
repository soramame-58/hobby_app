import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier {
  String mail = '';
  String password = '';
  String name = '';
  String collection = '';
  String documentId = '';

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future login() async {
    if (mail.isEmpty) {
      throw ('メールアドレスを入力してください');
    }

    if (password.isEmpty) {
      throw ('パスワードを入力してください');
    }

    final signIn = await auth.signInWithEmailAndPassword(
      email: mail,
      password: password,
    );
    return signIn.user!.uid;
  }

  Future<String> fetchName() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').get();
    String name = (snapshot.docs.first.data() as Map<String, dynamic>)['name'];
    return name;
  }

  Future<DocumentSnapshot> getUid() async {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .get();
  }
}
