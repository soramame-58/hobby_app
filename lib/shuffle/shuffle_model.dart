import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class shuffleModel extends ChangeNotifier {
  void getUsersName() async {
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection('users').get();
    final List<DocumentSnapshot> documents = result.docs;

    documents.shuffle();

    notifyListeners();
  }
}
