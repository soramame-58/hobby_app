import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  // Fileの＿imagesにnullが入ってくる場合がある。
  File? _image;
  final picker = ImagePicker();

  //カメラから画像を取得
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      //強制的アンラップによってオプショナル型の変数の中にどんな値が入っていても関係なく取り出す
      //null許容型をnull非許容型に変える
      _image = File(pickedFile!.path);
    });
  }

  //ギャラリーから画像を取得
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('画像投稿'),
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  heroTag: Text("btn1"),
                  onPressed: getImageFromCamera,
                  tooltip: 'Pick Image From Camera',
                  child: Icon(Icons.add_a_photo),
                ),
                FloatingActionButton(
                  heroTag: Text("btn2"),
                  onPressed: getImageFromGallery,
                  tooltip: 'Pick Image From Gallery',
                  child: Icon(Icons.photo_library),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
