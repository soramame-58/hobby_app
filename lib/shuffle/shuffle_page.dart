import 'package:flutter/material.dart';
import 'package:hobby/camera/camera_page.dart';
import 'package:hobby/chat/chat_page.dart';
import 'package:hobby/fashion/fashion_model.dart';
import 'package:hobby/fashion/hobby_img.dart';
import 'package:hobby/random_img.dart';
import 'package:hobby/user.dart';
import 'package:provider/provider.dart';

class shufflePage extends StatefulWidget {
  //UserData型のuserDataを宣言する
  final UserData userData;
  final RandomImg randomImg;

  //初期化のためにkeyとuserDateをコンストラクタで渡す
  //thisとすることで宣言したuserDataを指す
  const shufflePage({Key? key, required this.userData, required this.randomImg})
      : super(key: key);
  @override
  shufflePageState createState() => shufflePageState();
}

class shufflePageState extends State<shufflePage> {
  final _controller = TextEditingController();
  List<bool> _selections = List.generate(2, (_) => false);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FashionModel>(
      create: (_) => FashionModel()
        ..fetchFashionList()
        ..fetchName()
        ..getHobbySubCollection()
        ..getChatSubCollection(),
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
                                  context, '魅力的な人に追加しました');
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
                    return SizedBox(
                      width: 90,
                      child: Text(
                        widget.userData.name!,
                        style: TextStyle(fontWeight: FontWeight.bold),
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
                          //押した時に最初にユーザーランダムして欲しいから一番に書く
                          final userData = await model.getRandomUser();
                          final randomImg = await model.getRandomHobby();
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => shufflePage(
                                  //上記でrequiredとしているため,ここに引数を追記する必要がある
                                  userData: userData,
                                  randomImg: randomImg,
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
                    height: 10.0,
                    width: 10.0,
                  );
                }

                return GridView.builder(
                  itemCount: hobbysImg.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) {
                    final hobbyImg = hobbysImg[index];
                    return InkWell(
                      child: Container(
                        child: AspectRatio(
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
                                Expanded(
                                    child: Image.network(hobbyImg.imgURL!)),
                            ],
                          ),
                        ),
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
