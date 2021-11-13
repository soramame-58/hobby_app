import 'package:flutter/material.dart';
import 'package:hobby/camera/camera_page.dart';
import 'package:hobby/chat/chat_page.dart';
import 'package:hobby/fashion/fashion_model.dart';
import 'package:hobby/fashion/hobby_img.dart';
import 'package:hobby/user.dart';
import 'package:provider/provider.dart';

class shufflePage extends StatefulWidget {
  //UserData型のuserDataを宣言する
  final List<UserData> randomList;
  //初期化のためにkeyとuserDateをコンストラクタで渡す
  //thisとすることで宣言したuserDataを指す
  const shufflePage({Key? key, required this.randomList}) : super(key: key);
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
        //fashionPageの画面遷移時にuserDataを渡しているからstatefulの場合は、widget.userDataでidを取得できる
        ..getHobbyRandomSubCollection(widget.randomList.first)
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
                        widget.randomList.first.name!,
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
                          widget.randomList.removeAt(0);
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => shufflePage(
                                  randomList: widget.randomList,
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
                final List<HobbyImg>? hobbysImg = model.hobbysImg;

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
