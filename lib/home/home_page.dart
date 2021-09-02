import 'package:flutter/material.dart';
import 'package:hobby/cook_page.dart';
import '../bike_page.dart';
import '../book_page.dart';
import '../car_page.dart';
import '../cosmetics_page.dart';
import '../fashion_page.dart';
import '../game_page.dart';
import '../hotel_page.dart';
import '../movie_page.dart';
import '../music_page.dart';
import '../outdoor_page.dart';
import '../spa_page.dart';

class HomePage extends StatelessWidget {
  List<String> imageUrl = [
    'http://livedoor.blogimg.jp/gyu2/imgs/f/4/f4f2f802.jpg',
    'https://i.pinimg.com/originals/d2/dd/31/d2dd3184d2b0934a0e4286d27ad0f622.jpg',
    'https://pics.prcm.jp/3e5856b46b9d8/83955630/jpeg/83955630_190x291.jpeg',
    'https://picture.goobike.com/850/8503292/SG7/8503292B3020072500200.jpg',
    'https://p0.pikist.com/photos/946/383/car-old-vintage-renault-renault-8-green-retro.jpg',
    'https://cdn.mainichi.jp/vol1/2021/04/18/20210418ddlk28040365000p/9.jpg?1',
    'https://i.pinimg.com/736x/f0/f2/9a/f0f29aca0fb61b1869fbc7f25bb43ee6.jpg',
    'https://livedoor.blogimg.jp/karapaia_zaeega/imgs/6/e/6e437928.jpg',
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
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            '好きなもの紹介',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: GridView.builder(
          itemCount: 12,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if (index == 0) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FashionPage(),
                      ));
                }
                if (index == 1) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CosmeticsPage(),
                      ));
                }
                if (index == 2) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CookPage(),
                      ));
                }
                if (index == 3) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BikePage(),
                      ));
                }
                if (index == 4) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CarPage(),
                      ));
                }
                if (index == 5) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SpaPage(),
                      ));
                }
                if (index == 6) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookPage(),
                      ));
                }
                if (index == 7) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MoviePage(),
                      ));
                }
                if (index == 8) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MusicPage(),
                      ));
                }
                if (index == 9) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GamePage(),
                      ));
                }
                if (index == 10) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OutdoorPage(),
                      ));
                }
                if (index == 11) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HotelPage(),
                      ));
                }
              },
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
    );
  }
}
