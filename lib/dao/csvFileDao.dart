import 'dart:convert';
import 'dart:io';

class FileDao {
  static Future<void> writeToCsv(String data) async{
    
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

  static Future<List<List<String>>> readFromCsv() async {
  List<List<String>> data = [];

  // final directory = await getApplicationDocumentsDirectory();
  // final filePath = "${directory.path}/houseHoldAccount.csv";

  try {
    final file = File(
        "/Users/taito/waseda2024/finalproject/lib/resources/houseHoldAccount.csv");

    if (await file.exists()) {
      List<String> lines = await file.readAsLines(encoding: utf8);

      for (String line in lines) {
        List<String> row = line.split(",");
        data.add(row);
      }
      return data;
    } else {
      print("ファイルが見つかりません。");
      return [];
    }
  } catch (e) {
    print("ファイル読み込みでエラーが発生しました。 $e");
    return [];
  }
}
}