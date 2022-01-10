import 'package:flutter/material.dart';
import 'package:hobby/editprofile/editprofile_page.dart';
import 'package:hobby/myprofile/myprofile_model.dart';
import 'package:provider/provider.dart';

//自己紹介画面
class MyPage extends StatelessWidget {
  List<String> imageUrl = [
    'http://livedoor.blogimg.jp/gyu2/imgs/f/4/f4f2f802.jpg',
    'https://i.pinimg.com/originals/d2/dd/31/d2dd3184d2b0934a0e4286d27ad0f622.jpg',
    'https://pics.prcm.jp/3e5856b46b9d8/83955630/jpeg/83955630_190x291.jpeg',
    'https://picture.goobike.com/850/8503292/SG7/8503292B3020072500200.jpg',
    'https://p0.pikist.com/photos/946/383/car-old-vintage-renault-renault-8-green-retro.jpg',
    'https://cdn.mainichi.jp/vol1/2021/04/18/20210418ddlk28040365000p/9.jpg?1',
    'https://capa.getnavi.jp/wps/wp-content/uploads/2020/10/201012jcii02.jpg',
    'https://cdn.iecolle.com/img/884c05d86a98c9e/ic/-/375x375/s/shop.r10s.jp/nipinter/cabinet/03100215/imgrc0063989603.jpg',
    'http://rooftop.cc/news/assets_c/2015/09/ARTKT-008_fix-thumb-450x450-47952.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDdZ29z6I9azNn5gjFyLtJQZkBeEyc6E6Vjg&usqp=CAU',
    'https://waha.sixcore.jp/waha-illust/640wm/vol.15/15-0710b.jpg',
    'https://static.amanaimages.com/imgroom/rf_preview640/10822/10822000055.jpg',
  ];

  List<String> titleComment = [
    '衣服',
    'コスメ',
    '食',
    'バイク',
    '車',
    '温泉',
    '本',
    '映画',
    '音楽',
    'ゲーム',
    'アウトドア',
    '宿',
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyModel>(
      create: (_) => MyModel()..fetchUser(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            '私',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            Consumer<MyModel>(builder: (context, model, child) {
              return IconButton(
                onPressed: () async {
                  // 画面遷移
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(),
                    ),
                  );
                  model.fetchUser();
                },
                icon: Icon(Icons.edit),
              );
            }),
          ],
        ),
        body: Column(
          children: [
            Center(
              child: Consumer<MyModel>(builder: (context, model, child) {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            model.name ?? '名前なし',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(model.email ?? 'メールアドレスなし'),
                          Text(
                            model.description ?? '自己紹介なし',
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
            Expanded(
              child: GridView.builder(
                itemCount: 12,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Container(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Column(
                          children: [
                            Text(titleComment[index]),
                            Expanded(child: Image.network(imageUrl[index]))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
