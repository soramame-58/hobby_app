import 'package:flutter/material.dart';
import 'package:hobby/camera/camera_page.dart';
import 'package:hobby/chat/chat_page.dart';
import 'package:hobby/fashion/fashion_model.dart';
import 'package:hobby/hobby.dart';
import 'package:provider/provider.dart';

class FashionPage extends StatelessWidget {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //ChangeNotifierProviderは、変更された時にその変更を検知できる。
    return ChangeNotifierProvider<FashionModel>(
      create: (_) => FashionModel()..fetchFashionList(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            '衣服',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            Consumer<FashionModel>(builder: (context, model, child) {
              return IconButton(
                icon: Icon(Icons.camera_alt_outlined),
                tooltip: '画像を投稿する',
                onPressed: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CameraPage(),
                      ));
                  model.fetchFashionList();
                },
              );
            }),
            IconButton(
              icon: Icon(Icons.chat_bubble_outline),
              tooltip: '好きを共有する',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPage(_controller.text),
                    ));
              },
            ),
            Consumer<FashionModel>(builder: (context, model, child) {
              return IconButton(
                icon: Icon(Icons.face_outlined),
                tooltip: '衣服の紹介',
                onPressed: () {
                  model.face_showDialog(context, '魅力的な人に追加しました');
                },
              );
            }),
          ],
        ),
        //Consumerが変更を検知して、値の設定と作り直しを行う
        body: Consumer<FashionModel>(builder: (context, model, child) {
          final List<Hobby>? hobbys = model.hobbys;

          if (hobbys == null) {
            return CircularProgressIndicator();
          }

          return GridView.builder(
            itemCount: hobbys.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (context, index) {
              final hobby = hobbys[index];
              return InkWell(
                child: Container(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Column(
                      children: [
                        Text(
                          hobby.title ?? 'タイトルなし',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (hobby.imgURL != null)
                          Expanded(child: Image.network(hobby.imgURL!))
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
