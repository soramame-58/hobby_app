import 'package:flutter/material.dart';
import 'package:hobby/camera/camera_model.dart';
import 'package:hobby/fashion/fashion_page.dart';
import 'package:provider/provider.dart';

class CameraPage extends StatelessWidget {
  final titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CameraModel>(
      create: (_) => CameraModel(),
      child: Scaffold(
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
        body: SingleChildScrollView(
          child: Consumer<CameraModel>(builder: (context, model, child) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      InkWell(
                        child: SizedBox(
                          child: model.imageFile != null
                              ? Image.file(model.imageFile!)
                              : Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                        ),
                        onTap: () async {
                          print("反応！");
                          await model.pickImage();
                        },
                      ),
                      TextField(
                          decoration: InputDecoration(
                            hintText: '画像のタイトル',
                          ),
                          controller: titleController,
                          onChanged: (text) {
                            model.title = text;
                          }),
                      TextButton(
                        onPressed: () async {
                          // 追加の処理
                          try {
                            model.startLoading();
                            await model.addHobbyImage();
                            Navigator.of(context).pop(FashionPage());
                          } catch (e) {
                            final snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(e.toString()),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } finally {
                            model.endLoading();
                          }
                        },
                        child: Text(
                          '追加する',
                          style: TextStyle(
                              color: Colors.black,
                              backgroundColor: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                if (model.isLoading)
                  Container(
                    color: Colors.black54,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
