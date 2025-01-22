import 'package:finalproject/service/dropDownButton.dart';
import 'package:finalproject/screens/confirmScreen.dart';
import 'package:flutter/material.dart';

class ContentsInfoScreen extends StatefulWidget {
  final String textPassedDate;

  const ContentsInfoScreen({super.key,required this.textPassedDate});

  @override
  State<ContentsInfoScreen> createState() => _ContentsInfoScreenState();
}

class _ContentsInfoScreenState extends State<ContentsInfoScreen> {
  String price = "";
  String selectedCategory = "食費";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("内容を入力"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 30,
              height: 150,
            ),
            Text(
              "分類",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            DropdownButtonMenu(
              onChanged: (value){
                setState(() {
                  selectedCategory = value;
                });
              },
            ),
            SizedBox(
              width: 30,
              height: 70,
            ),
            Text("金額"),
            Padding(
              padding: const EdgeInsets.fromLTRB(100, 30, 100, 30),
              child: TextFormField(
                decoration: InputDecoration(border: OutlineInputBorder()),
                onChanged: (value) {
                  setState(() {
                    price = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context){
              return ConfirmScreen(
                textPassedDate: widget.textPassedDate, 
                textPassedCategory: selectedCategory, 
                textPassedPrice: price);
            },
            ),
            );
          },
          label: const Text("次へ") ,
          icon: const Icon(Icons.arrow_forward)),
    );
  }
}
