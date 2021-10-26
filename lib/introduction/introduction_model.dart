import 'package:flutter/material.dart';
import 'package:share/share.dart';

class IntroductionModel extends ChangeNotifier {
  Future share() async {
    await Share.share("ここに共有したい文字列");
  }
}
