import 'package:finalproject/screens/contentsInfoScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

class DateInfoScreen extends StatefulWidget {
  const DateInfoScreen({super.key});

  @override
  State<DateInfoScreen> createState() => _DatePickerState();
}

class _DatePickerState extends State<DateInfoScreen> {
  DateTime dateTime = DateTime.now();
  String _formattedDate = DateFormat("yyyy年MM月dd日").format(DateTime.now());


  _datePicker(BuildContext context) async {
    final DateTime? datePicked = await showDatePicker(
      locale: const Locale("ja"),
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100));
    if(datePicked != null && datePicked != dateTime){
      setState(() {
        _formattedDate = DateFormat("yyyy年MM月dd日").format(datePicked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("日付"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$_formattedDate"),
            ElevatedButton(
              onPressed: (){
                _datePicker(context);
              },
              child: const Text("日付を選択"))
          ],
        ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context){
              return ContentsInfoScreen(textPassedDate: _formattedDate);
            },
            ),
            );
          },
          label: const Text("次へ") ,
          icon: const Icon(Icons.arrow_forward)),
    );
  }

  @override
  void initState(){
    super.initState();
    dateTime = DateTime.now();
    _formattedDate = DateFormat("yyyy年MM月dd日").format(dateTime);
  }
}