import 'package:flutter/material.dart';
import 'package:hobby/cosumetics_model.dart';
import 'package:provider/provider.dart';

class CosmeticsPage extends StatefulWidget {
  @override
  State<CosmeticsPage> createState() => CosmeticsPageState();
}

class CosmeticsPageState extends State<CosmeticsPage> {
  List<bool> _selections = List.generate(2, (_) => false);

  @override
  Widget build(BuildContext context) {
    //ChangeNotifierProviderは、変更された時にその変更を検知できる。
    return ChangeNotifierProvider<CosmeticsModel>(
      create: (_) => CosmeticsModel(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'コスメ',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        //Consumerが変更を検知して、値の設定と作り直しを行う
        body: Consumer<CosmeticsModel>(builder: (context, model, child) {
          return ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(20),
                  child: ToggleButtons(
                    children: <Widget>[
                      Icon(Icons.favorite),
                      Icon(Icons.wc),
                    ],
                    color: Colors.grey,
                    selectedColor: Colors.white,
                    fillColor: Colors.green,
                    onPressed: (int index) {
                      if (index == 0) {
                        _selections[index] = !_selections[index];
                        if (_selections[index]) {
                          model.favorite_showDialog(context, '魅力的な人に追加しました');
                        }
                      } else if (index == 1) {
                        _selections[index] = !_selections[index];
                        if (_selections[index]) {
                          model.wc_showDialog(context, '気になった投稿に追加しました');
                        }
                      }
                      ;
                    },
                    isSelected: _selections,
                  )),
            ],
          );
        }),
      ),
    );
  }
}
