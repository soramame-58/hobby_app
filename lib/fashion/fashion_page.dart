import 'package:flutter/material.dart';
import 'package:hobby/camera/camera.page.dart';
import 'package:hobby/chat/chat_page.dart';
import 'package:hobby/fashion/fashion_model.dart';
import 'package:hobby/fashion/hobby_img.dart';
import 'package:hobby/myprofile/myprofile_page.dart';
import 'package:hobby/shuffle/shuffle_page.dart';
import 'package:provider/provider.dart';

//画像投稿やチャット、投稿写真の表示場所 UI完成
class FashionPage extends StatefulWidget {
  @override
  State<FashionPage> createState() => _FashionPageState();
}

class _FashionPageState extends State<FashionPage> {
  final _controller = TextEditingController();
  List<bool> _selections = List.generate(2, (_) => false);

  @override
  Widget build(BuildContext context) {
    //ChangeNotifierProviderは、変更された時にその変更を検知できる。
    return ChangeNotifierProvider<FashionModel>(
      create: (_) => FashionModel()
        ..fetchList()
        ..fetchName()
        ..UidHobbySubCollection()
        ..ChatSubCollection()
        ..likedUser()
        ..likedPost(),
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
                  model.fetchList();
                },
              );
            }),
            Consumer<FashionModel>(builder: (context, model, child) {
              return IconButton(
                icon: Icon(Icons.face_outlined),
                tooltip: '衣服の紹介',
                onPressed: () {
                  model.face_showDialog(context, '');
                },
              );
            }),
          ],
        ),
        //Consumerが変更を検知して、値の設定と作り直しを行う
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer<FashionModel>(builder: (context, model, child) {
                    return ToggleButtons(
                      children: <Widget>[
                        Icon(Icons.favorite),
                        Icon(Icons.wc),
                      ],
                      color: Colors.grey,
                      selectedColor: Colors.white,
                      fillColor: Colors.green,
                      onPressed: (int index) {
                        setState(() {
                          if (index == 0) {
                            _selections[index] = !_selections[index];
                            if (_selections[index]) {
                              model.favorite_showDialog(
                                  context, 'お気に入りの投稿に追加しました');
                            }
                          } else if (index == 1) {
                            _selections[index] = !_selections[index];
                            if (_selections[index]) {
                              model.wc_showDialog(context, '気になった投稿に追加しました');
                            }
                          }
                          ;
                        });
                      },
                      isSelected: _selections,
                    );
                  }),
                  Consumer<FashionModel>(builder: (context, model, child) {
                    return TextButton(
                      onPressed: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyPage(),
                            ));
                      },
                      child: SizedBox(
                        width: 90,
                        child: Text(
                          model.name ?? '名無し',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }),
                  SizedBox(
                    width: 25,
                    child: IconButton(
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
                  ),
                  Consumer<FashionModel>(builder: (context, model, child) {
                    return SizedBox(
                      width: 25,
                      child: IconButton(
                        icon: Icon(Icons.arrow_forward),
                        tooltip: '次のページ',
                        onPressed: () async {
                          await model.RandomList();
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => shufflePage(
                                  randomList: model.randomList,
                                ),
                              ));
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
            Expanded(
              child: Consumer<FashionModel>(builder: (context, model, child) {
                final List<HobbyImg>? hobbysImg = model.hobbyImg;

                if (hobbysImg == null) {
                  return SizedBox(
                    child: CircularProgressIndicator(),
                  );
                }

                return GridView.builder(
                  itemCount: hobbysImg.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final hobbyImg = hobbysImg[index];
                    return AspectRatio(
                      aspectRatio: 1,
                      child: Column(
                        children: [
                          Text(
                            hobbyImg.title ?? 'タイトルなし',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (hobbyImg.imgURL != null)
                            Expanded(child: Image.network(hobbyImg.imgURL!)),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
