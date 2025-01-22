import 'package:finalproject/dao/csvFileDao.dart';
import 'package:flutter/material.dart';

class ConfirmScreen extends StatelessWidget {
  final String textPassedDate;
  final String textPassedCategory;
  final String textPassedPrice;
  const ConfirmScreen(
      {super.key,
      required this.textPassedDate,
      required this.textPassedCategory,
      required this.textPassedPrice});

  String get data => "$textPassedDate,$textPassedCategory,$textPassedPrice";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("内容の確認"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 50,
              height: 50,
            ),
            Text(
              "日付",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              width: 50,
              height: 10,
            ),
            Text(
              textPassedDate,
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              width: 50,
              height: 40,
            ),
            Text("分類", style: TextStyle(fontSize: 20)),
            SizedBox(
              width: 50,
              height: 10,
            ),
            Text(textPassedCategory, style: TextStyle(fontSize: 15)),
            SizedBox(
              width: 50,
              height: 40,
            ),
            Text("金額", style: TextStyle(fontSize: 20)),
            SizedBox(
              width: 50,
              height: 10,
            ),
            Text("$textPassedPrice 円", style: TextStyle(fontSize: 15)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            FileDao.writeToCsv(data);
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          label: const Text("登録") ,
    ),
    );
  }
}
