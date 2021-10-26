// import 'package:flutter/material.dart';
// import 'package:hobby/login/model.dart';
// import 'package:provider/provider.dart';
//
// class Login extends StatefulWidget {
//   @override
//   State<Login> createState() => LoginState();
// }
//
// class LoginState extends State<Login> {
//   String name = '';
//   final mailController = TextEditingController();
//   final passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     //ChangeNotifierProviderは、変更された時にその変更を検知できる。
//     return ChangeNotifierProvider<Model>(
//       create: (_) => Model(),
//       child: Scaffold(
//         appBar: AppBar(
//           iconTheme: IconThemeData(
//             color: Colors.black,
//           ),
//           backgroundColor: Colors.white,
//           title: Consumer<Model>(builder: (context, model, child) {
//             return Text(
//               model.fetchName(),
//               style: TextStyle(color: Colors.black),
//             );
//           }),
//           centerTitle: true,
//         ),
//         body: Consumer<Model>(
//           builder: (context, model, child) {
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: <Widget>[
//                   TextField(
//                     decoration: InputDecoration(
//                       hintText: 'メールアドレス',
//                     ),
//                     controller: mailController,
//                     onChanged: (text) {
//                       model.mail = text;
//                     },
//                   ),
//                   TextField(
//                     decoration: InputDecoration(
//                       hintText: 'パスワード',
//                     ),
//                     obscureText: true,
//                     controller: passwordController,
//                     onChanged: (text) {
//                       model.password = text;
//                     },
//                   ),
//                   Consumer<Model>(builder: (context, model, child) {
//                     return TextButton(
//                       child: Text(
//                         'ログインする',
//                         style: TextStyle(
//                           color: Colors.black,
//                         ),
//                       ),
//                       onPressed: () async {
//                         try {
//                           await model.login();
//                           model.login_showDialog(context, 'ログインしました');
//                         } catch (e) {
//                           model.login_showDialog(context, e.toString());
//                         }
//                       },
//                     );
//                   }),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
