import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraModel extends StatelessWidget {
  File? _image;
  final picker = ImagePicker();
  //ギャラリーから画像を取得
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    //強制的アンラップによってオプショナル型の変数の中にどんな値が入っていても関係なく取り出す
    //null許容型をnull非許容型に変える
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Text(
          '画像投稿',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                    width: 300,
                    child: _image == null
                        ? Text('No image selected.')
                        : Image.file(_image!)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: getImage,
                  child: Text(
                    '画像投稿',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
