import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Model extends ChangeNotifier {
  String mail = '';
  String password = '';

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

  Future<String> getData(
    String collection,
    String documentId,
  ) async {
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection(collection)
        .doc(documentId)
        .get();
    Map<String, dynamic> names = docSnapshot.data as Map<String, dynamic>;
    return names[documentId];
  }

  Future<DocumentSnapshot> getUid() async {
    var firebaseUser = FirebaseAuth.instance.currentUser!;
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .get();
  }

  Future login_showDialog(
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
}
