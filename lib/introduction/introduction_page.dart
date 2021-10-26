import 'package:flutter/material.dart';
import 'package:hobby/introduction/introduction_model.dart';
import 'package:provider/provider.dart';

class IntroductionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<IntroductionModel>(
      create: (_) => IntroductionModel(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            '紹介',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: Center(
          child: Consumer<IntroductionModel>(builder: (context, model, child) {
            return IconButton(
              icon: Icon(Icons.accessibility_new_sharp),
              tooltip: '画像を投稿する',
              onPressed: () async {
                model.share();
              },
            );
          }),
        ),
      ),
    );
  }
}
