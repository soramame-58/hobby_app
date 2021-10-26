import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../fashion/hobby.dart';

class EditHobbyModel extends ChangeNotifier {
  final Hobby hobby;
  EditHobbyModel(this.hobby) {
    titleController.text = hobby.title ?? 'null';
  }

  final titleController = TextEditingController();

  String? title;

  void setTitle(String title) {
    this.title = title;
    notifyListeners();
  }

  bool isUpdated() {
    return title != null;
  }

  Future update() async {
    this.title = titleController.text;

    // firestoreに追加
    await FirebaseFirestore.instance.collection('hobbys').doc(hobby.id).update({
      'title': title,
    });
  }
}
