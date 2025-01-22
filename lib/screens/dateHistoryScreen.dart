import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateHistory extends StatefulWidget {
  const DateHistory({super.key});

  @override
  State<DateHistory> createState() => _DateHistoryState();
}

class _DateHistoryState extends State<DateHistory> {
  static final _dateFormatter = DateFormat("yyyy年MM月dd日");

  String category = "";
  int sum = 0;
  DateTime dateTime = DateTime.now();
  String _formattedDate = DateFormat("yyyy年MM月dd日").format(DateTime.now());
  Future<List<List<String>>> allInfo = _readFromCsv();
  List<List<String>> matchedInfo = [];

  _datePicker(BuildContext context) async {
    final DateTime? datePicked = await showDatePicker(
        locale: const Locale("ja"),
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (datePicked != null && datePicked != dateTime) {
      List<List<String>> info = await allInfo;
      List<List<String>> matched = _matchInfo(info, datePicked);
      setState(() {
        _formattedDate = DateFormat("yyyy年MM月dd日").format(datePicked);
        matchedInfo = matched;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("履歴"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 50,
              height: 30,
            ),
            Text(
              "$_formattedDate",
              style: TextStyle(fontSize: 25),
            ),
            ElevatedButton(
                onPressed: () {
                  _datePicker(context);
                },
                child: const Text("日付を選択")),
            SizedBox(
              width: 50,
              height: 40,
            ),
            Table(
              border: TableBorder.all(color: Colors.blue),
              columnWidths: const <int, TableColumnWidth>{
                0: FixedColumnWidth(50),
                1: FixedColumnWidth(100),
                2: FixedColumnWidth(100),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                  ),
                  children: [
                    Container(
                      height: 50,
                      color: Colors.lightBlueAccent,
                    ),
                    Container(
                      height: 50,
                      color: Colors.lightBlueAccent,
                      child: Center(child: Text("分類")),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      color: Colors.lightBlueAccent,
                      child: Center(child: Text("金額")),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: matchedInfo.length,
                itemBuilder: (context, index) {
                  List<String> row = matchedInfo[index];
                  return Column(
                    children: [
                      Table(
                        border: TableBorder.all(color: Colors.blue),
                        columnWidths: const <int, TableColumnWidth>{
                          0: FixedColumnWidth(50),
                          1: FixedColumnWidth(100),
                          2: FixedColumnWidth(100),
                        },
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                              color: Colors.lightBlue,
                            ),
                            children: [
                              Container(
                                height: 30,
                                color: Color.fromARGB(255, 137, 213, 248),
                                child: Center(child: Text("${index+1}")),
                              ),
                              Container(
                                height: 30,
                                color: Color.fromARGB(255, 137, 213, 248),
                                child: Center(child: Text("${row[1]}")),
                              ),
                              Container(
                                height: 30,
                                color: const Color.fromARGB(255, 137, 213, 248),
                                child: Center(child: Text("${row[2]}")),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _initializeData() async {
  List<List<String>> info = await _readFromCsv();
  setState(() {
    allInfo = Future.value(info);
    matchedInfo = _matchInfo(info, dateTime);
  });
}

  @override
  void initState(){
    super.initState();
    dateTime = DateTime.now();
    _formattedDate = DateFormat("yyyy年MM月dd日").format(dateTime);
    _initializeData();
  }

  List<List<String>> _matchInfo(List<List<String>> data, DateTime pickedDate) {
    List<List<String>> matchedInfo = [];
    for (List<String> row in data) {
      try {
        DateTime dateTime = _dateFormatter.parseStrict(row[0]);
        if (dateTime.year == pickedDate.year &&
            dateTime.month == pickedDate.month &&
            dateTime.day == pickedDate.day) {
          matchedInfo.add(row);
        }
      } catch (e) {
        print("日付の変換に失敗しました。");
      }
    }
    return matchedInfo;
  }
}

Future<List<List<String>>> _readFromCsv() async {
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
