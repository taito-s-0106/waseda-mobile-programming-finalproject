import 'package:finalproject/main.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import "dart:io";

class ConfirmScreen extends StatelessWidget {
  final String textPassedDate;
  final String textPassedCategory;
  final String textPassedPrice;
  const ConfirmScreen(
      {super.key,
      required this.textPassedDate,
      required this.textPassedCategory,
      required this.textPassedPrice});

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
            _writeToCsv(context);
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context){
              return MyApp();
            },
            ),
            );
          },
          label: const Text("登録") ,
    ),
    );
  }

  Future<void> _writeToCsv(BuildContext context) async{
    
    String data = "$textPassedDate,$textPassedCategory,$textPassedPrice";
    // final directory = await getApplicationDocumentsDirectory();
    // final filePath = "${directory.path}/houseHoldAccount.csv";

    try{
    final file = File("/Users/taito/waseda2024/finalproject/lib/resources/houseHoldAccount.csv");

    if(await file.exists()){
      final existingContent = await file.readAsString();
      if(existingContent.isNotEmpty && !existingContent.endsWith("\n")){
        data = "\n$data";
      }
    }else{
      await file.create(recursive: true);
    }

    await file.writeAsString(data,mode: FileMode.append);
    print("ファイルへの書き込みが終了しました。");
    }catch(e){
      print("ファイル出力でエラーが発生しました。 $e");
    }
  }
}
