import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraModel extends ChangeNotifier {
  File? imageFile;
  String? title;
  bool isLoading = false;
  String? imgURL;

  final picker = ImagePicker();

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future addHobbyImage() async {
    if (title == null || title == "") {
      throw 'タイトルが入力されていません';
    }

    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = FirebaseFirestore.instance.collection('hobby').doc(uid);
    if (imageFile != null) {
      // storageにアップロード
      final task = await FirebaseStorage.instance
          .ref('hobby/${doc.id}')
          .putFile(imageFile!);
      imgURL = await task.ref.getDownloadURL();
    }

    // firestoreに追加
    await doc.set({
      'title': title,
      'imgURL': imgURL,
    }).then((value) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("hobby")
          .add({
        "imgURL": imgURL,
        "title": title,
      });
    });
  }

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }
}
