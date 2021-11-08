import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hobby/fashion/hobby_img.dart';
import 'package:hobby/random_img.dart';

class shuffleModel extends ChangeNotifier {
  List<HobbyImg>? hobbyImg;

  void getHobbySubCollection() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc()
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
}
