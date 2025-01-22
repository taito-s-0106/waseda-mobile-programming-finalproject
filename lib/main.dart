import 'package:finalproject/screens/dateInfoScreen.dart';
import 'package:finalproject/screens/dateHistoryScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "家計簿アプリ",
      home: Home(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("家計簿アプリ"),
          backgroundColor: Colors.lightBlueAccent,
        ),
        body: Center(
          child: Column(children: [
            SizedBox(
              width: 20,
              height: 20,
            ),
            Text(
              "家計簿管理アプリです。",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              width: 20,
              height: 50,
            ),
            Text("メニューの中から選択してください。",
            style: TextStyle(fontSize: 15,),),
            SizedBox(
              width: 20,
              height: 100,
            ),
            SizedBox(
              width: 300,
              height: 100,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return DateInfoScreen();
                  }));
                },
                style: ButtonStyle(),
                child: Text("新規入力"),
              ),
            ),
            SizedBox(
              width: 20,
              height: 100,
            ),
            SizedBox(
              width: 300,
              height: 100,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return DateHistory();
                  }));
                },
                style: ButtonStyle(),
                child: Text("履歴確認"),
              ),
              ),
          ]),
        ),
      );
  }
}
